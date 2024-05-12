package brewbuddy.service.interfaces;

import brewbuddy.model.Brewery;

import java.util.List;

public interface IBreweryService {
    Brewery get(Integer id);

    List<Brewery> getAll();

    Brewery insert(Brewery brewery);
}
