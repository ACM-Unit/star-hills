package star.hills.secure.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.Video;

/**
 * Created by Admin on 29.04.2016.
 */
public interface VideoRepository extends JpaRepository<Video, Integer> {
    Video findByStar(Star star);

}
