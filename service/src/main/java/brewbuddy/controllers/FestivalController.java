package brewbuddy.controllers;

import brewbuddy.dtos.BeerDTO;
import brewbuddy.dtos.CreateFestivalDTO;
import brewbuddy.dtos.FestivalDetailedDTO;
import brewbuddy.models.Brewery;
import brewbuddy.models.Festival;
import brewbuddy.models.enums.BeerType;
import brewbuddy.services.interfaces.IBreweryService;
import brewbuddy.services.interfaces.ICityService;
import brewbuddy.services.interfaces.IFestivalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/festival")
public class FestivalController {

    private final IFestivalService festivalService;
    private final ICityService cityService;

    private final IBreweryService breweryService;

    @Autowired
    public FestivalController(IFestivalService festivalService,ICityService cityService, IBreweryService breweryService) {
        this.festivalService = festivalService;
        this.breweryService=breweryService;
        this.cityService=cityService;
    }
    @RequestMapping("/")
    public List<Festival> getAll(){
        return festivalService.getAll();
    }

    @RequestMapping("/{id}")
    public Festival getById(@PathVariable Integer id){
        return festivalService.get(id);
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public FestivalDetailedDTO insert(@RequestBody CreateFestivalDTO festival){
        Festival newFestival=new Festival();
        newFestival.setName(festival.getName());
        newFestival.setEventDate(festival.getEventDate());
        newFestival.setCity(cityService.get(festival.getCityId()));
        ArrayList<Brewery> breweries= new ArrayList<>();
        for (Integer i:festival.getBreweryIds()){
            breweries.add(breweryService.get(i));
        }
        newFestival.setBreweries(breweries);
        return FestivalDetailedDTO.convertToDTO(festivalService.insert(newFestival));
    }

    @RequestMapping(path = "/recommend", method = RequestMethod.GET)
    public List<FestivalDetailedDTO> recommend(@RequestParam Integer userId){
        return festivalService.recommend(userId).stream()
                .map(FestivalDetailedDTO::convertToDTO)
                .collect(Collectors.toList());
    }
}
