package brewbuddy.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Getter
@Setter
@DiscriminatorValue("FESTIVAL")
public class FestivalCoupon extends Coupon{
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="festival_id", nullable=false)
    private Festival festival;
}
