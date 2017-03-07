package star.hills.secure.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.User;
import star.hills.secure.entity.enums.UserRoleEnum;
import star.hills.secure.service.StarService;
import star.hills.secure.service.UserService;
import star.hills.secure.service.impl.EmailService;
import star.hills.secure.service.impl.StarServiceImpl;
import star.hills.secure.service.impl.UserServiceImpl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Locale;

@Controller
public class VideoController {
    private static final int DEFAULT_BUFFER_SIZE = 10240; // ..bytes = 10KB.
    private static final long DEFAULT_EXPIRE_TIME = 604800000L; // ..ms = 1 week.
    private static final String MULTIPART_BOUNDARY = "MULTIPART_BYTERANGES";
    // Properties ---------------------------------------------------------------------------------
    private String basePath;
    @Autowired
    private StarService service=new StarServiceImpl();
    @Autowired
    private UserService serviceUser=new UserServiceImpl();
    @Autowired
    private EmailService sender=new EmailService();
    @RequestMapping(value="/video-service", method = RequestMethod.GET)
    public void  getVideo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        Star star = service.getStarByUser(user);
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())){
                star = service.getStarById(Integer.parseInt(request.getParameter("id")));
            }
        }
        String nameVideo=request.getParameter("namevideo");
        String filePath = request.getServletContext().getRealPath("/")+"/starSource/"+star.getId()+"/"+nameVideo;
        MultipartFileSender.fromPath(new File(filePath).toPath())
                .with(request)
                .with(response)
                .serveResource();
    }
    @RequestMapping(value="/video", method = RequestMethod.GET)
    public void  yourVideo(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, boolean content) throws Exception {
        String star=request.getParameter("star");
        String nameVideo=request.getParameter("video");
        String requestedFile = request.getServletContext().getRealPath("/")+"/starSource/"+star+"/"+nameVideo;
            MultipartFileSender.fromPath(new File(requestedFile).toPath())
                    .with(request)
                    .with(response)
                    .serveResource();
    }
    @RequestMapping(value="/your-video", method = RequestMethod.GET)
    public String  yoursVideo(Locale locale, Model model, HttpServletRequest    request, HttpServletResponse response) throws IOException {
        String star=request.getParameter("star");
        String nameVideo=request.getParameter("video");
        String filePath = request.getServletContext().getRealPath("/")+"/starSource/"+star+"/"+nameVideo;
        if(!new File(filePath).exists()){
            throw new NullPointerException("Video ist nicht");
        }
        model.addAttribute("star", star);
        model.addAttribute("video", nameVideo);
        model.addAttribute("image", nameVideo.split("\\.")[0]+".png");
        model.addAttribute("currentPage", "/pages/your-video.jsp");
        return "index";
    }
}
