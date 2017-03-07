package star.hills.secure.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.StarCharity;
import star.hills.secure.repository.StarCharityRepository;
import star.hills.secure.service.StarCharityService;

import java.util.List;

/**
 * Created by androlekss on 23.08.16.
 */

@Service
public class StarCharityServiceImpl implements StarCharityService{

    @Autowired
    private StarCharityRepository starCharityRepository;

    @Override
    public StarCharity addStarCharity(StarCharity starCharity) {return starCharityRepository.saveAndFlush(starCharity); }

    @Override
    public List<StarCharity> charityByStar(Star star) {return starCharityRepository.findByStar(star); }

    @Override
    public void delete(int id) {
        starCharityRepository.delete(id);
    }
}
