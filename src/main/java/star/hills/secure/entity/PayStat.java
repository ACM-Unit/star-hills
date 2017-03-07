package star.hills.secure.entity;

import javax.persistence.*;
import java.sql.Date;

/**
 * Created by Admin on 26.08.2016.
 */
@Entity
@Table(name="paystat")
public class PayStat {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name="id", length=6, nullable=false)
    private int id;
    @Column(name="date", columnDefinition="DATETIME")
    private Date date;
    @Column(name="money")
    private int money;
    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.PERSIST})
    @JoinColumn(name = "star_id", nullable = false)
    private Star star;
    @Column(name="balance")
    private String balance;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
        this.money = money;
    }

    public Star getStar() {
        return star;
    }

    public void setStar(Star star) {
        this.star = star;
    }

    public String getBalance() {
        return balance;
    }

    public void setBalance(String balance) {
        this.balance = balance;
    }
}
