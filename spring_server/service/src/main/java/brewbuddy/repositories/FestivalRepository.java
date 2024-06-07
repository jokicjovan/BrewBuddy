package brewbuddy.repositories;

import brewbuddy.models.Brewery;
import brewbuddy.models.Festival;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FestivalRepository extends JpaRepository<Festival,Integer> {
    public List<Festival> getFestivalsByBreweries(Brewery brewery);
}
