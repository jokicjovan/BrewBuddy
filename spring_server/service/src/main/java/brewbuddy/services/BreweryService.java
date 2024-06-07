package brewbuddy.services;

import brewbuddy.events.UserBeerLogger;
import brewbuddy.exceptions.NotFoundException;
import brewbuddy.models.Brewery;
import brewbuddy.repositories.UserBeerLoggerRepository;
import brewbuddy.services.interfaces.IBreweryService;
import brewbuddy.repositories.BreweryRepository;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.rule.QueryResults;
import org.kie.api.runtime.rule.QueryResultsRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class BreweryService implements IBreweryService {
    private final BreweryRepository breweryRepository;
    private final KieContainer kieContainer;
    private final UserBeerLoggerRepository userBeerLoggerRepository;

    @Autowired
    public BreweryService(KieContainer kieContainer, BreweryRepository breweryRepository,UserBeerLoggerRepository userBeerLoggerRepository) {
        this.breweryRepository = breweryRepository;
        this.kieContainer = kieContainer;
        this.userBeerLoggerRepository=userBeerLoggerRepository;
    }

    @Override
    public Brewery get(Integer id) {
        Optional<Brewery> brewery = breweryRepository.findById(id);
        if (brewery.isPresent()) {
            return brewery.get();
        } else {
            throw new NotFoundException("Brewery does not exist");
        }
    }

    @Override
    public List<Brewery> getAll() {
        return breweryRepository.findAll();
    }

    @Override
    public Brewery insert(Brewery brewery) {
        return breweryRepository.save(brewery);
    }


    @Override
    public List<Brewery> mostPopularBreweries(){
        KieSession kieSession = kieContainer.newKieSession("beerKsession");
        for (Brewery brewery :breweryRepository.findAll()){
            kieSession.insert(brewery);
        }
        for (UserBeerLogger logger:userBeerLoggerRepository.findAll()){
            kieSession.insert(logger);
        }
        QueryResults results = kieSession.getQueryResults("Most Popular Breweries");

        Map<Brewery, Integer> breweryCountMap = new HashMap<>();
        for (QueryResultsRow row : results) {
            Brewery resultBrewery = (Brewery) row.get("$brewery");
            Integer count = ((Long) row.get("$count")).intValue();
            breweryCountMap.put(resultBrewery, count);
        }
        List<Map.Entry<Brewery, Integer>> sortedEntries = new ArrayList<>(breweryCountMap.entrySet());
        Collections.sort(sortedEntries, Map.Entry.comparingByValue(Comparator.reverseOrder()));

        List<Brewery> sortedResultList = new ArrayList<>();
        for (Map.Entry<Brewery, Integer> entry : sortedEntries) {
            sortedResultList.add(entry.getKey());
        }
        return sortedResultList;
    }
}
