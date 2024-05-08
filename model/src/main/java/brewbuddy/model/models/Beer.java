package brewbuddy.model.models;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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

    @Column(name = "percentage_of_alcohol", nullable = false)
    private Double percentageOfAlcohol;

    @Column(name = "ibu", nullable = false)
    private Double ibu;

    @Column(name = "price", nullable = false)
    @Positive
    private Double price;

    @Column(name = "type", nullable = false)
    private BeerType type;






}
