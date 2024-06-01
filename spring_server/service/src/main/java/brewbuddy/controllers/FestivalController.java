package brewbuddy.controllers;

import brewbuddy.dtos.CreateFestivalDTO;
import brewbuddy.dtos.FestivalDTO;
import brewbuddy.models.Brewery;
import brewbuddy.models.Credential;
import brewbuddy.models.Festival;
import brewbuddy.models.User;
import brewbuddy.services.interfaces.IBreweryService;
import brewbuddy.services.interfaces.ICityService;
import brewbuddy.services.interfaces.IFestivalService;
import brewbuddy.services.interfaces.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/festival")
public class FestivalController {
    private final IUserService userService;
    private final IFestivalService festivalService;
    private final ICityService cityService;

    private final IBreweryService breweryService;

    @Autowired
    public FestivalController(IFestivalService festivalService,ICityService cityService, IBreweryService breweryService,
                              IUserService userService) {
        this.festivalService = festivalService;
        this.breweryService=breweryService;
        this.cityService=cityService;
        this.userService = userService;
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
    public FestivalDTO insert(@RequestBody CreateFestivalDTO festival){
        Festival newFestival=new Festival();
        newFestival.setName(festival.getName());
        newFestival.setEventDate(festival.getEventDate());
        newFestival.setCity(cityService.get(festival.getCityId()));
        ArrayList<Brewery> breweries= new ArrayList<>();
        for (Integer i:festival.getBreweryIds()){
            breweries.add(breweryService.get(i));
        }
        newFestival.setBreweries(breweries);
        return FestivalDTO.convertToDetailedDTO(festivalService.insert(newFestival));
    }

    @RequestMapping(path = "/recommend", method = RequestMethod.GET)
    public List<FestivalDTO> recommend(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = ((Credential) authentication.getPrincipal()).getUser();

        User user = userService.get(currentUser.getId());
        return festivalService.recommend(user).stream()
                .map(FestivalDTO::convertToDetailedDTO)
                .collect(Collectors.toList());
    }
}
