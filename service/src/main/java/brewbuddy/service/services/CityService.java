package brewbuddy.service.services;

import brewbuddy.model.City;
import brewbuddy.service.exceptions.NotFoundException;
import brewbuddy.service.interfaces.ICityService;
import brewbuddy.service.repositories.CityRepository;
import org.kie.api.runtime.KieContainer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CityService implements ICityService {
    private final CityRepository cityRepository;
    private final KieContainer kieContainer;

    @Autowired
    public CityService(KieContainer kieContainer, CityRepository cityRepository) {
        this.cityRepository = cityRepository;
        this.kieContainer = kieContainer;
    }
    @Override
    public City get(Integer id) {
        Optional<City> city = cityRepository.findById(id);
        if (city.isPresent()) {
            return city.get();
        } else {
            throw new NotFoundException("City does not exist");
        }
    }

    @Override
    public List<City> getAll() {
        return cityRepository.findAll();
    }

    @Override
    public City insert(City city) {
        return cityRepository.save(city);
    }
}
