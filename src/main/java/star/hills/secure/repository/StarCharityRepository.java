package star.hills.secure.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.StarCharity;

import java.util.List;

/**
 * Created by androlekss on 23.08.16.
 */

@Repository
public interface StarCharityRepository extends JpaRepository<StarCharity, Integer> {

        List<StarCharity> findByStar(Star star);


}
