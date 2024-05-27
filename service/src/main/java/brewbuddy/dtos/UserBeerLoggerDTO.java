package brewbuddy.dtos;

import brewbuddy.models.UserBeerLogger;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class UserBeerLoggerDTO {
    private Integer Id;
    private UserSimpleDTO userSimpleDTO;
    private BeerDTO beerDTO;
    private Date timestamp;

    public static UserBeerLoggerDTO convertToDTO(UserBeerLogger userBeerLogger) {
        UserBeerLoggerDTO dto = new UserBeerLoggerDTO();
        dto.setId(userBeerLogger.getId());
        dto.setBeerDTO(BeerDTO.convertToDTO(userBeerLogger.getBeer()));
        dto.setUserSimpleDTO(UserSimpleDTO.convertToDTO(userBeerLogger.getUser()));
        dto.setTimestamp(userBeerLogger.getTimestamp());
        return dto;
    }
}
