package brewbuddy.repositories;

import brewbuddy.model.Brewery;
import brewbuddy.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BreweryRepository extends JpaRepository<Brewery,Integer> {
}
