package star.hills.secure.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import star.hills.secure.entity.Category;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.User;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
@Repository
public interface StarRepository extends JpaRepository<Star, Integer> {
    Star findByName(String name);
    Star findByRecoverpass(String recoverpass);
    List<Star> findByCategory (Category category);
    Star findByUser(User user);
    Star findByEmail(String email);
    List<Star> findByActivateAndStatus(boolean activate, boolean status);
    List<Star> findByAliasOrNameLikeAndActivateAndStatus(String alias, String name, boolean activate, boolean status);
}
