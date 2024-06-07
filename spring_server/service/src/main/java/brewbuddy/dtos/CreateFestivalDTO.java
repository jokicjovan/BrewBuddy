package brewbuddy.dtos;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class CreateFestivalDTO {
    private String name;
    private Date eventDate;
    private Integer cityId;
    private List<Integer> breweryIds;
}
