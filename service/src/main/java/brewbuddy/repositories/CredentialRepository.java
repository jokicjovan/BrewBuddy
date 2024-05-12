package brewbuddy.repositories;

import brewbuddy.model.Credential;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CredentialRepository extends JpaRepository<Credential,Integer> {
}
