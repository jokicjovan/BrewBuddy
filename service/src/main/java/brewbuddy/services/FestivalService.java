package brewbuddy.services;

import brewbuddy.exceptions.NotFoundException;
import brewbuddy.models.Festival;
import brewbuddy.services.interfaces.IFestivalService;
import brewbuddy.repositories.FestivalRepository;
import org.kie.api.runtime.KieContainer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FestivalService implements IFestivalService {
    private final FestivalRepository festivalRepository;
    private final KieContainer kieContainer;

    @Autowired
    public FestivalService(KieContainer kieContainer, FestivalRepository festivalRepository) {
        this.festivalRepository = festivalRepository;
        this.kieContainer = kieContainer;
    }
    @Override
    public Festival get(Integer id) {
        Optional<Festival> festival = festivalRepository.findById(id);
        if (festival.isPresent()) {
            return festival.get();
        } else {
            throw new NotFoundException("Beer does not exist");
        }
    }

    @Override
    public List<Festival> getAll() {
        return festivalRepository.findAll();
    }

    @Override
    public Festival insert(Festival festival) {
        return festivalRepository.save(festival);
    }
}
