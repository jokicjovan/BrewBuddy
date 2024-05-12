package brewbuddy.controllers;

import brewbuddy.model.City;
import brewbuddy.services.interfaces.ICityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/city")
public class CityController
{

    private final ICityService cityService;

    @Autowired
    public CityController(ICityService cityService){
        this.cityService=cityService;
    }
    @RequestMapping("/")
    public List<City> getAll(){
        return cityService.getAll();
    }

    @RequestMapping("/{id}")
    public City getById(@PathVariable Integer id){
        return cityService.get(id);
    }
}
