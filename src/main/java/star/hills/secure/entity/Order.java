package star.hills.secure.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by slava on 28.04.16.
 */
@Entity
@Table(name="orders")
public class Order {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="id", length=6, nullable=false)
    private int id;
    @Column(name="name")
    private String name;
    @Column(name="nametwo")
    private String nametwo;
    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.PERSIST})
    @JoinColumn(name = "star_id", nullable = false)
    private Star star;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="date", columnDefinition="DATETIME")
    private Date date;
    @Column(name="email")
    private String email;
    @Column(name="emailtwo")
    private String emailtwo;
    @Column(name="phone")
    private String phone;
    @Column(name="phonetwo")
    private String phonetwo;
    @Column(name="event")
    private String event;
    @Column(name="text")
    private String text;
    @Column(name="paidstatus")
    private boolean paidstatus;
    @Column(name="paymentsystem")
    private String paymentsystem;
    @Column(name="photo")
    private String photo;
    @Column(name="pathvideo")
    private String pathvideo;
    @Column(name="active")
    private int active;
    @Column(name="audioname")
    private String audioname;
    @Column(name="audiogreeting")
    private String audiogreeting;
    @Column(name="payment")
    private int payment;
    @Column(name="typemessage")
    private int typemessage;
    @Column(name="createddate", columnDefinition="DATETIME")
    private Date createddate;

    public String getPaymentsystem() {
        return paymentsystem;
    }

    public void setPaymentsystem(String paymentsystem) {
        this.paymentsystem = paymentsystem;
    }

    public Date getCreateddate() {
        return createddate;
    }

    public void setCreateddate(Date createddate) {
        this.createddate = createddate;
    }

    public int getTypemessage() {return typemessage;}

    public void setTypemessage(int typemessage) {this.typemessage = typemessage;}

    public String getAudioname() {return audioname;}

    public void setAudioname(String audioname) {this.audioname = audioname;}

    public String getAudiogreeting() {
        return audiogreeting;
    }

    public void setAudiogreeting(String audiogreeting) {
        this.audiogreeting = audiogreeting;
    }

    public boolean isPaidstatus() {
        return paidstatus;
    }

    public void setPaidstatus(boolean paidstatus) {
        this.paidstatus = paidstatus;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public String getPathvideo() {
        return pathvideo;
    }
    public void setPathvideo(String pathvideo) {
        this.pathvideo = pathvideo;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getNametwo() {
        return nametwo;
    }

    public void setNametwo(String nametwo) {
        this.nametwo = nametwo;
    }

    public String getEmailtwo() {
        return emailtwo;
    }

    public void setEmailtwo(String emailtwo) {
        this.emailtwo = emailtwo;
    }

    public String getPhonetwo() {
        return phonetwo;
    }

    public void setPhonetwo(String phonetwo) {
        this.phonetwo = phonetwo;
    }

    public int getPayment() { return payment; }

    public void setPayment(int payment) {this.payment = payment;}


}
