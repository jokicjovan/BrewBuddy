package brewbuddy.services;

import brewbuddy.exceptions.NotFoundException;
import brewbuddy.models.Festival;
import brewbuddy.models.FestivalCoupon;
import brewbuddy.repositories.UserBeerLoggerRepository;
import brewbuddy.services.interfaces.ICouponService;
import brewbuddy.services.interfaces.IFestivalService;
import brewbuddy.repositories.FestivalRepository;
import brewbuddy.services.interfaces.IUserService;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class FestivalService implements IFestivalService {
    private final FestivalRepository festivalRepository;
    private final UserBeerLoggerRepository userBeerLoggerRepository;

    private final IUserService userService;
    private final ICouponService couponService;
    private final KieContainer kieContainer;

    @Autowired
    public FestivalService(KieContainer kieContainer, FestivalRepository festivalRepository, UserBeerLoggerRepository userBeerLoggerRepository,IUserService userService,ICouponService couponService) {
        this.festivalRepository = festivalRepository;
        this.kieContainer = kieContainer;
        this.userBeerLoggerRepository = userBeerLoggerRepository;
        this.userService=userService;
        this.couponService=couponService;
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

        Festival newFestival=festivalRepository.save(festival);
        KieSession kieSession = kieContainer.newKieSession("couponKsession");
        ArrayList<FestivalCoupon> coupons = new ArrayList<>();
        kieSession.setGlobal("coupons", coupons);
        kieSession.insert(newFestival);
        kieSession.insert(userService.getAll());
        kieSession.insert(userBeerLoggerRepository.findAll());
        coupons = (ArrayList<FestivalCoupon>)  kieSession.getGlobal("coupons");
        for (FestivalCoupon coupon: coupons){
            couponService.insert(coupon);
        }
        return newFestival;
    }
}
