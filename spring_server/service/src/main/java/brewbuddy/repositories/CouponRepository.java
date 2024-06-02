package brewbuddy.repositories;

import brewbuddy.models.Coupon;
import brewbuddy.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CouponRepository extends JpaRepository<Coupon,Integer> {
    List<Coupon> findCouponsByUser(User user);
}
