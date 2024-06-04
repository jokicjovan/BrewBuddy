package brewbuddy.controllers;

import brewbuddy.dtos.BeerDTO;
import brewbuddy.dtos.CouponDTO;
import brewbuddy.dtos.FestivalDTO;
import brewbuddy.models.Coupon;
import brewbuddy.models.Credential;
import brewbuddy.models.User;
import brewbuddy.services.interfaces.IBeerService;
import brewbuddy.services.interfaces.ICouponService;
import brewbuddy.services.interfaces.IFestivalService;
import brewbuddy.services.interfaces.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/user")
public class UserController {
	private final IUserService userService;
	private final IFestivalService festivalService;
	private final ICouponService couponService;
	private final IBeerService beerService;

	@Autowired

	public UserController(IUserService userService, IFestivalService festivalService, ICouponService couponService,
						  IBeerService beerService) {
		this.userService = userService;
        this.festivalService = festivalService;
        this.couponService = couponService;
        this.beerService = beerService;
    }

	@RequestMapping("/")
	public List<User> getAll(){
		return userService.getAll();
	}

	@RequestMapping("/{id}")
	public User getById(@PathVariable Integer id){
		return userService.get(id);
	}

	@RequestMapping("/popular")
	public List<User> getMostPopularUsers(){
		return userService.mostPopularUsers();
	}

	@RequestMapping("/isDrunk")
	public Boolean isUserDrunk(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User currentUser = ((Credential) authentication.getPrincipal()).getUser();

		User user = userService.get(currentUser.getId());
		return userService.isUserDrunk(user);
	}

	@RequestMapping(value = "/coupon", method = RequestMethod.GET)
	public List<CouponDTO> getAllCoupons(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User currentUser = ((Credential) authentication.getPrincipal()).getUser();

		User user = userService.get(currentUser.getId());
		return couponService.getUserCoupons(user).stream()
				.map(CouponDTO::convertToCouponDTO)
				.collect(Collectors.toList());
	}

	@RequestMapping(path = "/beer/recommend", method = RequestMethod.GET)
	public List<BeerDTO> recommendBeers(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User currentUser = ((Credential) authentication.getPrincipal()).getUser();

		User user = userService.get(currentUser.getId());
		return beerService.recommend(user).stream()
				.map(BeerDTO::convertToDTO)
				.collect(Collectors.toList());
	}

	@RequestMapping(path = "festival/recommend", method = RequestMethod.GET)
	public List<FestivalDTO> recommendFestivals(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User currentUser = ((Credential) authentication.getPrincipal()).getUser();

		User user = userService.get(currentUser.getId());
		return festivalService.recommend(user).stream()
				.map(FestivalDTO::convertToDetailedDTO)
				.collect(Collectors.toList());
	}
}
