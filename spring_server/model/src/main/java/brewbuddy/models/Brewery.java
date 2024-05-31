package brewbuddy.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

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
    private List<Beer> beers;

    @Column(name = "image_name")
    private String imageName;

    @Override
    public String toString() {
        return "Brewery{" +
                "id=" + id +
                '}';
    }
}
