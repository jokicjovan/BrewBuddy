package brewbuddy.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.kie.api.definition.type.Position;

import java.util.Objects;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class StringWrapper {
    @Position(0)
    String child;
    @Position(1)
    String parent;
    @Position(2)
    String classname;

}
