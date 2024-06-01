package brewbuddy.dtos;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class TokenDTO {
    private String token;
    private long expiresIn;
}