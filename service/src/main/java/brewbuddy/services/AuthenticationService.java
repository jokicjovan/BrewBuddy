package brewbuddy.services;

import brewbuddy.models.Credential;
import brewbuddy.models.User;
import brewbuddy.repositories.CredentialRepository;
import brewbuddy.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthenticationService {

    private final UserRepository userRepository;
    private final CredentialRepository credentialRepository;
    private final AuthenticationManager authenticationManager;

    @Autowired
    public AuthenticationService(UserRepository userRepository, CredentialRepository credentialRepository,
                                 AuthenticationManager authenticationManager) {
        this.credentialRepository = credentialRepository;
        this.userRepository = userRepository;
        this.authenticationManager = authenticationManager;
    }

    @Transactional
    public User register(User user, Credential credential) {
        User savedUser = userRepository.save(user);
        credentialRepository.save(credential);
        return savedUser;
    }

    public Credential authenticate(String email, String password) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        email,
                        password
                )
        );

        return credentialRepository.findCredentialByEmail(email)
                .orElseThrow();
    }
}
