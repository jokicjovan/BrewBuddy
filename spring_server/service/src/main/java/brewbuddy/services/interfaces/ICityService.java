package brewbuddy.services.interfaces;

import brewbuddy.models.City;

import java.util.List;

public interface ICityService {
    City get(Integer id);

    List<City> getAll();

    City insert(City city);
}
