package brewbuddy.services.interfaces;

import brewbuddy.model.Coupon;

import java.util.List;

public interface ICouponService {
    Coupon get(Integer id);

    List<Coupon> getAll();

    Coupon insert(Coupon coupon);
}
