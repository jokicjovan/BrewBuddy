package brewbuddy.models;


import brewbuddy.enums.BeerType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.kie.api.definition.type.Position;

import javax.persistence.*;
import javax.validation.constraints.Positive;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name="Beers")
public class Beer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String name;

    @Position(2)
    @Column(name = "percentage_of_alcohol", nullable = false)
    private Double percentageOfAlcohol;

    @Position(3)
    @Column(name = "ibu", nullable = false)
    private Double ibu;

    @Column(name = "price", nullable = false)
    @Positive
    private Double price;

    @Position(1)
    @Column(name = "type", nullable = false)
    @Enumerated(EnumType.STRING)
    private BeerType type;

    @Position(0)
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="brewery_id", nullable = false)
    private Brewery brewery;

    @Column(name = "image_name")
    private String imageName;

    @Override
    public String toString() {
        return "Beer{" +
                "id=" + id +
                ", brewery=" + brewery +
                ", type=" + type +
                '}';
    }
}
