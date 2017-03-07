package star.hills.secure.entity;

import org.hibernate.annotations.Type;

import javax.persistence.*;

/**
 * Created by slava on 28.04.16.
 */
@Entity
@Table(name="star")
public class Star {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "id", length = 6, nullable = false)
    private int id;
    @Column(name = "name")
    private String name;
    @Column(name="alias")
    private String alias;
    @Column(name="price")
    private Integer price;
    @Column(name="video")
    private int video=0;
    @Column(name="email", unique=true)
    private String email;
    @Column(name = "skype")
    private String skype;
    @Column(name="confirm")
    private String confirm;
    @Column(name="recoverpass")
    private String recoverpass;
    @Column(name="phone")
    private String phone;
    @Column(name="balance")
    private int balance=0;
    @OneToOne(fetch= FetchType.EAGER, cascade={CascadeType.MERGE, CascadeType.PERSIST})
    @JoinColumn(name="user_id", nullable=false)
    private User user;
    @ManyToOne(fetch=FetchType.EAGER, cascade={CascadeType.MERGE, CascadeType.PERSIST})
    @JoinColumn(name="category_id", nullable=true)
    private Category category;
    @Column(name="comment", columnDefinition = "TEXT")
    @Type(type="text")
    private String comment;
    @Column(name="comment_admin", columnDefinition = "TEXT")
    @Type(type="text")
    private String commentadmin;
    @Column(name="status")
    private boolean status;
    @Column(name="activate")
    private boolean activate;
    @Column(name="skypecheck")
    private boolean skypecheck;
    @Column(name="aboutme")
    private boolean aboutme;
    public Star(String name, Integer price, String alias, String email, String skype, String phone, User user, Category category, String comment, String commentadmin, int video, boolean status, boolean activate, int balance, String confirm, boolean skypecheck, boolean aboutme) {
        this.name = name;
        this.price = price;
        this.alias = alias;
        this.video = video;
        this.email = email;
        this.skype = skype;
        this.phone = phone;
        this.user = user;
        this.category = category;
        this.comment = comment;
        this.status=status;
        this.balance=balance;
        this.activate=activate;
        this.confirm=confirm;
        this.commentadmin=commentadmin;
        this.skypecheck=skypecheck;
        this.aboutme=aboutme;
    }
    public Star() {
    }
    public String getRecoverpass() {
        return recoverpass;
    }
    public void setRecoverpass(String recoverpass) {
        this.recoverpass = recoverpass;
    }
    public boolean isSkypecheck() {
        return skypecheck;
    }

    public void setSkypecheck(boolean skypecheck) {
        this.skypecheck = skypecheck;
    }

    public boolean isAboutme() {
        return aboutme;
    }

    public void setAboutme(boolean aboutme) {
        this.aboutme = aboutme;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getConfirm() {
        return confirm;
    }

    public void setConfirm(String confirm) {
        this.confirm = confirm;
    }

    public boolean isActivate() {
        return activate;
    }

    public void setActivate(boolean activate) {
        this.activate = activate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getBalance() {
        return balance;
    }

    public void setBalance(int balance) {
        this.balance = balance;
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

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public int getVideo() {
        return video;
    }

    public void setVideo(int video) {
        this.video = video;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSkype() {
        return skype;
    }

    public void setSkype(String skype) {
        this.skype = skype;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCommentadmin() {return commentadmin;}

    public void setCommentadmin(String commentadmin) {this.commentadmin = commentadmin;}

    @Override
    public String toString() {
        return "Star{" +
                "name='" + name + '\'' +
                ", id=" + id +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Star star = (Star) o;
        if (id != star.id) return false;
        return true;
    }
    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (alias != null ? alias.hashCode() : 0);
        result = 31 * result + (price != null ? price.hashCode() : 0);
        result = 31 * result + video;
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (skype != null ? skype.hashCode() : 0);
        result = 31 * result + (confirm != null ? confirm.hashCode() : 0);
        result = 31 * result + (phone != null ? phone.hashCode() : 0);
        result = 31 * result + balance;
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + (category != null ? category.hashCode() : 0);
        result = 31 * result + (comment != null ? comment.hashCode() : 0);
        result = 31 * result + (commentadmin != null ? commentadmin.hashCode() : 0);
        result = 31 * result + (status ? 1 : 0);
        result = 31 * result + (activate ? 1 : 0);
        result = 31 * result + (skypecheck ? 1 : 0);
        result = 31 * result + (aboutme ? 1 : 0);
        return result;
    }
}
