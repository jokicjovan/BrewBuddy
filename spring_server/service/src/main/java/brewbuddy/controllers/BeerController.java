package brewbuddy.controllers;

import brewbuddy.dtos.BeerDTO;
import brewbuddy.dtos.CreateRatingDTO;
import brewbuddy.dtos.RatingDTO;
import brewbuddy.dtos.UserBeerLoggerDTO;
import brewbuddy.models.Beer;
import brewbuddy.models.Brewery;
import brewbuddy.models.Credential;
import brewbuddy.models.User;
import brewbuddy.enums.BeerType;
import brewbuddy.services.interfaces.IBeerService;
import brewbuddy.services.interfaces.IBreweryService;
import brewbuddy.services.interfaces.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/beer")
public class BeerController {
    private final IUserService userService;
    private final IBeerService beerService;
    private final IBreweryService breweryService;

    @Autowired
    public BeerController(IBeerService beerService, IBreweryService breweryService, IUserService userService) {
        this.beerService = beerService;
        this.userService = userService;
        this.breweryService = breweryService;
    }

    @RequestMapping(path = "/", method = RequestMethod.GET)
    public List<BeerDTO> getAll() {
        return beerService.getAll().stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList());
    }

    @RequestMapping("/type/{type}")
    public List<BeerDTO> getByType(@PathVariable BeerType type){
        return beerService.getByType(type).stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList());
    }

    @GetMapping("/beerTypes")
    public List<String> getBeerTypes(){
        return Arrays.stream(BeerType.values())
                .map(Enum::name) // Convert each enum to its name
                .collect(Collectors.toList());
    }

    @RequestMapping(path = "/{id}", method = RequestMethod.GET)
    public BeerDTO getById(@PathVariable @NotNull @PositiveOrZero Integer id){
        return BeerDTO.convertToDTO( beerService.get(id));
    }

    @RequestMapping(path = "/filter", method = RequestMethod.GET)
    public List<BeerDTO> filter(@RequestParam Optional<Integer> breweryId,
                                @RequestParam Optional<String> beerType,
                                @RequestParam Optional<String> alcoholCategory){
        Brewery brewery=null;
        BeerType type=null;
        String category=null;
        if (breweryId.isPresent())
            brewery=breweryService.get(breweryId.get());
        if (beerType.isPresent())
            type= BeerType.valueOf(beerType.get());
        if (alcoholCategory.isPresent())
            category=alcoholCategory.get();
        return beerService.filterBeers(type,brewery,category).stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList());
    }

    @RequestMapping(path = "/rate", method = RequestMethod.POST)
    public RatingDTO rate(@RequestParam @NotNull @PositiveOrZero Integer beerId,
                          @RequestBody CreateRatingDTO createRatingDto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = ((Credential) authentication.getPrincipal()).getUser();

        User user = userService.get(currentUser.getId());
        Beer beer = beerService.get(beerId);
        return RatingDTO.convertToDTO(beerService.rate(user, beer, createRatingDto.getRate(), createRatingDto.getComment()));
    }

    @RequestMapping(path = "/log", method = RequestMethod.POST)
    public UserBeerLoggerDTO logBeer(@RequestParam @NotNull @PositiveOrZero Integer beerId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = ((Credential) authentication.getPrincipal()).getUser();

        User user = userService.get(currentUser.getId());
        Beer beer = beerService.get(beerId);
        return UserBeerLoggerDTO.convertToDTO(beerService.logBeer(user, beer));
    }

    @RequestMapping(path = "/isBeerRated", method = RequestMethod.GET)
    public boolean isBeerRated(@RequestParam @NotNull @PositiveOrZero Integer beerId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = ((Credential) authentication.getPrincipal()).getUser();

        User user = userService.get(currentUser.getId());
        Beer beer = beerService.get(beerId);
        return beerService.isBeerRatedByUser(beer, user);
    }

    @RequestMapping("/beerType/popular")
    public List<BeerType> mostLovedBeerTypes() {
        return beerService.mostLovedCategories();
    }

    @RequestMapping("/popular")
    public List<BeerDTO> mostPopularBeers() {
        return beerService.mostPopularBeers().stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList());
    }
}
