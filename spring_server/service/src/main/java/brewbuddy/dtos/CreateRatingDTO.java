package brewbuddy.dtos;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
public class CreateRatingDTO {

    @NotNull
    @NotEmpty
    @Range(min = 1, max = 5)
    private Integer rate;
    @NotNull
    private String comment;
}
