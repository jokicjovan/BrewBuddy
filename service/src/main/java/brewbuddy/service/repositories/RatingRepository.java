package brewbuddy.service.repositories;

import brewbuddy.model.Rating;
import brewbuddy.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RatingRepository extends JpaRepository<Rating,Integer> {
}
