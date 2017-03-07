package star.hills.secure.entity;

import javax.persistence.*;

/**
 * Created by Admin on 29.04.2016.
 */
@Entity
@Table(name="section")
public class Section {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="id", length=6, nullable=false)
    private int id;
    @Column(name="name")
    private String name;
    @Column(name="image")
    private String image;

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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
