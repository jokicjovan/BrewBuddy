package brewbuddy.dtos;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class RegisterUserDTO {
    private String email;
    private String password;
    private String name;
    private String surname;
    private Date birthDate;
}
