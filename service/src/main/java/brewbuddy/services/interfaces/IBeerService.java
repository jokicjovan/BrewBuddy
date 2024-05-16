package brewbuddy.services.interfaces;

import brewbuddy.models.Beer;

import java.util.List;

public interface IBeerService {
    Beer get(Integer id);

    List<Beer> getAll();

    Beer insert(Beer beer);

    List<Beer> recommend(Integer userId);
}
