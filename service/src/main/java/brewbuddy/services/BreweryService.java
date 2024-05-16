package brewbuddy.services;

import brewbuddy.exceptions.NotFoundException;
import brewbuddy.models.Brewery;
import brewbuddy.services.interfaces.IBreweryService;
import brewbuddy.repositories.BreweryRepository;
import org.kie.api.runtime.KieContainer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BreweryService implements IBreweryService {
    private final BreweryRepository breweryRepository;
    private final KieContainer kieContainer;

    @Autowired
    public BreweryService(KieContainer kieContainer, BreweryRepository breweryRepository) {
        this.breweryRepository = breweryRepository;
        this.kieContainer = kieContainer;
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
}
