package brewbuddy.controllers;

import brewbuddy.dtos.TokenDTO;
import brewbuddy.dtos.LoginDTO;
import brewbuddy.dtos.RegisterDTO;
import brewbuddy.models.Credential;
import brewbuddy.models.User;
import brewbuddy.services.AuthenticationService;
import brewbuddy.services.JwtService;
import brewbuddy.services.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final JwtService jwtService;
    private final AuthenticationService authenticationService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public AuthController(JwtService jwtService, AuthenticationService authenticationService, UserService userService,
                          PasswordEncoder passwordEncoder) {
        this.jwtService = jwtService;
        this.authenticationService = authenticationService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/register")
    public ResponseEntity<User> register(@RequestBody RegisterDTO registerDTO) {
        User user = new User();
        user.setName(registerDTO.getName());
        user.setSurname(registerDTO.getSurname());
        user.setBirthDate(registerDTO.getBirthDate());
        Credential credential = new Credential();
        credential.setEmail(registerDTO.getEmail());
        credential.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
        User registeredUser = authenticationService.register(user, credential);
        return ResponseEntity.ok(registeredUser);
    }

    @PostMapping("/login")
    public ResponseEntity<TokenDTO> login(@RequestBody LoginDTO loginDTO) {
        Credential userCredential = authenticationService.authenticate(loginDTO.getEmail(), loginDTO.getPassword());
        String jwtToken = jwtService.generateToken(userCredential);
        TokenDTO loginResponse = new TokenDTO();
        loginResponse.setToken(jwtToken);
        loginResponse.setExpiresIn(jwtService.getExpirationTime());
        return ResponseEntity.ok(loginResponse);
    }

    @PostMapping("/validate-token")
    public ResponseEntity<String> validateToken() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = ((Credential) authentication.getPrincipal()).getUser();
        User user = userService.get(currentUser.getId());
        if (user != null){
            return ResponseEntity.ok("Token is valid");
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token is invalid");
    }
}
