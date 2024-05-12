package brewbuddy.repositories;

import brewbuddy.model.Festival;
import brewbuddy.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FestivalRepository extends JpaRepository<Festival,Integer> {
}
