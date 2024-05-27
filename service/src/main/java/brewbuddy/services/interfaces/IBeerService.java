package brewbuddy.services.interfaces;

import brewbuddy.models.Beer;
import brewbuddy.models.Brewery;
import brewbuddy.models.User;
import brewbuddy.models.UserBeerLogger;
import brewbuddy.models.enums.BeerType;

import java.util.List;

public interface IBeerService {
    Beer get(Integer id);

    List<Beer> getAll();

    Beer insert(Beer beer);

    List<Beer> recommend(User user);

    List<Beer> filterBeers(BeerType type, Brewery brewery, String alcoholCategory);

    UserBeerLogger logBeer(User user, Beer beer);
}
