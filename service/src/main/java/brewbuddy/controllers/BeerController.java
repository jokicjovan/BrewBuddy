package brewbuddy.controllers;

import brewbuddy.dtos.BeerDTO;
import brewbuddy.models.Beer;
import brewbuddy.models.Brewery;
import brewbuddy.models.User;
import brewbuddy.models.UserBeerLogger;
import brewbuddy.models.enums.BeerType;
import brewbuddy.services.interfaces.IBeerService;
import brewbuddy.services.interfaces.IBreweryService;
import brewbuddy.services.interfaces.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    public Beer getById(@PathVariable Integer id){
        return beerService.get(id);
    }

    @RequestMapping(path = "/recommend", method = RequestMethod.GET)
    public List<BeerDTO> recommend(@RequestParam Integer userId){
        User user = userService.get(userId);
        return beerService.recommend(user).stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList());
    }

    @RequestMapping(path = "/filter", method = RequestMethod.GET)
    public List<BeerDTO> filter(@RequestParam Integer breweryId, @RequestParam String beerType, @RequestParam String alcoholCategory){
        Brewery brewery=breweryService.get(breweryId);
        BeerType type = BeerType.valueOf(beerType);
        return beerService.filterBeers(type,brewery,alcoholCategory).stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList());
    }

    @RequestMapping(path = "/log", method = RequestMethod.POST)
    public UserBeerLogger filter(@RequestParam Integer userId, @RequestParam Integer beerId){
        User user = userService.get(userId);
        Beer beer = beerService.get(beerId);
        return beerService.logBeer(user, beer);
    }
}
