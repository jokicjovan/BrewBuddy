package brewbuddy.dtos;

import brewbuddy.models.Beer;
import brewbuddy.enums.BeerType;
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
    private String imageName;

    public static BeerDTO convertToDTO(Beer beer) {
        BeerDTO dto = new BeerDTO();
        dto.setId(beer.getId());
        dto.setName(beer.getName());
        dto.setPercentageOfAlcohol(beer.getPercentageOfAlcohol());
        dto.setIbu(beer.getIbu());
        dto.setPrice(beer.getPrice());
        dto.setType(beer.getType());
        dto.setBrewery(BrewerySimpleDTO.convertToDTO(beer.getBrewery()));
        dto.setImageName(beer.getImageName());
        return dto;
    }
}
