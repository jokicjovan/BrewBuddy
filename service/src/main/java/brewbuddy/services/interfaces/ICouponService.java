package brewbuddy.services.interfaces;

import brewbuddy.models.Coupon;

import java.util.List;

public interface ICouponService {
    Coupon get(Integer id);

    List<Coupon> getAll();

    Coupon insert(Coupon coupon);
}
