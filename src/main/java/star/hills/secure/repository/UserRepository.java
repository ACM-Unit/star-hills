package star.hills.secure.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import star.hills.secure.entity.User;

/**
 * Created by Admin on 29.04.2016.
 */
@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByLogin(String login);
}
