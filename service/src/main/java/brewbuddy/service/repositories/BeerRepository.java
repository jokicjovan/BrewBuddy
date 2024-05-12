package brewbuddy.service.repositories;

import brewbuddy.model.Beer;
import brewbuddy.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BeerRepository extends JpaRepository<Beer,Integer> {
}
