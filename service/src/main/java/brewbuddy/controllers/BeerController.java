package brewbuddy.controllers;

import brewbuddy.dtos.BeerDTO;
import brewbuddy.models.Beer;
import brewbuddy.services.interfaces.IBeerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/beer")
public class BeerController {

    private final IBeerService beerService;

    @Autowired
    public BeerController(IBeerService beerService) {
        this.beerService = beerService;
    }

    @RequestMapping("/")
    public List<Beer> getAll(){
        return beerService.getAll();
    }

    @RequestMapping("/{id}")
    public Beer getById(@PathVariable Integer id){
        return beerService.get(id);
    }

    @RequestMapping(path = "recommend/{userId}", method = RequestMethod.GET)
    public List<BeerDTO> recommend(@PathVariable Integer userId){
        List<BeerDTO> beers = beerService.recommend(userId).stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList());
        return beers;
    }
}
