package brewbuddy.services;

import brewbuddy.exceptions.NotFoundException;
import brewbuddy.models.Beer;
import brewbuddy.models.Rating;
import brewbuddy.models.User;
import brewbuddy.services.interfaces.IBeerService;
import brewbuddy.repositories.BeerRepository;
import brewbuddy.repositories.RatingRepository;
import brewbuddy.services.interfaces.IUserService;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

@Service
public class BeerService implements IBeerService {
    private final BeerRepository beerRepository;
    private final RatingRepository ratingRepository;
    private final KieContainer kieContainer;
    private final IUserService userService;

    @Autowired
    public BeerService(KieContainer kieContainer, BeerRepository beerRepository,RatingRepository ratingRepository,IUserService userService) {
        this.beerRepository = beerRepository;
        this.kieContainer = kieContainer;
        this.ratingRepository = ratingRepository;
        this.userService=userService;
    }

    @Override
    public Beer get(Integer id) {
        Optional<Beer> beer = beerRepository.findById(id);
        if (beer.isPresent()) {
            return beer.get();
        } else {
            throw new NotFoundException("Beer does not exist");
        }
    }

    @Override
    public List<Beer> getAll() {
        return beerRepository.findAll();
    }

    @Override
    public Beer insert(Beer beer) {
        return beerRepository.save(beer);
    }

    @Override
    public List<Beer> recommend(Integer userId){
        KieSession kieSession = kieContainer.newKieSession("recommendationKsession");
        User user= userService.get(userId);
        for(Rating r : ratingRepository.findAll()){
            kieSession.insert(r);
        }
        for(Beer b: beerRepository.findAll()){
            kieSession.insert(b);
        }
        kieSession.insert(user);
        HashMap<Beer, Integer> recommendationMap = new HashMap<>();
        kieSession.setGlobal("recommendationMap", recommendationMap);
        kieSession.fireAllRules();
        recommendationMap = (HashMap<Beer, Integer>) kieSession.getGlobal("recommendationMap");
        return new ArrayList<>(recommendationMap.keySet());
    }
}
