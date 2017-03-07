package star.hills.secure.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import star.hills.secure.entity.Section;
import star.hills.secure.repository.SectionRepository;
import star.hills.secure.service.SectionService;

import java.util.List;

/**
 * Created by Admin on 05.05.2016.
 */
@Service
public class SectionServiceImpl implements SectionService {
    @Autowired
    private SectionRepository sectionRepository;

    @Override
    public Section getSection(String name) {
        return sectionRepository.findByName(name);
    }

    @Override
    public Section addSection(Section section) {
        return sectionRepository.saveAndFlush(section);
    }

    @Override
    public void delete(int id) {
sectionRepository.delete(id);
    }

    @Override
    public List<Section> getAll(String name) {
        return sectionRepository.findByNameNot(name);
    }

    @Override
    public Section editSection(Section section) {
        return sectionRepository.saveAndFlush(section);
    }
}
