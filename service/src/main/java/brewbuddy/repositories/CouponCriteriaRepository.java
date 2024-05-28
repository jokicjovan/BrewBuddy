package brewbuddy.repositories;

import brewbuddy.models.CouponCriteria;
import brewbuddy.models.enums.CouponType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CouponCriteriaRepository extends JpaRepository<CouponCriteria,Integer> {
    public CouponCriteria findCouponCriteriaByType(CouponType type);
}
