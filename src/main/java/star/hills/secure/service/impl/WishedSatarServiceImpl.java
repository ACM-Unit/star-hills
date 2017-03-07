package star.hills.secure.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import star.hills.secure.entity.WishedStar;
import star.hills.secure.repository.WishedStarRepository;
import star.hills.secure.service.WishedStarService;

import java.util.List;

/**
 * Created by Admin on 14.07.2016.
 */
@Service
public class WishedSatarServiceImpl implements WishedStarService {
    @Autowired
    WishedStarRepository repository;
    @Override
    public List<WishedStar> getAll() {
        return repository.findAll();
    }

    @Override
    public WishedStar getById(int id) {
        return repository.findOne(id);
    }

    @Override
    public void addWishedStar(WishedStar wishedStar) {
        repository.saveAndFlush(wishedStar);
    }
}
