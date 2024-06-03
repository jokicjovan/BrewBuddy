package brewbuddy.dtos;

import brewbuddy.enums.CouponType;
import brewbuddy.models.BreweryCoupon;
import brewbuddy.models.Coupon;
import brewbuddy.models.Festival;
import brewbuddy.models.FestivalCoupon;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class CouponDTO {
    private Integer id;
    private Date validUntil;
    private Double discountPercentage;
    private CouponType type;
    private UserDTO user;
    private BreweryDTO brewery;
    private FestivalDTO festival;

    public static CouponDTO convertToCouponDTO(Coupon coupon) {
        CouponDTO dto = new CouponDTO();
        dto.setId(coupon.getId());
        dto.setValidUntil(coupon.getValidUntil());
        dto.setDiscountPercentage(coupon.getDiscountPercentage());
        dto.setType(coupon.getType());
        dto.setUser(UserDTO.convertToSimpleDTO(coupon.getUser()));

        if(coupon.getType().equals(CouponType.BREWERY)) {
            dto.setBrewery(BreweryDTO.convertToSimpleDTO(((BreweryCoupon)coupon).getBrewery()));
        }
        else if(coupon.getType().equals(CouponType.FESTIVAL)) {
            dto.setFestival(FestivalDTO.convertToSimpleDTO(((FestivalCoupon)coupon).getFestival()));
        }
        return dto;
    }
}
