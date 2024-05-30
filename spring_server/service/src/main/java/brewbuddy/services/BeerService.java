package brewbuddy.services;

import brewbuddy.drools.DroolsHelper;
import brewbuddy.events.Rating;
import brewbuddy.events.UserBeerLogger;
import brewbuddy.exceptions.NotFoundException;
import brewbuddy.models.*;
import brewbuddy.enums.BeerType;
import brewbuddy.repositories.UserBeerLoggerRepository;
import brewbuddy.services.interfaces.IBeerService;
import brewbuddy.repositories.BeerRepository;
import brewbuddy.repositories.RatingRepository;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.rule.QueryResults;
import org.kie.api.runtime.rule.QueryResultsRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class BeerService implements IBeerService {
    private final BeerRepository beerRepository;
    private final RatingRepository ratingRepository;
    private final UserBeerLoggerRepository userBeerLoggerRepository;
    private final KieContainer kieContainer;
    private final BreweryService breweryService;

    @Autowired
    public BeerService(KieContainer kieContainer, BeerRepository beerRepository, RatingRepository ratingRepository,
                       UserBeerLoggerRepository userBeerLoggerRepository, BreweryService breweryService) {
        this.beerRepository = beerRepository;
        this.kieContainer = kieContainer;
        this.ratingRepository = ratingRepository;
        this.userBeerLoggerRepository = userBeerLoggerRepository;
        this.breweryService = breweryService;
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
    public HashMap<Brewery, Beer> getMostPopularBeerByBrewery(List<Brewery> breweries) {
        List<Beer> mostPopularBeers = new ArrayList<>();
        for (Brewery brewery : breweries) {
            List<Beer> beers = beerRepository.getMostPopularBeersByBrewery(brewery, PageRequest.of(0, 1)).getContent();
            if (!beers.isEmpty()) {
                mostPopularBeers.add(beers.get(0));
            } else {
                mostPopularBeers.add(brewery.getBeers().get(0));
            }
        }
        Map<Brewery, Beer> breweryBeerMap = mostPopularBeers.stream()
                .collect(Collectors.toMap(Beer::getBrewery, beer -> beer));
        return new HashMap<>(breweryBeerMap);
    }

    @Override
    public Rating rate(User user, Beer beer, Integer rate, String comment) {
        Rating rating = new Rating();
        rating.setRate(rate);
        rating.setComment(comment);
        rating.setUser(user);
        rating.setBeer(beer);
        rating.setTimestamp(new Date());
        return ratingRepository.save(rating);
    }

    @Override
    public UserBeerLogger logBeer(User user, Beer beer) {
        UserBeerLogger logger = new UserBeerLogger();
        logger.setUser(user);
        logger.setBeer(beer);
        logger.setTimestamp(new Date());
        return userBeerLoggerRepository.save(logger);
    }


    @Override
    public List<Beer> recommend(User user) {
        KieSession kieSession = kieContainer.newKieSession("beerKsession");

        // forwards
        kieSession.insert(user);
        for (Rating r : ratingRepository.findAll()) {
            kieSession.insert(r);
        }
        for (Beer b : beerRepository.findAll()) {
            kieSession.insert(b);
        }
        kieSession.setGlobal("recommendationMap", new HashMap<Beer, Integer>());
        kieSession.getAgenda().getAgendaGroup("beerRecommendation").setFocus();
        kieSession.fireAllRules();

        // remove breweries from session
        DroolsHelper.clearObjectsFromSession(kieSession, Brewery.class);

        kieSession.setGlobal("mostPopularBeersByBreweryMap", getMostPopularBeerByBrewery(breweryService.getAll()));
        // cep
        for (BeerType beerType : BeerType.values()) {
            kieSession.insert(beerType);
        }
        for (Brewery brewery : breweryService.getAll()) {
            kieSession.insert(brewery);
        }
        for (UserBeerLogger usl : userBeerLoggerRepository.findAll()) {
            kieSession.insert(usl);
        }
        kieSession.getAgenda().getAgendaGroup("beerCep").setFocus();
        kieSession.fireAllRules();

        HashMap<Beer, Integer> recommendationMap = (HashMap<Beer, Integer>) kieSession.getGlobal("recommendationMap");
        return recommendationMap.entrySet()
                .stream()
                .filter(entry -> entry.getValue() > 0)
                .sorted(Map.Entry.<Beer, Integer>comparingByValue().reversed())
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
    }

    @Override
    public List<Beer> filterBeers(BeerType type, Brewery brewery, String alcoholCategory) {
        HashMap<Integer, Integer> filterMap = new HashMap<>();
        HashMap<Integer, Integer> result = new HashMap<>();
        result = breweryFilter(brewery);
        for (Map.Entry<Integer, Integer> entry : result.entrySet()) {
            filterMap.put(entry.getKey(), filterMap.getOrDefault(entry.getKey(), 0) + 1);
        }
        result = alcoholFilter(alcoholCategory);
        for (Map.Entry<Integer, Integer> entry : result.entrySet()) {
            filterMap.put(entry.getKey(), filterMap.getOrDefault(entry.getKey(), 0) + 1);
        }
        result = typeFilter(type);
        for (Map.Entry<Integer, Integer> entry : result.entrySet()) {
            filterMap.put(entry.getKey(), filterMap.getOrDefault(entry.getKey(), 0) + 1);
        }

        List<Map.Entry<Integer, Integer>> entryList = new ArrayList<>(filterMap.entrySet());
        entryList.sort((e1, e2) -> e2.getValue().compareTo(e1.getValue()));
        ArrayList<Beer> sortedBeer = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : entryList) {
            if (entry.getValue() >= 2) {
                sortedBeer.add(get(entry.getKey()));
            }
        }
        return sortedBeer;
    }

    private HashMap<Integer, Integer> breweryFilter(Brewery brewery) {
        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        kieSession.getAgenda().getAgendaGroup("beerFilter").setFocus();
        HashMap<Integer, Integer> filterMap = new HashMap<>();
        kieSession.setGlobal("filterMap", filterMap);
        kieSession.setGlobal("param", "Brewery-" + brewery.getId().toString());
        for (Beer beer : beerRepository.findAll()) {
            String alcCategory = "Medium";
            if (beer.getPercentageOfAlcohol() > 7.0)
                alcCategory = "High";
            if (beer.getPercentageOfAlcohol() < 4.5)
                alcCategory = "Low";

            kieSession.insert(new StringWrapper("BeerType-" + beer.getType().toString(), "AlcoholCategory-" + alcCategory, "Brewery"));
            kieSession.insert(new StringWrapper("Brewery-" + beer.getBrewery().getId().toString(), "BeerType-" + beer.getType().toString(), "Category"));
            kieSession.insert(new StringWrapper(beer.getId().toString(), "Brewery-" + beer.getBrewery().getId().toString(), "Beer"));
        }
        kieSession.fireAllRules();

        return (HashMap<Integer, Integer>) kieSession.getGlobal("filterMap");
    }

    private HashMap<Integer, Integer> alcoholFilter(String alcoholCategory) {
        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        kieSession.getAgenda().getAgendaGroup("beerFilter").setFocus();
        HashMap<Integer, Integer> filterMap = new HashMap<>();
        kieSession.setGlobal("filterMap", filterMap);
        kieSession.setGlobal("param", "AlcoholCategory-" + alcoholCategory);
        for (Beer beer : beerRepository.findAll()) {
            String alcCategory = "Medium";
            if (beer.getPercentageOfAlcohol() > 7.0)
                alcCategory = "High";
            if (beer.getPercentageOfAlcohol() < 4.5)
                alcCategory = "Low";

            kieSession.insert(new StringWrapper("BeerType-" + beer.getType().toString(), "Brewery-" + beer.getBrewery().getId().toString(), "Brewery"));
            kieSession.insert(new StringWrapper("AlcoholCategory-" + alcCategory, "BeerType-" + beer.getType().toString(), "Category"));
            kieSession.insert(new StringWrapper(beer.getId().toString(), "AlcoholCategory-" + alcCategory, "Beer"));
        }

        kieSession.fireAllRules();
        return (HashMap<Integer, Integer>) kieSession.getGlobal("filterMap");
    }

    private HashMap<Integer, Integer> typeFilter(BeerType type) {
        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        kieSession.getAgenda().getAgendaGroup("beerFilter").setFocus();
        HashMap<Integer, Integer> filterMap = new HashMap<>();
        kieSession.setGlobal("filterMap", filterMap);
        kieSession.setGlobal("param", "BeerType-" + type.toString());
        for (Beer beer : beerRepository.findAll()) {
            String alcCategory = "Medium";
            if (beer.getPercentageOfAlcohol() > 7.0)
                alcCategory = "High";
            if (beer.getPercentageOfAlcohol() < 4.5)
                alcCategory = "Low";

            kieSession.insert(new StringWrapper("AlcoholCategory-" + alcCategory, "Brewery-" + beer.getBrewery().getId().toString(), "Brewery"));
            kieSession.insert(new StringWrapper("BeerType-" + beer.getType().toString(), "AlcoholCategory-" + alcCategory, "Category"));
            kieSession.insert(new StringWrapper(beer.getId().toString(), "BeerType-" + beer.getType().toString(), "Beer"));
        }

        kieSession.fireAllRules();
        return (HashMap<Integer, Integer>) kieSession.getGlobal("filterMap");
    }

    @Override
    public List<Beer> mostPopularBeers(){
        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        for (Beer beer:beerRepository.findAll()){
            kieSession.insert(beer);
        }
        for (UserBeerLogger logger:userBeerLoggerRepository.findAll()){
            kieSession.insert(logger);
        }
        QueryResults results = kieSession.getQueryResults("Most Popular Beers");

        Map<Beer, Integer> beerCountMap = new HashMap<>();
        for (QueryResultsRow row : results) {
            Beer resultBeer = (Beer) row.get("$beer");
            Integer count = ((Long) row.get("$count")).intValue();
            beerCountMap.put(resultBeer, count);
        }
        List<Map.Entry<Beer, Integer>> sortedEntries = new ArrayList<>(beerCountMap.entrySet());
        Collections.sort(sortedEntries, Map.Entry.comparingByValue(Comparator.reverseOrder()));

        List<Beer> sortedResultList = new ArrayList<>();
        for (Map.Entry<Beer, Integer> entry : sortedEntries) {
            sortedResultList.add(entry.getKey());
        }
        return sortedResultList;
    }

    @Override
    public List<BeerType> mostLovedCategories(){
        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        for (BeerType type:BeerType.values()){
            kieSession.insert(type);
        }
        for (Rating rating:ratingRepository.findAll()){
            kieSession.insert(rating);
        }
        QueryResults results = kieSession.getQueryResults("Most Popular Beer Categories");

        Map<BeerType, Double> beerTypeCountMap = new HashMap<>();
        for (QueryResultsRow row : results) {
            BeerType resultBeerType = (BeerType) row.get("$beerType");
            Double count = (Double) row.get("$avgRating");
            beerTypeCountMap.put(resultBeerType, count);
        }
        List<Map.Entry<BeerType, Double>> sortedEntries = new ArrayList<>(beerTypeCountMap.entrySet());
        Collections.sort(sortedEntries, Map.Entry.comparingByValue(Comparator.reverseOrder()));

        List<BeerType> sortedResultList = new ArrayList<>();
        for (Map.Entry<BeerType, Double> entry : sortedEntries) {
            sortedResultList.add(entry.getKey());
        }
        return sortedResultList;
    }
}
