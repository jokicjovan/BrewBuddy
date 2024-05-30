package brewbuddy.repositories;

import brewbuddy.models.Credential;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CredentialRepository extends JpaRepository<Credential,Integer> {
    Optional<Credential> findCredentialByEmail(String email);
}
