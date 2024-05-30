package brewbuddy.controllers;

import brewbuddy.dtos.BeerDTO;
import brewbuddy.dtos.BrewerySimpleDTO;
import brewbuddy.models.Beer;
import brewbuddy.models.Brewery;
import brewbuddy.services.interfaces.IBreweryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/brewery")
public class BreweryController {

    private final IBreweryService breweryService;

    @Autowired

    public BreweryController(IBreweryService breweryService) {
        this.breweryService = breweryService;
    }
    @RequestMapping("/")
    public List<Brewery> getAll(){
        return breweryService.getAll();
    }

    @RequestMapping("/{id}")
    public Brewery getById(@PathVariable Integer id){
        return breweryService.get(id);
    }
    @RequestMapping("/popular")
    public List<BrewerySimpleDTO> getPopular(){
        return breweryService.mostPopularBreweries().stream()
                .map(BrewerySimpleDTO::convertToDTO)
                .collect(Collectors.toList());
    }
}
