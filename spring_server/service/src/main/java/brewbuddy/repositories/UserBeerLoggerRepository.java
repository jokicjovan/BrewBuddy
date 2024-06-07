package brewbuddy.repositories;

import brewbuddy.events.UserBeerLogger;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserBeerLoggerRepository extends JpaRepository<UserBeerLogger,Integer> {
}
