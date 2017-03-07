package star.hills.secure.test.util;


import star.hills.secure.entity.*;
import star.hills.secure.entity.enums.UserRoleEnum;

public class UserUtil {

    public static User createUser() {
        User user = new User();
        user.setLogin("Ocean");
        user.setPassword("12345");
        user.setRole(UserRoleEnum.STAR);
        return user;
    }
    public static Star createStar(Category category, User user) {
        Star star = new Star();
        star.setName("Vakarchuk");
        star.setPrice(550);
        star.setCategory(category);
        star.setUser(user);
        star.setComment("Привет");
        return star;
    }
    public static Order createOrder(Star star){
        Order order=new Order();
        order.setEvent("birthday");
        order.setStar(star);
        order.setName("Oleg");
        order.setText("привет");
        return order;
    }
    public static Section createSection(){
        Section section=new Section();
       section.setName("music");
        return section;
    }
    public static Category createCategory(Section section){
        Category category=new Category();
        category.setName("Rock");
        category.setSection(section);
        return category;
    }
public static Video createVideo(Star star, Order order) {
    Video video = new Video();
    video.setPath("1111");
    video.setStar(star);
    video.setOrder(order);
    return video;
}
}
