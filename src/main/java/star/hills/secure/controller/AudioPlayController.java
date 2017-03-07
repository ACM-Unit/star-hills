package star.hills.secure.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import star.hills.secure.entity.Order;
import star.hills.secure.entity.Star;
import star.hills.secure.service.OrderService;
import star.hills.secure.service.StarService;
import star.hills.secure.service.impl.EmailService;
import star.hills.secure.service.impl.OrderServiceImpl;
import star.hills.secure.service.impl.StarServiceImpl;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Locale;

/**
 * Created by Admin on 21.07.2016.
 */
@Controller
public class AudioPlayController {
    @Autowired
    private OrderService service=new OrderServiceImpl();
    @Autowired
    private StarService serviceStar=new StarServiceImpl();
    @Autowired
    private EmailService sender=new EmailService();
    @RequestMapping(value="/audio-play", method = RequestMethod.GET)
    @ResponseBody
    public void  getAudioName(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        Order order=service.getOrder(Integer.parseInt(request.getParameter("order")));
        Star star = serviceStar.getStarById(Integer.parseInt(request.getParameter("star")));
        String name=order.getAudioname();
        String endfile=name.split("\\.")[1];
        String filePath = request.getServletContext().getRealPath("/")+"/starSource/"+star.getId()+"/"+name;
        int fileSize = (int) new File(filePath).length();
        response.setContentLength(fileSize);
        response.setContentType("audio/"+endfile);
        FileInputStream inputStream = new FileInputStream(filePath);
        ServletOutputStream outputStream = response.getOutputStream();
        int value = IOUtils.copy(inputStream, outputStream);
        System.out.println(endfile);
        System.out.println("Copied Bytes :: "+value);
        IOUtils.closeQuietly(inputStream);
        IOUtils.closeQuietly(outputStream);
        response.setStatus(HttpServletResponse.SC_OK);
    }
    @RequestMapping(value="/audiogreeting-play", method = RequestMethod.GET)
    @ResponseBody
    public void  getAudioGreeting(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        Order order=service.getOrder(Integer.parseInt(request.getParameter("order")));
        Star star = serviceStar.getStarById(Integer.parseInt(request.getParameter("star")));
        String name=order.getAudiogreeting();
        String endfile=name.split("\\.")[1];
        String filePath = request.getServletContext().getRealPath("/")+"/starSource/"+star.getId()+"/"+name;
        int fileSize = (int) new File(filePath).length();
        response.setContentLength(fileSize);
        response.setContentType("audio/"+endfile);
        FileInputStream inputStream = new FileInputStream(filePath);
        ServletOutputStream outputStream = response.getOutputStream();
        int value = IOUtils.copy(inputStream, outputStream);
        System.out.println(endfile);
        System.out.println("Copied Bytes :: "+value);
        IOUtils.closeQuietly(inputStream);
        IOUtils.closeQuietly(outputStream);
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
