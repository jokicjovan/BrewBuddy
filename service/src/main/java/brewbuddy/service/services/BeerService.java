package brewbuddy.service.services;

import brewbuddy.model.Beer;
import brewbuddy.service.exceptions.NotFoundException;
import brewbuddy.service.interfaces.IBeerService;
import brewbuddy.service.repositories.BeerRepository;
import brewbuddy.service.repositories.RatingRepository;
import org.kie.api.runtime.KieContainer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BeerService implements IBeerService {
    private final BeerRepository beerRepository;

    private final RatingRepository ratingRepository;
    private final KieContainer kieContainer;

    @Autowired
    public BeerService(KieContainer kieContainer, BeerRepository beerRepository,RatingRepository ratingRepository) {
        this.beerRepository = beerRepository;
        this.kieContainer = kieContainer;
        this.ratingRepository = ratingRepository;
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
}
