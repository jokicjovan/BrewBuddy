package brewbuddy.controllers;

import brewbuddy.dtos.BreweryDTO;
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
    public List<BreweryDTO> getAll(){
        return breweryService.getAll().stream()
                .map(BreweryDTO::convertToSimpleDTO)
                .collect(Collectors.toList());
    }

    @RequestMapping("/{id}")
    public Brewery getById(@PathVariable Integer id){
        return breweryService.get(id);
    }

    @RequestMapping("/popular")
    public List<BreweryDTO> getPopular(){
        return breweryService.mostPopularBreweries().stream()
                .map(BreweryDTO::convertToSimpleDTO)
                .collect(Collectors.toList());
    }
}
