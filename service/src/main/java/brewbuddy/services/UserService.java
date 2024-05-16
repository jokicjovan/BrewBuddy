package brewbuddy.services;

import brewbuddy.exceptions.BadRequestException;
import brewbuddy.models.User;
import brewbuddy.exceptions.NotFoundException;
import brewbuddy.services.interfaces.IUserService;
import brewbuddy.repositories.CredentialRepository;
import brewbuddy.repositories.UserRepository;
import org.kie.api.runtime.KieContainer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class UserService implements IUserService {

    private final UserRepository userRepository;
    private final CredentialRepository credentialRepository;
    private final KieContainer kieContainer;

    @Autowired
    public UserService(KieContainer kieContainer, UserRepository userRepository, CredentialRepository credentialRepository) {
        this.userRepository = userRepository;
        this.kieContainer = kieContainer;
        this.credentialRepository = credentialRepository;
    }

    @Override
    public User get(Integer id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            return user.get();
        } else {
            throw new NotFoundException("User does not exist");
        }
    }

    @Override
    public List<User> getAll() {
        return userRepository.findAll();
    }

    @Override
    public User insert(User user) {
        try {
            return userRepository.save(user);
        } catch (DataIntegrityViolationException e) {
            throw new BadRequestException("Email already in use");
        }
    }

}
