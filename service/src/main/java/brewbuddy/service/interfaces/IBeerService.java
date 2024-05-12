package brewbuddy.service.interfaces;

import brewbuddy.model.Beer;

import java.util.List;

public interface IBeerService {
    Beer get(Integer id);

    List<Beer> getAll();

    Beer insert(Beer beer);
}
