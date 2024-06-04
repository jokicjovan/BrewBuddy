package brewbuddy.services.interfaces;

import brewbuddy.events.Rating;
import brewbuddy.models.Beer;
import brewbuddy.models.Brewery;
import brewbuddy.models.User;
import brewbuddy.events.UserBeerLogger;
import brewbuddy.enums.BeerType;

import java.util.HashMap;
import java.util.List;

public interface IBeerService {
    Beer get(Integer id);

    List<Beer> getAll();

    List<Beer> getByType(BeerType type);

    Beer insert(Beer beer);

    List<Beer> recommend(User user);

    List<Beer> filterBeers(BeerType type, Brewery brewery, String alcoholCategory);

    HashMap<Brewery, Beer> getMostPopularBeerByBrewery(List<Brewery> breweries);

    Rating rate(User user, Beer beer, Integer rate, String comment);

    UserBeerLogger logBeer(User user, Beer beer);

    List<Beer> mostPopularBeers();

    List<BeerType> mostLovedCategories();
}
