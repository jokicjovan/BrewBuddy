package brewbuddy.services.interfaces;

import brewbuddy.models.Festival;
import brewbuddy.models.User;

import java.util.List;

public interface IFestivalService {
    Festival get(Integer id);

    List<Festival> getAll();

    Festival insert(Festival festival);

    List<Festival> recommend(User user);
}
