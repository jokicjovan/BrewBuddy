package brewbuddy.dtos;

import brewbuddy.models.City;
import brewbuddy.models.Festival;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@NoArgsConstructor
public class FestivalDTO {
    private Integer id;
    private String name;
    private Date eventDate;
    private City city;
    private List<BreweryDTO> breweries;

    public static FestivalDTO convertToDetailedDTO(Festival festival) {
        FestivalDTO dto = new FestivalDTO();
        dto.setId(festival.getId());
        dto.setName(festival.getName());
        dto.setCity(festival.getCity());
        dto.setEventDate(festival.getEventDate());
        dto.setBreweries(festival.getBreweries().stream()
                .map(BreweryDTO::convertToSimpleDTO)
                .collect(Collectors.toList()));
        return dto;
    }
}
