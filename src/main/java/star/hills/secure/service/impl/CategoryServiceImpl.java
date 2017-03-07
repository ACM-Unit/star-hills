package star.hills.secure.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import star.hills.secure.entity.Category;
import star.hills.secure.entity.Section;
import star.hills.secure.repository.CategoryRepository;
import star.hills.secure.service.CategoryService;

import java.util.List;

/**
 * Created by Admin on 05.05.2016.
 */
@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryRepository categoryRepository;
    @Override
    public Category getCategory(int id) {
        return categoryRepository.findOne(id);
    }
    @Override
    public Category getCategoryByName(String name) {
        return categoryRepository.findByName(name);
    }
    @Override
    public List<Category> getCategoryBySection(Section section) {
        return categoryRepository.findBySection(section);
    }

    @Override
    public Category addCategory(Category category) {
        return categoryRepository.saveAndFlush(category);
    }

    @Override
    public void delete(int id) {
categoryRepository.delete(id);
    }

    @Override
    public List<Category> getAll() {
        return categoryRepository.findAll();
    }

    @Override
    public List<Category> getAllByStatus(boolean status) {
        return categoryRepository.findByStatus(status);
    }

    @Override
    public Category editCategory(Category category) {
        return categoryRepository.saveAndFlush(category);
    }
}
