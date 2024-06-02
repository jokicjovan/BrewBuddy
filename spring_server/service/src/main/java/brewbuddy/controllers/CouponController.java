package brewbuddy.controllers;


import brewbuddy.models.*;
import brewbuddy.services.interfaces.IBreweryService;
import brewbuddy.services.interfaces.ICouponService;
import brewbuddy.services.interfaces.IFestivalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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

    @RequestMapping(value = "/festival/{id}",method = RequestMethod.POST)
    public List<FestivalCoupon> generateFestivalCoupons(@PathVariable Integer id){
        Festival festival=festivalService.get(id);
        return couponService.createFestivalCoupon(festival);
    }

    @RequestMapping(value = "/brewery/{id}",method = RequestMethod.POST)
    public List<BreweryCoupon> generateBreweryCoupons(@PathVariable Integer id){
        Brewery brewery=breweryService.get(id);
        return couponService.createBreweryCoupon(brewery);
    }

    @RequestMapping(value = "/application",method = RequestMethod.POST)
    public List<ApplicationCoupon> generateAppCoupons(){
        return couponService.createAppCoupon();
    }
}
