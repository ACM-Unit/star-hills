package star.hills.secure.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import star.hills.secure.service.StarService;
import star.hills.secure.service.UserService;
import star.hills.secure.service.impl.EmailService;
import star.hills.secure.service.impl.StarServiceImpl;
import star.hills.secure.service.impl.UserServiceImpl;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/login-error")
public class LoginController {
    @Autowired
    private StarService service=new StarServiceImpl();
    @Autowired
    private UserService serviceUser=new UserServiceImpl();
    @Autowired
    private EmailService sender=new EmailService();

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView login (HttpServletRequest req){
        ModelAndView model = new ModelAndView();
        model.addObject("error", "Invalid username and password!");
    model.addObject("error", "error");
    model.setViewName("redirect:/#login");
    return model;
}
}
