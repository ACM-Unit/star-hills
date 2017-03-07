package star.hills.secure.entity;

import javax.persistence.*;

/**
 * Created by androlekss on 23.08.16.
 */

@Entity
@Table(name="starcharity")
public class StarCharity{
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name="id", length=6, nullable=false)
    private int id;
    @ManyToOne(fetch= FetchType.EAGER, cascade={CascadeType.MERGE, CascadeType.PERSIST})
    @JoinColumn(name="star_id", nullable=false)
    private Star star;
    @ManyToOne(fetch= FetchType.EAGER, cascade={CascadeType.MERGE, CascadeType.PERSIST})
    @JoinColumn(name="charity_id", nullable=false)
    private Charity charity;

    public StarCharity(Star star, Charity charity) {
        this.star = star;
        this.charity = charity;
    }

    public StarCharity() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Star getStar() {
        return star;
    }

    public void setStar(Star star) {
        this.star = star;
    }

    public Charity getCharity() {
        return charity;
    }

    public void setCharity(Charity charity) {
        this.charity = charity;
    }

    @Override
    public String toString() {
        return "StarCharity{" +
                "id=" + id +
                ", star=" + star.getName() + star.getId() +
                ", charity=" + charity.getName() +charity.getId()+
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        StarCharity that = (StarCharity) o;


        if (!star.equals(that.star)) return false;
        return charity.equals(that.charity);

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + star.hashCode();
        result = 31 * result + charity.hashCode();
        return result;
    }
}
