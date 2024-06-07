package brewbuddy.services.interfaces;

import brewbuddy.models.*;

import java.util.List;

public interface ICouponService {
    Coupon get(Integer id);

    List<Coupon> getAll();

    Coupon insert(Coupon coupon);


    List<CouponCriteria> getCriterias();

    List<FestivalCoupon> createFestivalCoupon(Festival festival, CouponCriteria inputCriteria);

    List<BreweryCoupon> createBreweryCoupon(Brewery brewery, CouponCriteria inputCriteria);

    List<ApplicationCoupon> createAppCoupon(CouponCriteria inputCriteria);

    List<Coupon> getUserCoupons(User user);
}
