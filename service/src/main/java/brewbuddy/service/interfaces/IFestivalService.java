package brewbuddy.service.interfaces;

import brewbuddy.model.Festival;

import java.util.List;

public interface IFestivalService {
    Festival get(Integer id);

    List<Festival> getAll();

    Festival insert(Festival festival);
}
