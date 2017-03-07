package star.hills.secure.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import star.hills.secure.constants.Constants;
import star.hills.secure.entity.Order;
import star.hills.secure.entity.Star;
import star.hills.secure.service.OrderService;
import star.hills.secure.service.StarService;
import star.hills.secure.service.UserService;
import star.hills.secure.service.impl.EmailService;
import star.hills.secure.service.impl.OrderServiceImpl;
import star.hills.secure.service.impl.StarServiceImpl;
import star.hills.secure.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Date;

@Controller
public class AudioController {
    /*private static final Logger LOGGER = Logger.getLogger(AudioController.class);*/
    @Autowired
    private OrderService serviceOrder=new OrderServiceImpl();
    @Autowired
    private StarService service=new StarServiceImpl();
    @Autowired
    private UserService serviceUser=new UserServiceImpl();
    @Autowired
    private EmailService sender=new EmailService();
    @RequestMapping(value="/audio-service", method = RequestMethod.POST)
    public String start(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException, IOException {
        String fileName="";
        Order order=new Order();
        Star star =service.getStarById(Integer.parseInt(req.getHeader("idstar")));
        order.setStar(star);
        String content=req.getHeader("Content-Type").split("audio/")[1];
        System.out.println(req.getHeader("Content-Type").split("audio/")[1]);
        if(Integer.parseInt(req.getHeader("idorder"))!=0) {
            order = serviceOrder.getOrder(Integer.parseInt(req.getHeader("idorder")));
            model.addAttribute("idord", req.getHeader("idorder"));
        }else{
            order.setCreateddate(new Date(System.currentTimeMillis()));
            order=serviceOrder.addOrder(order);
            model.addAttribute("idord", order.getId());
        }
        if(Integer.parseInt(req.getHeader("audiostatus"))==1) {
            fileName = "audiogreeting" + order.getId() + "."+content;
            order.setAudiogreeting(fileName);
            try {
                sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/email-audio-greating.html"));
            }catch(Exception  e){
                /*LOGGER.error("ошибка отправки уведомления");*/
            }


        }else{
            fileName = "audioname" + order.getId() + "."+content;
            order.setAudioname(fileName);
            try {
                sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/email-audio-name.html"));
            }catch(Exception e){
               /* LOGGER.error("ошибка отправки уведомления");*/
            }
        }
        serviceOrder.editOrder(order);
        String root = req.getServletContext().getRealPath("/")+"/starSource/"+star.getId()+"/";
        System.out.println(Integer.parseInt(req.getHeader("idorder")));
        File path = new File(root);
        if (!path.exists()) {
            boolean status = path.mkdirs();
        }
        File uploadedFile = new File(path + "/" + fileName);
        byte[] buffer = new byte[1024 * 1024];
        InputStream input = req.getInputStream();
        OutputStream output = new FileOutputStream(uploadedFile);
        response.setContentType(req.getHeader("Content-Type"));
        response.setHeader("Content-Type", req.getHeader("Content-Type"));
        int bytesRead;
        while ((bytesRead = input.read(buffer)) != -1){
            output.write(buffer, 0, bytesRead);
        }
        output.flush();
        output.close();
        input.close();
        System.out.println(star.getName());
        model.addAttribute("status", "Idord");
        return "validationMessage";
    }
    @RequestMapping(value="/audio-upload", method = RequestMethod.POST)
    public String audioUpload(@RequestParam("file") MultipartFile file, Model model, HttpServletRequest req) throws IOException {

        String fileName="";
        Star star =service.getStarById(Integer.parseInt(req.getParameter("idstar")));
        Order order=new Order();
        order.setStar(star);
        if(Integer.parseInt(req.getParameter("idorder"))!=0) {
            order = serviceOrder.getOrder(Integer.parseInt(req.getParameter("idorder")));
            model.addAttribute("idord", req.getParameter("idorder"));
        }else{
            order.setCreateddate(new Date(System.currentTimeMillis()));
            order=serviceOrder.addOrder(order);
            model.addAttribute("idord", order.getId());
        }
        serviceOrder.editOrder(order);
        String root = req.getServletContext().getRealPath("/");
        System.out.println(file.getOriginalFilename());
        String endFile=file.getOriginalFilename().split("\\.")[file.getOriginalFilename().split("\\.").length-1];
        if(Integer.parseInt(req.getParameter("audiostatus"))==1) {
            fileName = "audiogreeting" + order.getId() +"."+endFile;
            order.setAudiogreeting(fileName);
            try {
                sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/email-audio-greating.html"));
            }catch(Exception e){
                /*LOGGER.error("ошибка отправки уведомления");*/
            }
        }else{
            fileName = "audioname" + order.getId() +"."+endFile;
            order.setAudioname(fileName);
            try {
                sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/email-audio-name.html"));
            }catch(Exception e){
              /*  LOGGER.error("ошибка отправки уведомления");*/
            }
        }
        serviceOrder.editOrder(order);
        String status=service.fileUpload(file, root+"/starSource/"+star.getId() +"/"+fileName);
        model.addAttribute("status", "Idord");
       return "validationMessage";
    }
}
