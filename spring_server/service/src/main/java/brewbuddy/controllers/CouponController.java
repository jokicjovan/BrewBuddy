package brewbuddy.controllers;


import brewbuddy.dtos.GenerateCouponDTO;
import brewbuddy.enums.CouponType;
import brewbuddy.models.*;
import brewbuddy.services.interfaces.IBreweryService;
import brewbuddy.services.interfaces.ICouponService;
import brewbuddy.services.interfaces.IFestivalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/coupon")
public class CouponController {

    private final ICouponService couponService;
    private final IFestivalService festivalService;
    private final IBreweryService breweryService;

    @Autowired
    public CouponController(ICouponService couponService,IFestivalService festivalService,IBreweryService breweryService) {
        this.couponService = couponService;
        this.festivalService= festivalService;
        this.breweryService=breweryService;
    }

    @RequestMapping("/")
    public List<Coupon> getAll(){
        return couponService.getAll();
    }

    @RequestMapping("/{id}")
    public Coupon getById(@PathVariable Integer id){
        return couponService.get(id);
    }

    @RequestMapping(value = "/festival",method = RequestMethod.POST)
    public List<FestivalCoupon> generateFestivalCoupons(@RequestBody GenerateCouponDTO dto){
        Festival festival=festivalService.get(dto.getId());
        CouponCriteria couponCriteria= new CouponCriteria();
        couponCriteria.setMinBeers(dto.getMinBeers());
        couponCriteria.setType(CouponType.FESTIVAL);
        couponCriteria.setDaysRange(dto.getRange());
        couponCriteria.setExpireIn(dto.getValidFor());
        couponCriteria.setPercentage(dto.getPercentage());

        return couponService.createFestivalCoupon(festival,couponCriteria);
    }

    @RequestMapping(value = "/brewery",method = RequestMethod.POST)
    public List<BreweryCoupon> generateBreweryCoupons(@RequestBody GenerateCouponDTO dto){
        Brewery brewery=breweryService.get(dto.getId());
        CouponCriteria couponCriteria= new CouponCriteria();
        couponCriteria.setMinBeers(dto.getMinBeers());
        couponCriteria.setType(CouponType.BREWERY);
        couponCriteria.setDaysRange(dto.getRange());
        couponCriteria.setExpireIn(dto.getValidFor());
        couponCriteria.setPercentage(dto.getPercentage());
        return couponService.createBreweryCoupon(brewery,couponCriteria);
    }

    @RequestMapping(value = "/application",method = RequestMethod.POST)
    public List<ApplicationCoupon> generateAppCoupons(@RequestBody GenerateCouponDTO dto){
        CouponCriteria couponCriteria= new CouponCriteria();
        couponCriteria.setMinBeers(dto.getMinBeers());
        couponCriteria.setType(CouponType.FESTIVAL);
        couponCriteria.setDaysRange(dto.getRange());
        couponCriteria.setExpireIn(dto.getValidFor());
        couponCriteria.setPercentage(dto.getPercentage());

        return couponService.createAppCoupon(couponCriteria);
    }
}
