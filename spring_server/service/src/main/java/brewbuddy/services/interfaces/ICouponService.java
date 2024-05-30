package brewbuddy.services.interfaces;

import brewbuddy.models.*;

import java.util.List;

public interface ICouponService {
    Coupon get(Integer id);

    List<Coupon> getAll();

    Coupon insert(Coupon coupon);

    List<FestivalCoupon> createFestivalCoupon(Festival festival);

    List<BreweryCoupon> createBreweryCoupon(Brewery brewery);

    List<ApplicationCoupon> createAppCoupon();
}
