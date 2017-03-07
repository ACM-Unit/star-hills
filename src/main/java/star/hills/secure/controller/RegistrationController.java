package star.hills.secure.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import star.hills.secure.constants.Constants;
import star.hills.secure.entity.Category;
import star.hills.secure.entity.Section;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.User;
import star.hills.secure.entity.enums.UserRoleEnum;
import star.hills.secure.service.CategoryService;
import star.hills.secure.service.SectionService;
import star.hills.secure.service.StarService;
import star.hills.secure.service.UserService;
import star.hills.secure.service.impl.EmailService;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * Created by Admin on 17.05.2016.
 */
@Controller
@RequestMapping("/registration")
public class RegistrationController {
    @Autowired
    private StarService service;
    @Autowired
    private UserService serviceUser;
    @Autowired
    private EmailService sender;
    @Autowired
    private SectionService sectionService;
    @Autowired
    private CategoryService serviceCategory;
    @RequestMapping(method = RequestMethod.GET)
    public String RegistrationPage(Model model){
        Star star=new Star();
        User user=new User();
        user.setRole(UserRoleEnum.STAR);
        star.setUser(user);
        model.addAttribute("star", star);
        model.addAttribute("currentPage", "/pages/registration.jsp");
        return "index";
    }
    @RequestMapping(method= RequestMethod.POST)
    public String cabinetPost (Model model, HttpServletRequest req) {
        Star star = new Star();
        User user = new User();
        User userProv = serviceUser.getUser(req.getParameter("Login"));
        Star starProv = service.getStarByEmail(req.getParameter("Email"));
        if (userProv != null) {
            model.addAttribute("status", "errorReg");
            /*model.addAttribute("currentPage", "/pages/registration.jsp");*/
        }else if(starProv != null){
            model.addAttribute("status", "errorRegEmail");
        } else {
            star.setName(req.getParameter("Name"));
            user.setLogin(req.getParameter("Login"));
            star.setPhone(req.getParameter("Phone"));
            star.setEmail(req.getParameter("Email"));
            star.setStatus(false);
            star.setActivate(false);
            star.setSkypecheck(false);
            star.setAboutme(false);
            star.setVideo(10);
            user.setPassword(req.getParameter("Password"));
            user.setRole(UserRoleEnum.STAR);
            star.setUser(user);
            Section section=new Section();
            if(sectionService.getSection("andere")==null){
                section.setName("andere");
                section=sectionService.addSection(section);
            }else {
                section = sectionService.getSection("andere");
            }
            Category category = new Category();
            if(serviceCategory.getCategoryByName("neu")==null) {
                category.setName("neu");
            }else{
                category=serviceCategory.getCategoryByName("neu");
            }
            category.setStatus(false);
            category.setSection(section);
            star.setCategory(category);
            star=service.addStar(star);
            System.out.println(user.getLogin());
            System.out.println(star.getEmail());
            model.addAttribute("status", "suchReg");
            String root = req.getServletContext().getRealPath("/");
            File path = new File(root+"/starSource/"+star.getId());
            File pathorder = new File(root+"/starSource/"+star.getId()+"/orderingphoto");

            if (!path.exists()) {
                boolean status = path.mkdir();
                boolean status1 = pathorder.mkdir();
            }
            if(path.exists()){
                System.out.println("succ folder create");
            }else{
                System.out.println("error folder create");
            }
            Path path2=new File(path+"/mainphoto.png").toPath();
            Path path1=new File(root+"/starSource/noPhoto.png").toPath();
            try {
                Files.copy(path1, path2);
                System.out.println("succ file copy");
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/email-registration.html") );
            } catch (Exception e) {

            }

        }
        if(userProv != null && starProv != null){
            model.addAttribute("status", "errorRegEmailAll");
        }
        return "validationMessage";
    }
}
