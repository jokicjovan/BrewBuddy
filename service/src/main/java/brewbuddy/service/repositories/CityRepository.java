package brewbuddy.service.repositories;

import brewbuddy.model.City;
import brewbuddy.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CityRepository extends JpaRepository<City,Integer> {
}
