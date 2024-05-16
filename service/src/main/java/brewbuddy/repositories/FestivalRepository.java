package brewbuddy.repositories;

import brewbuddy.models.Festival;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FestivalRepository extends JpaRepository<Festival,Integer> {
}
