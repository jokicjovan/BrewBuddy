package brewbuddy.controllers;

import brewbuddy.models.User;
import brewbuddy.services.interfaces.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/user")
public class UserController {
	private final IUserService userService;

	@Autowired

	public UserController(IUserService userService) {
		this.userService = userService;
	}

	@RequestMapping("/")
	public List<User> getAll(){
		return userService.getAll();
	}

	@RequestMapping("/{id}")
	public User getById(@PathVariable Integer id){
		return userService.get(id);
	}

	@RequestMapping("/popular")
	public List<User> getMostPopularUsers(){
		return userService.mostPopularUsers();
	}
}
