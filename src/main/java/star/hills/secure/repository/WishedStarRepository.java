package star.hills.secure.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import star.hills.secure.entity.WishedStar;

/**
 * Created by Admin on 14.07.2016.
 */
@Repository
public interface WishedStarRepository extends JpaRepository<WishedStar, Integer> {
}
