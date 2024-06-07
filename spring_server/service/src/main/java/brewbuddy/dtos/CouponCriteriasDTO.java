package brewbuddy.dtos;

import brewbuddy.models.CouponCriteria;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CouponCriteriasDTO {
    private CouponCriteria festivalCriteria;
    private CouponCriteria breweryCriteria;
    private CouponCriteria appCriteria;
}
