package brewbuddy.services;

import brewbuddy.exceptions.NotFoundException;
import brewbuddy.models.*;
import brewbuddy.repositories.UserBeerLoggerRepository;
import brewbuddy.services.interfaces.ICouponService;
import brewbuddy.services.interfaces.IFestivalService;
import brewbuddy.repositories.FestivalRepository;
import brewbuddy.services.interfaces.IUserService;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class FestivalService implements IFestivalService {
    private final FestivalRepository festivalRepository;
    private final UserBeerLoggerRepository userBeerLoggerRepository;

    private final IUserService userService;
    private final ICouponService couponService;
    private final KieContainer kieContainer;

    private final BeerService beerService;

    @Autowired
    public FestivalService(KieContainer kieContainer, FestivalRepository festivalRepository,
                           UserBeerLoggerRepository userBeerLoggerRepository, IUserService userService,
                           ICouponService couponService, BeerService beerService) {
        this.festivalRepository = festivalRepository;
        this.kieContainer = kieContainer;
        this.userBeerLoggerRepository = userBeerLoggerRepository;
        this.userService = userService;
        this.couponService = couponService;
        this.beerService = beerService;
    }

    @Override
    public Festival get(Integer id) {
        Optional<Festival> festival = festivalRepository.findById(id);
        if (festival.isPresent()) {
            return festival.get();
        } else {
            throw new NotFoundException("Beer does not exist");
        }
    }

    @Override
    public List<Festival> getAll() {
        return festivalRepository.findAll();
    }

    @Override
    public Festival insert(Festival festival) {

        Festival newFestival = festivalRepository.save(festival);
        KieSession kieSession = kieContainer.newKieSession("couponKsession");
        ArrayList<FestivalCoupon> coupons = new ArrayList<>();
        kieSession.setGlobal("coupons", coupons);
        kieSession.insert(newFestival);
        kieSession.insert(userService.getAll());
        kieSession.insert(userBeerLoggerRepository.findAll());
        coupons = (ArrayList<FestivalCoupon>) kieSession.getGlobal("coupons");
        for (FestivalCoupon coupon : coupons) {
            couponService.insert(coupon);
        }
        return newFestival;
    }

    @Override
    public List<Festival> recommend(Integer userId) {
        User user= userService.get(userId);

        KieSession kieSession = kieContainer.newKieSession("recommendationKsession");
        HashMap<Integer, Integer> festivalsMap = new HashMap<>();
        kieSession.setGlobal("festivalsMap", festivalsMap);

        for (Beer beer : beerService.recommend(user.getId())) {
            kieSession.insert(new StringWrapper("Brewery-" + beer.getBrewery().getId().toString(), "Beer-" + beer.getId().toString(), "Beer"));
            for (Festival festival : festivalRepository.getFestivalsByBreweries(beer.getBrewery().getId())){
                kieSession.insert(new StringWrapper("Festival-" + festival.getId().toString(), "Brewery-" + beer.getBrewery().getId().toString(), "Festival"));
            }
        }
        kieSession.fireAllRules();

        festivalsMap = (HashMap<Integer, Integer>) kieSession.getGlobal("festivalsMap");
        List<Map.Entry<Integer, Integer>> entryList = new ArrayList<>(festivalsMap.entrySet());
        entryList.sort((e1, e2) -> e2.getValue().compareTo(e1.getValue()));
        ArrayList<Festival> sortedFestivals = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : entryList) {
            if (entry.getValue()>=2) {
                sortedFestivals.add(get(entry.getKey()));
            }
        }
        return sortedFestivals;
    }
}
