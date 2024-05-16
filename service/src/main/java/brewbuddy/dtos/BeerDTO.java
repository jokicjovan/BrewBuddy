package brewbuddy.dtos;

import brewbuddy.models.Beer;
import brewbuddy.models.Brewery;
import brewbuddy.models.enums.BeerType;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
public class BeerDTO {
    private Integer id;
    private String name;
    private Double percentageOfAlcohol;
    private Double ibu;
    private Double price;
    private BeerType type;
    private BrewerySimpleDTO brewery;

    public static BeerDTO convertToDTO(Beer beer) {
        BeerDTO dto = new BeerDTO();
        dto.setId(beer.getId());
        dto.setName(beer.getName());
        dto.setPercentageOfAlcohol(beer.getPercentageOfAlcohol());
        dto.setIbu(beer.getIbu());
        dto.setPrice(beer.getPrice());
        dto.setType(beer.getType());
        dto.setBrewery(BrewerySimpleDTO.convertToDTO(beer.getBrewery()));
        return dto;
    }
}
