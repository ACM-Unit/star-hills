package star.hills.secure.entity;

import javax.persistence.*;

/**
 * Created by Admin on 14.07.2016.
 */
@Entity
@Table(name="wishedstar")
public class WishedStar {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name = "id", length = 6, nullable = false)
    private int id;
    @Column(name = "name")
    private String name;
    @Column(name = "email")
    private String email;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
