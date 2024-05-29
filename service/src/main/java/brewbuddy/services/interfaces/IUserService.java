package brewbuddy.services.interfaces;

import brewbuddy.models.User;

import java.util.List;

public interface IUserService {
    User get(Integer id);

    List<User> getAll();

    User insert(User user);

    List<User> mostPopularUsers();
}
