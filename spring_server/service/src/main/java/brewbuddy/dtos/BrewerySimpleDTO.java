package brewbuddy.dtos;

import brewbuddy.models.Brewery;
import brewbuddy.models.City;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class BrewerySimpleDTO {
    private Integer id;
    private String name;
    private City city;
    private String imageName;

    public static BrewerySimpleDTO convertToDTO(Brewery brewery) {
        BrewerySimpleDTO dto = new BrewerySimpleDTO();
        dto.setId(brewery.getId());
        dto.setName(brewery.getName());
        dto.setCity(brewery.getCity());
        dto.setImageName(brewery.getImageName());
        return dto;
    }
}
