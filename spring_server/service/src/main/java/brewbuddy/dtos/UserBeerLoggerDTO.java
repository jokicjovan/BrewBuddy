package brewbuddy.dtos;

import brewbuddy.events.UserBeerLogger;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class UserBeerLoggerDTO {
    private Integer Id;
    private UserSimpleDTO user;
    private BeerDTO beer;
    private Date timestamp;

    public static UserBeerLoggerDTO convertToDTO(UserBeerLogger userBeerLogger) {
        UserBeerLoggerDTO dto = new UserBeerLoggerDTO();
        dto.setId(userBeerLogger.getId());
        dto.setBeer(BeerDTO.convertToDTO(userBeerLogger.getBeer()));
        dto.setUser(UserSimpleDTO.convertToDTO(userBeerLogger.getUser()));
        dto.setTimestamp(userBeerLogger.getTimestamp());
        return dto;
    }
}
