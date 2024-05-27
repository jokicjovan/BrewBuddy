package brewbuddy.dtos;

import brewbuddy.models.Beer;
import brewbuddy.models.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class UserSimpleDTO {
    private String name;
    private String surname;
    private Date birthDate;
    private Integer id;

    public static UserSimpleDTO convertToDTO(User user) {
        UserSimpleDTO dto = new UserSimpleDTO();
        dto.setId(user.getId());
        dto.setName(user.getName());
        dto.setSurname(user.getSurname());
        dto.setBirthDate(user.getBirthDate());
        return dto;
    }
}
