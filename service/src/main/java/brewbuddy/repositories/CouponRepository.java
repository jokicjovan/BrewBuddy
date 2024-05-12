package brewbuddy.repositories;

import brewbuddy.model.Coupon;
import brewbuddy.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CouponRepository extends JpaRepository<Coupon,Integer> {
}
