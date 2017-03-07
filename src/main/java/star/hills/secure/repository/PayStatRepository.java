package star.hills.secure.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import star.hills.secure.entity.PayStat;
import star.hills.secure.entity.Star;

import java.util.List;

/**
 * Created by Admin on 26.08.2016.
 */
public interface PayStatRepository extends JpaRepository<PayStat, Integer> {
    List<PayStat> findByStar(Star star);

}
