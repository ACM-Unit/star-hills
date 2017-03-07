package star.hills.secure.service;

import star.hills.secure.entity.Category;
import star.hills.secure.entity.Section;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */

public interface CategoryService {
    Category getCategory(int id);
    Category getCategoryByName(String name);
    List<Category> getCategoryBySection(Section section);
    Category addCategory(Category category);
    void delete(int id);
    List<Category> getAll();
    List<Category> getAllByStatus(boolean status);
    Category editCategory(Category category);
}
