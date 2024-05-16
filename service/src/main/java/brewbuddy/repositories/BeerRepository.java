package brewbuddy.repositories;

import brewbuddy.models.Beer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BeerRepository extends JpaRepository<Beer,Integer> {
}
