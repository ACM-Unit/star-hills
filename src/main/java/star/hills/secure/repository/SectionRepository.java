package star.hills.secure.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import star.hills.secure.entity.Section;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
public interface SectionRepository extends JpaRepository<Section, Integer> {
    Section findByName(String name);
    List<Section> findByNameNot(String name);
}
