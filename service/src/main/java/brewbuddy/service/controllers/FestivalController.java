package brewbuddy.service.controllers;

import brewbuddy.model.Festival;
import brewbuddy.service.interfaces.IFestivalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/festival")
public class FestivalController {

    private final IFestivalService festivalService;

    @Autowired
    public FestivalController(IFestivalService festivalService) {
        this.festivalService = festivalService;
    }
    @RequestMapping("/")
    public List<Festival> getAll(){
        return festivalService.getAll();
    }

    @RequestMapping("/{id}")
    public Festival getById(@PathVariable Integer id){
        return festivalService.get(id);
    }
}
