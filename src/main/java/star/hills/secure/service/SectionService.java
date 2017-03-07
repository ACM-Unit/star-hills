package star.hills.secure.service;

import star.hills.secure.entity.Section;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
public interface SectionService {
    Section getSection(String name);
    Section addSection(Section section);
    void delete(int id);
    List<Section> getAll(String name);
    Section editSection(Section section);
}
