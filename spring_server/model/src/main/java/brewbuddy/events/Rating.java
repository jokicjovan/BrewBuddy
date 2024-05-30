package brewbuddy.events;


import brewbuddy.models.Beer;
import brewbuddy.models.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;
import org.kie.api.definition.type.Role;
import org.kie.api.definition.type.Timestamp;

import javax.persistence.*;
import java.util.Date;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name="Ratings")
@Role(Role.Type.EVENT)
@Timestamp("timestamp")
public class Rating {
    @Column(name = "rate", nullable = false)
    @Range(min = 1,max = 5)
    private Integer rate;

    @Column(name = "comment")
    private String comment;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "beer_id")
    private Beer beer;

    @Column(name = "timestamp",nullable = false)
    private Date timestamp;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
}
