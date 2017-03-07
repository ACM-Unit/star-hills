package star.hills.secure.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import star.hills.secure.entity.Order;
import star.hills.secure.entity.Star;

import java.util.Date;
import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    List<Order> findByStar(Star star);
    List<Order> findByStarAndActive(Star star, int active);
    Page<Order> findAllByStarAndActive(Pageable pageable, Star star, int active);
    List<Order> findByDateBetween(Date datestart, Date datefinish);


}
