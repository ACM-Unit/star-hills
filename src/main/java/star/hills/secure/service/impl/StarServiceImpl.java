package star.hills.secure.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import star.hills.secure.entity.Category;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.User;
import star.hills.secure.repository.StarRepository;
import star.hills.secure.service.StarService;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

/**
 * Created by Admin on 05.05.2016.
 */
@Service
public class StarServiceImpl implements StarService {

    @Autowired
    private StarRepository starRepository;

    @Override
    public Star getStar(String name) {
        Star star=starRepository.findByName(name);
        return star;
    }

    @Override
    public Star getStarByRecoverPass(String recoverpass) {
        return starRepository.findByRecoverpass(recoverpass);
    }

    @Override
    public Star getStarById(int id) {
        Star star=starRepository.findOne(id);
        return star;
    }

    @Override
    public List<Star> getStarByCategory(Category category) {
        return starRepository.findByCategory(category);
    }

    @Override
    public Star getStarByUser(User user) {
        Star star=starRepository.findByUser(user);
        return star;
    }

    @Override
    public Star addStar(Star star) {
        ShaPasswordEncoder encoder =new ShaPasswordEncoder();
        star.getUser().setPassword(encoder.encodePassword(star.getUser().getPassword(),""));
        return starRepository.saveAndFlush(star);
    }

    @Override
    public Star getStarByEmail(String email) {
        Star star=starRepository.findByEmail(email);
        return star;
    }

    @Override
    public void delete(int id) {
starRepository.delete(id);
    }

    @Override
    public List<Star> getAll() {
        return starRepository.findAll();
    }

    @Override
    public List<Star> getAllActiv(boolean active, boolean status) {
        return starRepository.findByActivateAndStatus(active ,status);
    }

    @Override
    public List<Star> getAllSearh(String alias, String name) {
        return starRepository.findByAliasOrNameLikeAndActivateAndStatus("%"+alias+"%", "%"+name+"%", true, true);
    }

    @Override
    public Star editStar(Star star) {
        return starRepository.saveAndFlush(star);
    }

    @Override
    public String fileUpload(MultipartFile file, String name) {
   String message;

            if (!file.isEmpty()) {
                try {
                    BufferedOutputStream stream = new BufferedOutputStream(
                            new FileOutputStream(new File(name)));
                    FileCopyUtils.copy(file.getInputStream(), stream);
                    stream.close();
                    message="succ";
                }
                catch (Exception e) {
                    message="errorUpload";
                }
            }
            else {
              message="empty";
            }

            return message;

    }
}
