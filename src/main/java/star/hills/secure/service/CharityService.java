package star.hills.secure.service;

import org.springframework.data.domain.Page;
import star.hills.secure.entity.Charity;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
public interface CharityService {
    Charity getBuyId(int id);

    Charity getCharity(String name);

    Charity addCharity(Charity charity);

    void delete(int id);

    List<Charity> getAll();

    Charity editCharity(Charity charity);

    List<Charity> charityByStatus(int status);

    /* List<Charity> charityByStar(Star star);*/
    List<Charity> getActiveCharity(int status);

    Page<Charity> getAllCharity(int page);

    Page<Charity> getCharityByActivate(int page, boolean activate);
}