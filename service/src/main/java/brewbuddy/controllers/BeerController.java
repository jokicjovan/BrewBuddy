package brewbuddy.controllers;

import brewbuddy.dtos.BeerDTO;
import brewbuddy.dtos.RateDTO;
import brewbuddy.dtos.RatingDTO;
import brewbuddy.dtos.UserBeerLoggerDTO;
import brewbuddy.models.Beer;
import brewbuddy.models.Brewery;
import brewbuddy.models.User;
import brewbuddy.models.enums.BeerType;
import brewbuddy.services.interfaces.IBeerService;
import brewbuddy.services.interfaces.IBreweryService;
import brewbuddy.services.interfaces.IUserService;
import org.hibernate.validator.constraints.Range;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
import javax.validation.constraints.PositiveOrZero;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/beer")
public class BeerController {
    private final IUserService userService;
    private final IBeerService beerService;
    private final IBreweryService breweryService;

    @Autowired
    public BeerController(IBeerService beerService,IBreweryService breweryService, IUserService userService) {
        this.beerService = beerService;
        this.userService = userService;
        this.breweryService=breweryService;
    }

    @RequestMapping("/")
    public List<Beer> getAll(){
        return beerService.getAll();
    }

    @RequestMapping("/{id}")
    public Beer getById(@PathVariable @NotNull @PositiveOrZero Integer id){
        return beerService.get(id);
    }

    @RequestMapping(path = "/recommend", method = RequestMethod.GET)
    public List<BeerDTO> recommend(@RequestParam @NotNull @PositiveOrZero Integer userId){
        User user = userService.get(userId);
        return beerService.recommend(user).stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList());
    }

    @RequestMapping(path = "/filter", method = RequestMethod.GET)
    public List<BeerDTO> filter(@RequestParam @NotNull @PositiveOrZero Integer breweryId,
                                @RequestParam @NotNull @NotEmpty String beerType,
                                @RequestParam @NotNull @NotEmpty String alcoholCategory){
        Brewery brewery=breweryService.get(breweryId);
        BeerType type = BeerType.valueOf(beerType);
        return beerService.filterBeers(type,brewery,alcoholCategory).stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList());
    }

    @RequestMapping(path = "/rate", method = RequestMethod.POST)
    public RatingDTO filter(@RequestParam @NotNull @PositiveOrZero Integer userId,
                            @RequestParam @NotNull @PositiveOrZero Integer beerId,
                            @RequestBody RateDTO rateDto){
        User user = userService.get(userId);
        Beer beer = beerService.get(beerId);
        return RatingDTO.convertToDTO(beerService.rate(user, beer, rateDto.getRate(), rateDto.getComment()));
    }

    @RequestMapping(path = "/log", method = RequestMethod.POST)
    public UserBeerLoggerDTO filter(@RequestParam @NotNull @PositiveOrZero Integer userId,
                                    @RequestParam @NotNull @PositiveOrZero Integer beerId){
        User user = userService.get(userId);
        Beer beer = beerService.get(beerId);
        return UserBeerLoggerDTO.convertToDTO(beerService.logBeer(user, beer));
    }
}
