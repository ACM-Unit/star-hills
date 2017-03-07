package star.hills.secure.service;

import star.hills.secure.entity.Star;
import star.hills.secure.entity.StarCharity;

import java.util.List;

/**
 * Created by androlekss on 23.08.16.
 */
public interface StarCharityService {

    StarCharity addStarCharity(StarCharity starCharity);
    List<StarCharity> charityByStar(Star star);
    void delete(int id);
}
