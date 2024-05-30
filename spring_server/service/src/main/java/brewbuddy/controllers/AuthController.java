package brewbuddy.controllers;

import brewbuddy.dtos.LoginResponseDTO;
import brewbuddy.dtos.LoginUserDTO;
import brewbuddy.dtos.RegisterUserDTO;
import brewbuddy.models.Credential;
import brewbuddy.models.User;
import brewbuddy.services.AuthenticationService;
import brewbuddy.services.JwtService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final JwtService jwtService;
    private final AuthenticationService authenticationService;
    private final PasswordEncoder passwordEncoder;

    public AuthController(JwtService jwtService, AuthenticationService authenticationService,
                          PasswordEncoder passwordEncoder) {
        this.jwtService = jwtService;
        this.authenticationService = authenticationService;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/register")
    public ResponseEntity<User> register(@RequestBody RegisterUserDTO registerUserDTO) {
        User user = new User();
        user.setName(registerUserDTO.getName());
        user.setSurname(registerUserDTO.getSurname());
        user.setBirthDate(registerUserDTO.getBirthDate());
        Credential credential = new Credential();
        credential.setEmail(registerUserDTO.getEmail());
        credential.setPassword(passwordEncoder.encode(registerUserDTO.getPassword()));
        User registeredUser = authenticationService.register(user, credential);

        return ResponseEntity.ok(registeredUser);
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody LoginUserDTO loginUserDTO) {
        Credential userCredential = authenticationService.authenticate(loginUserDTO.getEmail(), loginUserDTO.getPassword());
        String jwtToken = jwtService.generateToken(userCredential);
        LoginResponseDTO loginResponse = new LoginResponseDTO();
        loginResponse.setToken(jwtToken);
        loginResponse.setExpiresIn(jwtService.getExpirationTime());
        return ResponseEntity.ok(loginResponse);
    }
}
