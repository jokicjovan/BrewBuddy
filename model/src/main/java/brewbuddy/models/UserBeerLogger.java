package brewbuddy.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.kie.api.definition.type.Role;
import org.kie.api.definition.type.Timestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name="UsersBeersLogger")
@Role(Role.Type.EVENT)
@Timestamp("timestamp")
public class UserBeerLogger {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="user_id", nullable=false)
    private User user;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="beer_id", nullable=false)
    private Beer beer;

    @Column(name = "timestamp",nullable = false)
    private Date timestamp;
}
