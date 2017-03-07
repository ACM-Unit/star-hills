package star.hills.secure.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import star.hills.secure.entity.Category;
import star.hills.secure.entity.Section;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
public interface CategoryRepository extends JpaRepository<Category, Integer> {
    Category findByName(String name);
    List<Category> findBySection(Section section);
    List<Category> findByStatus(boolean status);
}
