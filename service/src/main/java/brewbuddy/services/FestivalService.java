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
import java.util.stream.Collectors;

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
        KieSession kieSession = kieContainer.newKieSession("festivalKsession");
        kieSession.getAgenda().getAgendaGroup("festivalCoupons").setFocus();
        ArrayList<FestivalCoupon> coupons = new ArrayList<>();
        kieSession.setGlobal("coupons", coupons);
        kieSession.insert(newFestival);
        kieSession.insert(userService.getAll());
        kieSession.insert(userBeerLoggerRepository.findAll());
        coupons = (ArrayList<FestivalCoupon>) kieSession.getGlobal("coupons");
        for (FestivalCoupon coupon : coupons) {
            couponService.insert(coupon);
        }
        kieSession.fireAllRules();
        return newFestival;
    }

    @Override
    public List<Festival> recommend(Integer userId) {
        User user = userService.get(userId);

        KieSession kieSession = kieContainer.newKieSession("festivalKsession");
        kieSession.getAgenda().getAgendaGroup("festivalRecommendation").setFocus();

        for (Beer beer : beerService.recommend(user.getId())) {
            kieSession.insert(new StringWrapper("Brewery-" + beer.getBrewery().getId().toString(), "Beer-" + beer.getId().toString(), "Beer"));
            for (Festival festival : festivalRepository.getFestivalsByBreweries(beer.getBrewery())){
                kieSession.insert(new StringWrapper(festival.getId().toString(), "Brewery-" + beer.getBrewery().getId().toString(), "Festival"));
            }
        }
        HashMap<Integer, Integer> festivalsMap = new HashMap<>();
        kieSession.setGlobal("festivalsMap", festivalsMap);
        kieSession.fireAllRules();

        festivalsMap = (HashMap<Integer, Integer>) kieSession.getGlobal("festivalsMap");
        return festivalsMap.entrySet()
                .stream()
                .sorted(Map.Entry.<Integer, Integer>comparingByValue().reversed())
                .map(entry -> get(entry.getKey()))
                .collect(Collectors.toList());
    }
}
