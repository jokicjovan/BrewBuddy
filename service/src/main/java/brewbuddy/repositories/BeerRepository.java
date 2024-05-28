package brewbuddy.repositories;

import brewbuddy.models.Beer;
import brewbuddy.models.Brewery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BeerRepository extends JpaRepository<Beer,Integer> {
    @Query("SELECT b FROM Beer b " +
            "JOIN Rating r ON b.id = r.beer.id " +
            "WHERE b.brewery IN :breweries " +
            "GROUP BY b.id " +
            "HAVING AVG(r.rate) = (" +
            "SELECT MAX(AVG(r2.rate)) FROM Rating r2 " +
            "JOIN r2.beer b2 WHERE b2.brewery = b.brewery " +
            "GROUP BY b2.id)")
    List<Beer> getHighestRatedBeerByBrewery(@Param("breweries") List<Brewery> breweries);

    @Query("SELECT ubl.beer " +
            "FROM UserBeerLogger ubl " +
            "JOIN ubl.beer b " +
            "WHERE b.brewery = :brewery " +
            "GROUP BY ubl.beer " +
            "ORDER BY COUNT(ubl.beer) DESC")
    Page<Beer> getMostPopularBeersByBrewery(@Param("brewery") Brewery brewery, Pageable pageable);
}
