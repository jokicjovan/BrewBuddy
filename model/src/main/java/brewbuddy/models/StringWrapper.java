package brewbuddy.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.kie.api.definition.type.Position;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class StringWrapper {
    @Position(0)
    String x;
    @Position(1)
    String y;
    @Position(2)
    String classname;
}
