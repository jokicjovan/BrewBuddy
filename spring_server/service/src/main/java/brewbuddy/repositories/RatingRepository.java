package brewbuddy.repositories;

import brewbuddy.events.Rating;
import brewbuddy.models.Beer;
import brewbuddy.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RatingRepository extends JpaRepository<Rating,Integer> {
    boolean existsRatingByBeerAndUser(Beer beer, User user);
}
