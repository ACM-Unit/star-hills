package star.hills.secure.service;

import org.springframework.web.multipart.MultipartFile;
import star.hills.secure.entity.Category;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.User;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
public interface StarService {
    Star getStar(String name);
    Star getStarByRecoverPass(String recoverpass);
    Star getStarById(int id);
    List<Star> getStarByCategory(Category category);
    Star getStarByUser(User user);
    Star addStar(Star star);
    Star getStarByEmail(String email);
    void delete(int id);
    List<Star> getAll();
    List<Star> getAllActiv(boolean active, boolean status);
    List<Star> getAllSearh(String alias, String name);
    Star editStar(Star star);
    String fileUpload(MultipartFile file, String name);
}
