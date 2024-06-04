package brewbuddy.dtos;

import brewbuddy.models.Brewery;
import brewbuddy.models.City;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@NoArgsConstructor
public class BreweryDTO {
    private Integer id;
    private String name;
    private City city;
    private String imageName;
    private List<BeerDTO> beers;

    public static BreweryDTO convertToSimpleDTO(Brewery brewery) {
        BreweryDTO dto = new BreweryDTO();
        dto.setId(brewery.getId());
        dto.setName(brewery.getName());
        dto.setCity(brewery.getCity());
        dto.setImageName(brewery.getImageName());
        return dto;
    }

    public static BreweryDTO convertToDetailedDTO(Brewery brewery) {
        BreweryDTO dto = convertToSimpleDTO(brewery);
        dto.setBeers(brewery.getBeers().stream()
                .map(BeerDTO::convertToDTO)
                .collect(Collectors.toList()));
        return dto;
    }
}
