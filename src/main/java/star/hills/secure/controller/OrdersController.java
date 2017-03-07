package star.hills.secure.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import star.hills.secure.constants.Constants;
import star.hills.secure.entity.Order;
import star.hills.secure.entity.PayStat;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.User;
import star.hills.secure.entity.enums.UserRoleEnum;
import star.hills.secure.service.OrderService;
import star.hills.secure.service.PayStatService;
import star.hills.secure.service.StarService;
import star.hills.secure.service.UserService;
import star.hills.secure.service.impl.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Path;
import java.util.List;
import java.util.Locale;

/**
 * Created by Admin on 03.06.2016.
 */
@Controller
public class OrdersController {
    /*private static final Logger LOGGER = Logger.getLogger(OrdersController.class);*/
    @Autowired
    private PayStatService payStatService;
    @Autowired
    private StarService service=new StarServiceImpl();
    @Autowired
    private UserService serviceUser=new UserServiceImpl();
    @Autowired
    private OrderService serviceOrder=new OrderServiceImpl();
    @Autowired
    private EmailService sender=new EmailService();
    @Autowired
    private ImageGrabber grabber;
    @RequestMapping(value="/my-orders", method= RequestMethod.POST)
    public void orderPost(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response){
    }
    @RequestMapping(value="/my-orders", method = RequestMethod.GET)
    public String orderGet(Model model, HttpServletRequest req, HttpServletResponse response){
        response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.STAR.toString().equals(auth.getAuthority()) || UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())) {
                User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
                Star star = service.getStarByUser(user);
                if (UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())){
                    star=service.getStarById(Integer.parseInt(req.getParameter("id")));
                    model.addAttribute("starId", star.getId());
                }
                List<Order> neworder = serviceOrder.getOrdersByStarAndActive(star, -2);
                List<Order> activeorder = serviceOrder.getOrdersByStarAndActive(star, -1);
                Page<Order> closeorder = serviceOrder.getOrdersByStarAndActive(0, star, 1);
                model.addAttribute("neworder", neworder);
                model.addAttribute("activeorder", activeorder);
                model.addAttribute("closeorder", closeorder.getContent());
                model.addAttribute("currentPage", "/pages/orders.jsp");
                return "index";
            }
        }
        return"redirect:/";
    }
    @RequestMapping(value="/change-paidstatus", method=RequestMethod.POST)
    public String changePaidstatus(HttpServletRequest req){
        boolean paidStatus=Boolean.parseBoolean(req.getParameter("paidstatus"));
        int id=Integer.parseInt(req.getParameter("id"));
        Order order = serviceOrder.getOrder(id);
        order.setPaidstatus(paidStatus);
        Star star=order.getStar();
        PayStat payStat=new PayStat();
        java.util.Date utilDate=new java.util.Date(System.currentTimeMillis());
        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
        payStat.setDate(sqlDate);
        payStat.setStar(star);
        if(order.isPaidstatus()){
            star.setBalance(star.getBalance()+star.getPrice());
            payStat.setMoney(star.getPrice());
            payStat.setBalance(String.valueOf(star.getBalance()));
        }else{
            star.setBalance(star.getBalance()-star.getPrice());
            payStat.setMoney(-1*star.getPrice());
            payStat.setBalance(String.valueOf(star.getBalance()));
        }
        payStatService.addPayStat(payStat);
        order.setStar(star);
        serviceOrder.editOrder(order);
        return "validationMessage";
    }
    @RequestMapping(value="/change-active", method=RequestMethod.POST)
    public String changeActive(Model model, HttpServletRequest req){
        int active=Integer.parseInt(req.getParameter("active"));
        int id=Integer.parseInt(req.getParameter("id"));
        Order order = serviceOrder.getOrder(id);
        if(active==-2) {
            order.setActive(1);
        }else if(active==-1){
            order.setActive(-2);
        }else if(active==1){
            order.setActive(-1);
        }
        model.addAttribute("orderActive", order.getActive());
        model.addAttribute("status", "activeOrder");
        serviceOrder.editOrder(order);
        return "validationMessage";
    }
    @RequestMapping(value="new-video-with-web", method = RequestMethod.POST)
    public String newVideoWeb(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException, IOException {
        User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        Star star = service.getStarByUser(user);
        String fileName =req.getHeader("id")+".webm";
        Order order = serviceOrder.getOrder(Integer.parseInt(req.getHeader("id")));
        order.setPathvideo(req.getHeader("id")+".mp4");
        order.setActive(-1);
        String root = req.getServletContext().getRealPath("/")+"/starSource/"+star.getId()+"/";
        System.out.println(root+fileName);
        File path = new File(root);
        if (!path.exists()) {
            boolean status = path.mkdirs();
        }
        File uploadedFile = new File(req.getServletContext().getRealPath("/")+"/starSource/" + fileName);
        byte[] buffer = new byte[1024 * 1024];
        InputStream input = req.getInputStream();
        OutputStream output = new FileOutputStream(uploadedFile);
        /*response.setContentType("video/mp4");
        response.setHeader("Content-Type", "video/mp4");*/
        int bytesRead;
        while ((bytesRead = input.read(buffer)) != -1){
            output.write(buffer, 0, bytesRead);
        }
        output.flush();
        output.close();
        input.close();
        try {
            grabber.setFinishPath(req.getServletContext().getRealPath("/")+"/starSource/"+star.getId()+"/"+order.getId());
            grabber.setRealPath(req.getServletContext().getRealPath("/")+"/starSource/"+order.getId());
            grabber.setEndvideo(fileName.split("\\.")[1]);
            grabber.setSourcePath(req.getServletContext().getRealPath("/"));
            grabber.graberImage();
        } catch (Exception e) {
            e.printStackTrace();
        }

        serviceOrder.editOrder(order);
        try {
            sender.sendMailOrder(Constants.ADMIN_EMAIL, order, req.getServletContext().getRealPath("/template/email-record-video.html"));
        }catch(Exception e){
           /* LOGGER.error("error of send message, pattern file of email not found");*/
        }
        model.addAttribute("status", "OkUpload");
        model.addAttribute("filename", req.getHeader("id")+".mp4");
        uploadedFile.delete();
        return "validationMessage";
    }
    @RequestMapping(value="/new-first-frame", method = RequestMethod.POST)
    public String newFirstFrame(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException, IOException {
        User userframe = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        Star starframe = service.getStarByUser(userframe);
        String fileName =req.getHeader("id")+".png";
        Order order = serviceOrder.getOrder(Integer.parseInt(req.getHeader("id")));
        String root = req.getServletContext().getRealPath("/")+"/starSource/"+starframe.getId()+"/";
        System.out.println(root+fileName);
        File path = new File(root);
        if (!path.exists()) {
            boolean status = path.mkdirs();
        }
        File uploadedFile = new File(path + "/" + fileName);
        byte[] buffer = new byte[1024 * 1024];
        InputStream input = req.getInputStream();
        OutputStream output = new FileOutputStream(uploadedFile);
        response.setContentType("image/png");
        response.setHeader("Content-Type", "image/png");
       /* int bytesRead;
        while ((bytesRead = input.read(buffer)) != -1){
            output.write(buffer, 0, bytesRead);
        }*/
        output.flush();
        output.close();
        input.close();
        BufferedImage img1 = ImageIO.read(uploadedFile);
        BufferedImage img2 = ImageIO.read(new File(req.getServletContext().getRealPath("/") + "/starSource/play.png"));
        try {
            //grabber.setRealPath(req.getServletContext().getRealPath("/")+"/starSource/"+starframe.getId()+"/"+order.getId());
            //grabber.setEndvideo(fileName.split("\\.")[1]);
            //grabber.setSourcePath(req.getServletContext().getRealPath("/"));
           // BufferedImage joinedImg = grabber.joinBufferedImage(img1, img2);
        //boolean success = ImageIO.write(joinedImg, "png", new File(req.getServletContext().getRealPath("/") + "/starSource/screens/" + order.getId() + ".png"));
        } catch (Throwable e) {
            /*LOGGER.error("ошибка grabber");*/
        }
            return "validationMessage";
    }
    @RequestMapping(value="new-video-with-file", method = RequestMethod.POST)
    public String newVideoFile(@RequestParam("file") MultipartFile file, Model model, HttpServletRequest req) throws IOException, InterruptedException {
        User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        Star star = service.getStarByUser(user);
        String root = req.getServletContext().getRealPath("/");
        System.out.println(file.getOriginalFilename());
        String endFile=file.getOriginalFilename().split("\\.")[file.getOriginalFilename().split("\\.").length-1];
        String fileName =req.getParameter("id")+"."+endFile;
        Order order = serviceOrder.getOrder(Integer.parseInt(req.getParameter("id")));
        order.setPathvideo(fileName.split("\\.")[0]+".mp4");
        order.setActive(-1);
        System.out.println(root+"/starSource/"+fileName);
        File newfile=new File(root+"/starSource/"+fileName);
        Path path1=newfile.toPath();
        String status=service.fileUpload(file, root+"/starSource/"+fileName);
        try {
            sender.sendMailOrder(Constants.ADMIN_EMAIL, order, req.getServletContext().getRealPath("/template/email-record-video.html"));
        }catch(FileNotFoundException e){
            /*LOGGER.error("ошибка отправки уведомления, файл шаблона письма не найден");*/
        }
        String addName=fileName.split("\\.")[0]+".mp4";
        try {
            grabber.setFinishPath(req.getServletContext().getRealPath("/")+"/starSource/"+star.getId()+"/"+order.getId());
            grabber.setRealPath(req.getServletContext().getRealPath("/")+"/starSource/"+order.getId());
            grabber.setEndvideo(endFile);
            grabber.setSourcePath(req.getServletContext().getRealPath("/"));
            grabber.graberImage();
            newfile.delete();
        } catch (Exception e) {
            newfile.delete();
            addName = "file format not support";
            order.setPathvideo(null);
            order.setActive(-2);
            e.printStackTrace();
        }
        serviceOrder.editOrder(order);
        model.addAttribute("status", "OkUpload");
        model.addAttribute("filename", addName);
        return "validationMessage";
    }
    @RequestMapping(value="delete-video", method = RequestMethod.POST)
    public String deletevideo(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException {
        User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        Star star = service.getStarByUser(user);
        String root = req.getServletContext().getRealPath("/");
        String filename=req.getParameter("filename");
        String file1=filename.split("\\.")[0];
        Order order = serviceOrder.getOrder(Integer.parseInt(file1));
        order.setPathvideo(null);
        order.setActive(-2);
        File delfile=new File(root+"starSource"+File.separator+star.getId()+File.separator+filename);
        File delfile1=new File(root+"starSource"+File.separator+star.getId()+File.separator+order.getId()+".png");
        File delfile2=new File(root+"starSource"+File.separator+"screens"+File.separator+order.getId()+".png");
        System.out.println(root+"starSource"+File.separator+star.getId()+File.separator+filename);
        if(delfile1.delete()){
            System.out.println(delfile1.getName() + " is deleted!");
        }else{
            System.out.println("Delete image operation is failed.");
        }
        if(delfile2.delete()){
            System.out.println(delfile2.getName() + " is deleted!");
        }else{
            System.out.println("Delete screen operation is failed.");
        }
        if(delfile.delete()){
            System.out.println(delfile.getName() + " is deleted!");
        }else{
            System.out.println("Delete operation is failed.");
        }
        serviceOrder.editOrder(order);
        return "validationMessage";
    }
}
