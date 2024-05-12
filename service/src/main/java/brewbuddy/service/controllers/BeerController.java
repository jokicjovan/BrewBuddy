package brewbuddy.service.controllers;

import brewbuddy.model.Beer;
import brewbuddy.service.interfaces.IBeerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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
}
