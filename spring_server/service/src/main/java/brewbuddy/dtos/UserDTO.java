package brewbuddy.dtos;

import brewbuddy.models.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class UserDTO {
    private String name;
    private String surname;
    private Date birthDate;
    private Integer id;

    public static UserDTO convertToSimpleDTO(User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setName(user.getName());
        dto.setSurname(user.getSurname());
        dto.setBirthDate(user.getBirthDate());
        return dto;
    }
}
