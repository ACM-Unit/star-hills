package star.hills.secure.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import star.hills.secure.entity.User;
import star.hills.secure.service.impl.EmailService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;

@Controller
@RequestMapping(value="/")
public class MainController {

    @Autowired
    EmailService sender=new EmailService();
    @RequestMapping(method = RequestMethod.GET)
    public String start(@RequestParam(value = "error", required = false) String error, Model model, HttpServletRequest req, HttpServletResponse resp){
        User user= new User();
        model.addAttribute("user", user);
        model.addAttribute("error", error);
        model.addAttribute("currentPage", "/pages/home.jsp");
        return "index";
    }
    @ExceptionHandler(FileNotFoundException.class)
    public String myError(Exception exception) {
        System.out.println("----Caught FileNotFoundException----");
        ModelAndView mav = new ModelAndView();
        mav.addObject("exc", exception);
        mav.setViewName("myerror");
        return "redirect: /explorer";
    }
}
