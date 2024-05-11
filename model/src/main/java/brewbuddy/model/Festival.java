package brewbuddy.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name="Festivals")
public class Festival {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "event_date", nullable = false)
    private Date eventDate;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="city_id", nullable=false)
    private City city;

    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Brewery> breweries;
}
