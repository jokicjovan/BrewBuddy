package brewbuddy.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name="Breweries")
public class Brewery {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String name;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="city_id", nullable=false)
    private City city;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "brewery", cascade = CascadeType.ALL)
    private ArrayList<Beer> beers;
}
