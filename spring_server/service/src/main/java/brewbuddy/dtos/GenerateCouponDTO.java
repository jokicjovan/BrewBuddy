package brewbuddy.dtos;

import brewbuddy.enums.CouponType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class GenerateCouponDTO {

    private Integer id;
    private Integer minBeers;
    private Double percentage;

    private Integer validFor;

    private Integer range;


}
