package brewbuddy.services;

import brewbuddy.exceptions.NotFoundException;
import brewbuddy.models.Coupon;
import brewbuddy.services.interfaces.ICouponService;
import brewbuddy.repositories.CouponRepository;
import org.kie.api.runtime.KieContainer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CouponService implements ICouponService {
    private final CouponRepository couponRepository;
    private final KieContainer kieContainer;

    @Autowired
    public CouponService(KieContainer kieContainer, CouponRepository couponRepository) {
        this.couponRepository = couponRepository;
        this.kieContainer = kieContainer;
    }
    @Override
    public Coupon get(Integer id) {
        Optional<Coupon> coupon = couponRepository.findById(id);
        if (coupon.isPresent()) {
            return coupon.get();
        } else {
            throw new NotFoundException("Coupon does not exist");
        }
    }

    @Override
    public List<Coupon> getAll() {
        return couponRepository.findAll();
    }

    @Override
    public Coupon insert(Coupon coupon) {
        return couponRepository.save(coupon);
    }
}
