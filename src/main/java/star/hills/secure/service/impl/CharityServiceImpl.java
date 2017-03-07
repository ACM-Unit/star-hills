package star.hills.secure.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import star.hills.secure.entity.Charity;
import star.hills.secure.repository.CharityRepository;
import star.hills.secure.service.CharityService;

import java.util.List;

/**
 * Created by Admin on 05.05.2016.
 */
@Service
public class CharityServiceImpl implements CharityService {
    @Autowired
    private CharityRepository charityRepository;

    @Override
    public Charity getBuyId(int id) {return charityRepository.findOne(id);}

    @Override
    public Charity getCharity(String name) {
        return charityRepository.findByName(name);
    }

    @Override
    public Charity addCharity(Charity charity) {
        return charityRepository.saveAndFlush(charity);
    }

    @Override
    public void delete(int id) {
charityRepository.delete(id);
    }

    @Override
    public List<Charity> getAll() {
        return charityRepository.findAll();
    }

    @Override
    public Charity editCharity(Charity charity) {
        return charityRepository.saveAndFlush(charity);
    }

    @Override
    public List<Charity> charityByStatus(int status) {
        return charityRepository.findByStatus(status);
    }

/*    @Override
    public List<Charity> charityByStar(Star star) {
        return charityRepository.findByStar(star);
    }*/

    @Override
    public List<Charity> getActiveCharity(int status) {
        return charityRepository.findByStatusLessThan(status);
    }

    @Override
    public Page<Charity> getAllCharity(int page) {

            return charityRepository.findAll(new PageRequest(page,10, Sort.Direction.DESC, "date"));
        }

    @Override
    public Page<Charity> getCharityByActivate(int page, boolean activate) {
        return charityRepository.findByActivate(new PageRequest(page,10, Sort.Direction.DESC, "date"), activate);
    }

}
