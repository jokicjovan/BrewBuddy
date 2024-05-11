package brewbuddy.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Getter
@Setter
@DiscriminatorValue("BREWERY")
public class BreweryCoupon extends Coupon {
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="brewery_id")
    private Brewery brewery;
}
