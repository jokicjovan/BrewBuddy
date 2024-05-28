package brewbuddy.models;

import brewbuddy.models.enums.CouponType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name="Coupon_Criterias")
public class CouponCriteria {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "type", nullable = false)
    @Enumerated(EnumType.STRING)
    private CouponType type;

    @Column(name = "min_beers", nullable = false)
    private CouponType minBeers;
    @Column(name = "percentage", nullable = false)
    private Double percentage;

    @Column(name = "expire_in", nullable = false)
    private Integer expireIn;

    @Column(name = "days_range", nullable = false)
    private Integer daysRange;


}
