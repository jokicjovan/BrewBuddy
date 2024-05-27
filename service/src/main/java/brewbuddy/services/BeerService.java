package brewbuddy.services;

import brewbuddy.exceptions.NotFoundException;
import brewbuddy.models.*;
import brewbuddy.models.enums.BeerType;
import brewbuddy.services.interfaces.IBeerService;
import brewbuddy.repositories.BeerRepository;
import brewbuddy.repositories.RatingRepository;
import brewbuddy.services.interfaces.IUserService;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

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
        User user= userService.get(userId);

        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        kieSession.getAgenda().getAgendaGroup("beerRecommendation").setFocus();
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
        return recommendationMap.entrySet()
                .stream()
                .sorted(Map.Entry.<Beer, Integer>comparingByValue().reversed())
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
    }

    @Override
    public List<Beer> filterBeers(BeerType type,Brewery brewery, String alcoholCategory){
        HashMap<Integer, Integer> filterMap = new HashMap<>();
        HashMap<Integer,Integer> result= new HashMap<>();
        result=breweryFilter(brewery);
        for (Map.Entry<Integer, Integer> entry : result.entrySet()) {
            filterMap.put(entry.getKey(), filterMap.getOrDefault(entry.getKey(),0) + 1);
        }
        result=alcoholFilter(alcoholCategory);
        for (Map.Entry<Integer, Integer> entry : result.entrySet()) {
            filterMap.put(entry.getKey(), filterMap.getOrDefault(entry.getKey(),0) + 1);
        }
        result=typeFilter(type);
        for (Map.Entry<Integer, Integer> entry : result.entrySet()) {
            filterMap.put(entry.getKey(), filterMap.getOrDefault(entry.getKey(),0) + 1);
        }

        List<Map.Entry<Integer, Integer>> entryList = new ArrayList<>(filterMap.entrySet());
        entryList.sort((e1, e2) -> e2.getValue().compareTo(e1.getValue()));
        ArrayList<Beer> sortedBeer = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : entryList) {
            if (entry.getValue()>=2) {
                sortedBeer.add(get(entry.getKey()));
            }
        }
        return sortedBeer;
    }

    private HashMap<Integer,Integer> breweryFilter(Brewery brewery){
        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        kieSession.getAgenda().getAgendaGroup("beerFilter").setFocus();
        HashMap<Integer, Integer> filterMap = new HashMap<>();
        kieSession.setGlobal("filterMap", filterMap);
        kieSession.setGlobal("param", "Brewery-"+brewery.getId().toString());
        for (Beer beer:beerRepository.findAll()){
            String alcCategory="Medium";
            if (beer.getPercentageOfAlcohol()>7.0)
                alcCategory="High";
            if (beer.getPercentageOfAlcohol()<4.5)
                alcCategory="Low";

            kieSession.insert(new StringWrapper("BeerType-"+beer.getType().toString(),"AlcoholCategory-"+alcCategory,"Brewery"));
            kieSession.insert(new StringWrapper("Brewery-"+beer.getBrewery().getId().toString(),"BeerType-"+beer.getType().toString(),"Category"));
            kieSession.insert(new StringWrapper(beer.getId().toString(),"Brewery-"+beer.getBrewery().getId().toString(),"Beer"));
        }
        kieSession.fireAllRules();

        return (HashMap<Integer, Integer>) kieSession.getGlobal("filterMap");
    }
    private HashMap<Integer,Integer> alcoholFilter(String alcoholCategory){
        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        kieSession.getAgenda().getAgendaGroup("beerFilter").setFocus();
        HashMap<Integer, Integer> filterMap = new HashMap<>();
        kieSession.setGlobal("filterMap", filterMap);
        kieSession.setGlobal("param", "AlcoholCategory-"+alcoholCategory);
        for (Beer beer:beerRepository.findAll()){
            String alcCategory="Medium";
            if (beer.getPercentageOfAlcohol()>7.0)
                alcCategory="High";
            if (beer.getPercentageOfAlcohol()<4.5)
                alcCategory="Low";

            kieSession.insert(new StringWrapper("BeerType-"+beer.getType().toString(),"Brewery-"+beer.getBrewery().getId().toString(),"Brewery"));
            kieSession.insert(new StringWrapper("AlcoholCategory-"+alcCategory,"BeerType-"+beer.getType().toString(),"Category"));
            kieSession.insert(new StringWrapper(beer.getId().toString(),"AlcoholCategory-"+alcCategory,"Beer"));
        }

        kieSession.fireAllRules();
        return (HashMap<Integer, Integer>) kieSession.getGlobal("filterMap");
    }

    private HashMap<Integer,Integer> typeFilter(BeerType type){
        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        kieSession.getAgenda().getAgendaGroup("beerFilter").setFocus();
        HashMap<Integer, Integer> filterMap = new HashMap<>();
        kieSession.setGlobal("filterMap", filterMap);
        kieSession.setGlobal("param", "BeerType-"+type.toString());
        for (Beer beer:beerRepository.findAll()){
            String alcCategory="Medium";
            if (beer.getPercentageOfAlcohol()>7.0)
                alcCategory="High";
            if (beer.getPercentageOfAlcohol()<4.5)
                alcCategory="Low";

            kieSession.insert(new StringWrapper("AlcoholCategory-"+alcCategory,"Brewery-"+beer.getBrewery().getId().toString(),"Brewery"));
            kieSession.insert(new StringWrapper("BeerType-"+beer.getType().toString(),"AlcoholCategory-"+alcCategory,"Category"));
            kieSession.insert(new StringWrapper(beer.getId().toString(),"BeerType-"+beer.getType().toString(),"Beer"));
        }

        kieSession.fireAllRules();
        return (HashMap<Integer, Integer>) kieSession.getGlobal("filterMap");
    }
}
