package star.hills.secure.controller;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.User;
import star.hills.secure.service.StarService;
import star.hills.secure.service.UserService;
import star.hills.secure.service.impl.EmailService;
import star.hills.secure.service.impl.StarServiceImpl;
import star.hills.secure.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Admin on 19.05.2016.
 */
@Controller
public class RecoverController {
    @Autowired
    private StarService service=new StarServiceImpl();
    @Autowired
    private UserService serviceUser=new UserServiceImpl();
    @Autowired
    private EmailService sender=new EmailService();
    @RequestMapping(value = "/recover-password", method = RequestMethod.GET)
    public String redirectPage(Model model){
        return "redirect:/";
    }
    @RequestMapping(value = "/recover-password/", method = RequestMethod.GET)
    public String redirectingPage(Model model){
        return "redirect:/";
    }
    @RequestMapping(value = "/recover-password/{recover}", method = RequestMethod.GET)
    public String loginPage(@PathVariable("recover")String recover, Model model){
        if(service.getStarByRecoverPass(recover)!=null) {
            Star star=service.getStarByRecoverPass(recover);
            model.addAttribute("id", star.getUser().getId());
            model.addAttribute("name", star.getName());
            model.addAttribute("currentPage", "/pages/recoverpassword.jsp");
            return "index";
        }
        return "redirect:/";
    }
    @RequestMapping(value = "/recover-password-send", method = RequestMethod.POST)
    public String recoverPass(Model model, HttpServletRequest req){
        User user=serviceUser.getUserById(Integer.parseInt(req.getParameter("userid")));
        user.setPassword(req.getParameter("Password"));
        user=serviceUser.editUserWithSha(user);
        Star star = service.getStarByUser(user);
        star.setRecoverpass(null);
        service.editStar(star);
        req.setAttribute("status", "suchReg");
        return "validationMessage";
    }
    @RequestMapping(value = "/recover-password", method = RequestMethod.POST)
    public String RecoveryPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException {
        String email=req.getParameter("email");
        Star star = service.getStarByEmail(email);
        if(star!=null) {
            String newPassword = RandomStringUtils.random(28, true, true);
            star.setRecoverpass(newPassword);
            try {
                sender.sendMail(star.getEmail(), star, req.getServletContext().getRealPath("/template/emailRecover.html") );
                service.editStar(star);
                req.setAttribute("status", "sendrecoverpassword");
            }catch (Exception e){
                req.setAttribute("status", "sendrecoverpassworderror1");
            }

        }else {
            req.setAttribute("status", "sendrecoverpassworderror");

        }
        return "validationMessage";
    }
}
