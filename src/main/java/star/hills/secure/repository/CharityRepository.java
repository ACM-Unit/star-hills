package star.hills.secure.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import star.hills.secure.entity.Charity;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
@Repository
public interface CharityRepository extends JpaRepository<Charity, Integer> {
   Charity findByName(String name);
   List<Charity> findByStatus(int status);
/* List<Charity> findByStar(Star star);*/
   List<Charity> findByStatusLessThan(int status);
   Page<Charity> findAll(Pageable pageable);
   Page<Charity> findByActivate(Pageable pageable, boolean activate);
}
