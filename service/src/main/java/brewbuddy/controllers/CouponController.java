package brewbuddy.controllers;


import brewbuddy.models.Coupon;
import brewbuddy.services.interfaces.ICouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/coupon")
public class CouponController {

    private final ICouponService couponService;

    public CouponController(ICouponService couponService) {
        this.couponService = couponService;
    }

    @Autowired


    @RequestMapping("/")
    public List<Coupon> getAll(){
        return couponService.getAll();
    }

    @RequestMapping("/{id}")
    public Coupon getById(@PathVariable Integer id){
        return couponService.get(id);
    }
}
