package brewbuddy.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name="Users")
public class User{
    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "surname", nullable = false)
    private String surname;

    @Column(name = "birth_date",nullable = false)
    private Date birthDate;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
    private List<Coupon> coupons = new ArrayList<>();

    @Column(name = "is_account_non_expired",nullable = false)
    private boolean isAccountNonExpired = true;

    @Column(name = "is_account_non_locked",nullable = false)
    private boolean isAccountNonLocked = true;
}
