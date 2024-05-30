package brewbuddy.repositories;

import brewbuddy.models.Brewery;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BreweryRepository extends JpaRepository<Brewery,Integer> {
}
