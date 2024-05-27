package brewbuddy;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.ApplicationContext;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan(basePackages = {"brewbuddy.models", "brewbuddy.events"})
@EnableJpaRepositories(basePackages = {"brewbuddy.repositories"})
@ComponentScan(basePackages = {"brewbuddy.services", "brewbuddy.controllers", "brewbuddy.exceptions",
		"brewbuddy.configurations"})
public class ServiceApplication  {
	
	private static Logger log = LoggerFactory.getLogger(ServiceApplication.class);
	public static void main(String[] args) {
		ApplicationContext ctx = SpringApplication.run(ServiceApplication.class, args);
	}
}
