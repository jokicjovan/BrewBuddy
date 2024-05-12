package brewbuddy.service.controllers;

import brewbuddy.model.Brewery;
import brewbuddy.service.interfaces.IBreweryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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
}
