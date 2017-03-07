package star.hills.secure.service;

import org.springframework.stereotype.Service;
import star.hills.secure.entity.WishedStar;

import java.util.List;

/**
 * Created by Admin on 14.07.2016.
 */
@Service
public interface WishedStarService {
    List<WishedStar> getAll();
    WishedStar getById(int id);
    void addWishedStar(WishedStar wishedStar);
}
