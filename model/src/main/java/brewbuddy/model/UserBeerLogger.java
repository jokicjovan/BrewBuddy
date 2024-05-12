package brewbuddy.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name="UsersBeersLogger")
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
    private LocalDateTime timestamp;
}
