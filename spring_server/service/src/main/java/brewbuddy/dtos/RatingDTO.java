package brewbuddy.dtos;

import brewbuddy.events.Rating;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class RatingDTO {
    private Integer rating;
    private String comment;
    private UserSimpleDTO user;
    private BeerDTO beer;
    private Date timestamp;
    private Integer id;

    public static RatingDTO convertToDTO(Rating rating) {
        RatingDTO dto = new RatingDTO();
        dto.setId(rating.getId());
        dto.setComment(rating.getComment());
        dto.setUser(UserSimpleDTO.convertToDTO(rating.getUser()));
        dto.setBeer(BeerDTO.convertToDTO(rating.getBeer()));
        dto.setTimestamp(rating.getTimestamp());
        dto.setRating(rating.getRate());
        return dto;
    }
}
