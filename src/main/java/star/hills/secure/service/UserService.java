package star.hills.secure.service;


import star.hills.secure.entity.User;

import java.util.List;

public interface UserService {
    User getUser(String login);
    User getUserById(int id);
    User addUser(User user);
    void delete(int id);
    List<User> getAll();
    User editUser(User user);
    User editUserWithSha(User user);

}
