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
public class FestivalDetailedDTO {
    private Integer id;

    private String name;

    private Date eventDate;

    private City city;

    private List<BrewerySimpleDTO> breweries;

    public static FestivalDetailedDTO convertToDTO(Festival festival) {
        FestivalDetailedDTO dto = new FestivalDetailedDTO();
        dto.setId(festival.getId());
        dto.setName(festival.getName());
        dto.setCity(festival.getCity());
        dto.setEventDate(festival.getEventDate());
        dto.setBreweries(festival.getBreweries().stream()
                .map(BrewerySimpleDTO::convertToDTO)
                .collect(Collectors.toList()));
        return dto;
    }
}
