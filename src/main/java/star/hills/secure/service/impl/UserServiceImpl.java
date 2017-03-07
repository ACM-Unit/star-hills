package star.hills.secure.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import star.hills.secure.entity.User;
import star.hills.secure.repository.UserRepository;
import star.hills.secure.service.UserService;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;

    @Override
    public User getUser(String login) {
        return userRepository.findByLogin(login);
    }

    @Override
    public User getUserById(int id) {
        return userRepository.findOne(id);
    }

    @Override
    public User addUser(User user) {
        ShaPasswordEncoder encoder =new ShaPasswordEncoder();
        user.setPassword(encoder.encodePassword(user.getPassword(),""));
        User savedUser = userRepository.saveAndFlush(user);

        return savedUser;
    }

    @Override
    public void delete(int id) {
        userRepository.delete(id);
    }

    @Override
    public List<User> getAll() {
        return userRepository.findAll();
    }

    @Override
    public User editUser(User user) {
        return userRepository.saveAndFlush(user);
    }

    @Override
    public User editUserWithSha(User user) {
        ShaPasswordEncoder encoder =new ShaPasswordEncoder();
        user.setPassword(encoder.encodePassword(user.getPassword(),""));
        User savedUser = userRepository.saveAndFlush(user);
        return savedUser;
    }

}
