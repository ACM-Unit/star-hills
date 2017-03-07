package star.hills.secure.entity;

import javax.persistence.*;
import java.sql.Date;

/**
 * Created by slava on 28.04.16.
 */
@Entity
@Table(name="charity")
public class Charity {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="id", length=6, nullable=false)
    private int id;
    @Column(name="nameproject")
    private String nameproject;
    @Column(name="name")
    private String name;
    @Column(name="email")
    private String email;
    @Column(name="date")
    private Date date;
    @Column(name="whereknow")
    private String whereknow;
    @Column(name="adress")
    private String adress;
    @Column(name="money")
    private double money;
    @Column(name="activate")
    private boolean activate;
    @Column(name="moneycollected")
    private double moneycollected;
    @Column(name="comment", columnDefinition = "TEXT")
    private String comment;
    @Column(name="mainphoto")
    private String mainphoto;
    @Column(name="photo")
    private String photo;
    @Column(name="video")
    private String video;
    @Column(name="document")
    private String document;
    @Column(name="status")
    private int status;
    @Column(name="paymentsystem")
    private String paymentsystem;

    public String getPaymentsystem() {
        return paymentsystem;
    }

    public void setPaymentsystem(String paymentsystem) {
        this.paymentsystem = paymentsystem;
    }

    public boolean isActivate() {
        return activate;
    }

    public void setActivate(boolean activate) {
        this.activate = activate;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public double getMoneycollected() {
        return moneycollected;
    }

    public void setMoneycollected(double moneycollected) {
        this.moneycollected = moneycollected;
    }

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

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public String getNameproject() {
        return nameproject;
    }

    public void setNameproject(String nameproject) {
        this.nameproject = nameproject;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getWhereknow() {
        return whereknow;
    }

    public void setWhereknow(String whereknow) {
        this.whereknow = whereknow;
    }

    public String getAdress() {
        return adress;
    }

    public void setAdress(String adress) {
        this.adress = adress;
    }

    public String getMainphoto() {
        return mainphoto;
    }

    public void setMainphoto(String mainphoto) {
        this.mainphoto = mainphoto;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public String getDocument() {
        return document;
    }

    public void setDocument(String document) {
        this.document = document;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Charity charity = (Charity) o;
        if (id != charity.id) return false;
        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = id;
        result = 31 * result + (nameproject != null ? nameproject.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (date != null ? date.hashCode() : 0);
        result = 31 * result + (whereknow != null ? whereknow.hashCode() : 0);
        result = 31 * result + (adress != null ? adress.hashCode() : 0);
        temp = Double.doubleToLongBits(money);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        temp = Double.doubleToLongBits(moneycollected);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (comment != null ? comment.hashCode() : 0);
        result = 31 * result + (mainphoto != null ? mainphoto.hashCode() : 0);
        result = 31 * result + (photo != null ? photo.hashCode() : 0);
        result = 31 * result + (video != null ? video.hashCode() : 0);
        result = 31 * result + (document != null ? document.hashCode() : 0);
        result = 31 * result + status;
        result = 31 * result + (paymentsystem != null ? paymentsystem.hashCode() : 0);
        return result;
    }
}
