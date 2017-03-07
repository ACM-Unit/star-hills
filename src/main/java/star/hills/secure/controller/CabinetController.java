package star.hills.secure.controller;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import star.hills.secure.constants.Constants;
import star.hills.secure.entity.*;
import star.hills.secure.entity.enums.UserRoleEnum;
import star.hills.secure.service.*;
import star.hills.secure.service.impl.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
/**
 * Created by Admin on 19.05.2016.
 */
@Controller
public class CabinetController {
    /*private static final Logger LOGGER = Logger.getLogger(CabinetController.class);*/
    @Autowired
    AuthenticationManager manager;
    @Autowired
    private CommonsMultipartResolver filterMultipartResolver;
    @Autowired
    private UserDetailsServiceImpl userDetailsSvc;
    @Autowired
    private CategoryService serviceCategory=new CategoryServiceImpl();
    @Autowired
    private StarService service=new StarServiceImpl();
    @Autowired
    private CharityService charityService;
    @Autowired
    private PayStatService payStatService;
    @Autowired
    private UserService serviceUser=new UserServiceImpl();
    @Autowired
    private EmailService sender=new EmailService();
    @Autowired
    private OrderService serviceOrder=new OrderServiceImpl();
    @Autowired
    private SectionService sectionService;
    @Autowired
    private  StarCharityService starCharityService;
    @Autowired
    private ImageGrabber grabber;
    @RequestMapping(value="/cabinet", method= RequestMethod.GET)
    public String cabinetGet( Model model){
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.STAR.toString().equals(auth.getAuthority())) {
            User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
            Star star = service.getStarByUser(user);
                List<Order> order = serviceOrder.getOrdersByStarAndActive(star, -2);
                List<Category> categoryList=serviceCategory.getAll();
                List<StarCharity> charities=starCharityService.charityByStar(star);
                List<Charity> activecharities = charityService.getActiveCharity(1);
                int i=0;
                for(Order o: order){
                    if(o.getPaymentsystem()!=null){
                        i++;
                    }
                }
                model.addAttribute("orders", i);
                model.addAttribute("categoryList", categoryList);
                model.addAttribute("charities", charities);
                model.addAttribute("activecharities", activecharities);
                model.addAttribute("star", star);
                model.addAttribute("currentPage", "/pages/cabinet.jsp");
                return "index";
            }
        }
        return "redirect:/";
    }
    @RequestMapping(value="/starscabinet", method= RequestMethod.GET)
    public String cabinetStarGet( Model model, HttpServletRequest req){
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())) {
                Star star = service.getStarById(Integer.parseInt(req.getParameter("id")));
                try {
                    star.getName();
                }catch(NullPointerException e){
                    throw new NullPointerException("Star unter dieser Nummer nicht existiert ");
                }
                List<Order> order = serviceOrder.getOrdersByStarAndActive(star, -2);
                List<Category> categoryList=serviceCategory.getAll();
                List<StarCharity> charities=starCharityService.charityByStar(star);
                List<Charity> activecharities = charityService.getActiveCharity(1);
                int j=0;
                for(Order o: order){
                    if(o.getPaymentsystem()!=null){
                        j++;
                    }
                }
                model.addAttribute("orders", j);
                model.addAttribute("categoryList", categoryList);
                model.addAttribute("charities", charities);
                model.addAttribute("activecharities", activecharities);
                model.addAttribute("star", star);
                model.addAttribute("currentPage", "/pages/cabinet.jsp");
                try {
                    String root = req.getServletContext().getRealPath("/");
                    String filename = root+"/starSource/"+star.getId()+"/payStat.xls" ;
                    HSSFWorkbook workbook = new HSSFWorkbook();
                    HSSFSheet sheet = workbook.createSheet("FirstSheet");
                    List<PayStat> payStat=payStatService.getAllByStar(star);
                    HSSFRow rowhead = sheet.createRow((short)0);
                    rowhead.createCell(0).setCellValue("No.");
                    rowhead.createCell(1).setCellValue("Дебет-кредит");
                    rowhead.createCell(2).setCellValue("Дата");
                    rowhead.createCell(3).setCellValue("Баланс");
                    rowhead.createCell(4).setCellValue("Имя звезды");
                     for(int i=0; i<payStat.size(); i++) {
                             HSSFRow row = sheet.createRow((short) i+1);
                             row.createCell(0).setCellValue(payStat.get(i).getId());
                             row.createCell(1).setCellValue(payStat.get(i).getMoney());
                             row.createCell(2).setCellValue(payStat.get(i).getDate().toString());
                             row.createCell(3).setCellValue(payStat.get(i).getBalance());
                             row.createCell(4).setCellValue(star.getName());
                     }
                    FileOutputStream fileOut = new FileOutputStream(filename);
                    workbook.write(fileOut);
                    fileOut.close();
                    System.out.println("Your excel file has been generated!");
                } catch ( Exception ex ) {
                    System.out.println(ex);
                }
                return "index";
            }
        }
        return "redirect:/";
    }
    @RequestMapping(value="/cabinet", method= RequestMethod.POST)
    public String submitImage(@RequestParam("file") MultipartFile file, Model model, HttpServletRequest req) throws IOException {
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.STAR.toString().equals(auth.getAuthority())) {
                User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
                Star star = service.getStarByUser(user);
                String root = req.getServletContext().getRealPath("/");
                //Path path1 = new File(root + "/starSource/" + star.getId() + "/mainphoto.png").toPath();
                //String status = service.fileUpload(file, root + "/starSource/" + star.getId() + "/mainphoto.png");
                service.fileUpload(file, root + "/starSource/default.png");
                String path = root + "/starSource/default.png";
                BufferedImage originalImage = ImageIO.read(new File(path));
                int scaledWidth=320;
                int scaledHeight=originalImage.getHeight()*320/originalImage.getWidth();
                BufferedImage scaled = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
                Graphics2D g = scaled.createGraphics();
                g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
                g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
                g.dispose();
                ImageIO.write(scaled, "png", new File(path));
                //model.addAttribute("status", status);
            }
        }
        return "validationMessage";
    }
    @RequestMapping(value="/video-service", method = RequestMethod.POST)
    public String start(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException, IOException {
        User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        Star star = service.getStarByUser(user);
        String fileName ="videoconfirm.webm";
        String root = req.getServletContext().getRealPath("/")+"/starSource/";
        System.out.println(root+fileName);
        File path = new File(root);
        if (!path.exists()) {
            boolean status = path.mkdirs();
        }
        File uploadedFile = new File(path + "/" + fileName);
        byte[] buffer = new byte[1024 * 1024];
        InputStream input = req.getInputStream();
        OutputStream output = new FileOutputStream(uploadedFile);
        response.setContentType("video/webm");
        response.setHeader("Content-Type", "video/webm");
        int bytesRead;
        while ((bytesRead = input.read(buffer)) != -1){
            output.write(buffer, 0, bytesRead);
        }
        output.flush();
        output.close();
        input.close();
        try {
            sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/emailVideoConfirm.html"));
        }catch(FileNotFoundException e){
            /*LOGGER.error("ошибка отправки уведомления, файл шаблона письма не найден");*/
        }
        File newfile=new File(root+"/starSource/videoconfirm.webm");
        String addName="videoconfirm.mp4";
        try {
            grabber.setFinishPath(req.getServletContext().getRealPath("/")+"/starSource/"+star.getId()+"/videoconfirm");
            grabber.setRealPath(req.getServletContext().getRealPath("/")+"/starSource/videoconfirm");
            grabber.setEndvideo(fileName.split("\\.")[1]);
            grabber.setSourcePath(req.getServletContext().getRealPath("/"));
            grabber.graberImage();
        } catch (Exception e) {
            newfile.delete();
            addName = "file_format_not_support";
            star.setConfirm(null);
            e.printStackTrace();
        }
        newfile.delete();
        star.setConfirm("videoconfirm.mp4");
        service.editStar(star);
        model.addAttribute("status", "OkUpload");
        model.addAttribute("filename", addName);
        return "validationMessage";
    }
    @RequestMapping(value="/video-upload", method = RequestMethod.POST)
    public String start(@RequestParam("file") MultipartFile file, Model model, HttpServletRequest req) throws IOException {
        User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        Star star = service.getStarByUser(user);
        String root = req.getServletContext().getRealPath("/");
        System.out.println(file.getOriginalFilename());
        String endFile=file.getOriginalFilename().split("\\.")[file.getOriginalFilename().split("\\.").length-1];
        System.out.println(root+"/starSource/"+star.getId()+"/videoconfirm."+endFile);
        Path path1=new File(root+"/starSource/"+star.getId()+"/videoconfirm."+endFile).toPath();
        String status=service.fileUpload(file, root+"/starSource/videoconfirm."+endFile);
        File newfile=new File(root+"/starSource/videoconfirm."+endFile);
        try {
            sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/emailVideoConfirm.html"));
        }catch(FileNotFoundException e){
            /*LOGGER.error("ошибка отправки уведомления, файл шаблона письма не найден");*/
        }
        String addName="videoconfirm.mp4";
        try {
            grabber.setFinishPath(req.getServletContext().getRealPath("/")+"/starSource/"+star.getId()+"/videoconfirm");
            grabber.setRealPath(req.getServletContext().getRealPath("/")+"/starSource/"+"/videoconfirm");
            grabber.setEndvideo(endFile);
            grabber.setSourcePath(req.getServletContext().getRealPath("/"));
            grabber.graberImage();
            newfile.delete();
        } catch (Exception e) {
            newfile.delete();
            addName = "file_format_not_support";
            star.setConfirm(null);
            e.printStackTrace();
        }
        star.setConfirm("videoconfirm.mp4");
        service.editStar(star);
        model.addAttribute("status", "OkUpload");
        model.addAttribute("filename", addName);
           return "validationMessage";
    }
    @RequestMapping(value="delete-video-confirm", method = RequestMethod.POST)
    public String deletevideoConfirm(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException {
        User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
        Star star = service.getStarByUser(user);
        String root = req.getServletContext().getRealPath("/");
        String filename=req.getParameter("filename");
        String file1=filename.split("\\.")[0];
        File delfile=new File(root+"/starSource/"+star.getId()+"/"+filename);
        System.out.println(root+"/starSource/"+star.getId()+"/"+filename);
        if(delfile.delete()){
            System.out.println(delfile.getName() + " is deleted!");
        }else{
            System.out.println("Delete operation is failed.");
        }
        star.setConfirm(null);
        service.editStar(star);
        return "validationMessage";
    }
    @RequestMapping(value="/edit-star", method= RequestMethod.POST)
    public String editStar(Model model, HttpServletRequest req) throws IOException {
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.STAR.toString().equals(auth.getAuthority()) || UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())) {
                Star starProv = service.getStarByEmail(req.getParameter("Email"));
                User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
                Star star = service.getStarByUser(user);
                String[] stringList = req.getParameterValues("MyProjects[]");
                //List<String> st = Arrays.asList(stringList);
                List<StarCharity> starch = starCharityService.charityByStar(star);
                List<StarCharity> tempnew = new ArrayList<>();
                try {
                    for (String st : stringList) {
                        StarCharity temp = new StarCharity(star, charityService.getBuyId(Integer.parseInt(st)));

                        if (!starch.contains(temp)) {
                            starCharityService.addStarCharity(new StarCharity(star, charityService.getBuyId(Integer.parseInt(st))));
                        }
                        tempnew.add(temp);
                    }
                    for (StarCharity shr : starch) {
                        if (!tempnew.contains(shr)) {
                            System.out.println("Удаляем !!!!!!!!!" + shr);
                            starCharityService.delete(shr.getId());
                        }
                    }
                }catch(NullPointerException e){
                    if(starch.size()>0){
                        for(StarCharity shr: starch){
                            starCharityService.delete(shr.getId());
                        }
                    }
                }
                System.out.println(Arrays.toString(stringList));
                if(UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())){
                    star=service.getStarById(Integer.parseInt(req.getParameter("Id")));
                    System.out.println(req.getParameter("balanceAdmin"));
                    PayStat payStat=new PayStat();
                    System.out.println(star.getBalance());
                    payStat.setMoney(Integer.parseInt(req.getParameter("balanceAdmin"))-star.getBalance());
                    System.out.println(payStat.getMoney());
                    java.util.Date utilDate=new java.util.Date(System.currentTimeMillis());
                    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                    payStat.setDate(sqlDate);
                    payStat.setStar(star);
                    payStat.setBalance(req.getParameter("balanceAdmin"));
                    star.setBalance(Integer.parseInt(req.getParameter("balanceAdmin")));
                    star.setCommentadmin(req.getParameter("editor1"));
                    payStatService.addPayStat(payStat);
                }
                if(starProv==null || (starProv!=null && star.getEmail().equals(req.getParameter("Email")))) {
                    star.setName(req.getParameter("Name"));
                    star.setPrice(Integer.parseInt(req.getParameter("Price")));
                    star.setAlias(req.getParameter("Alias"));
                    star.setEmail(req.getParameter("Email"));
                    star.setPhone(req.getParameter("Phone"));
                    star.setVideo(Integer.parseInt(req.getParameter("Videos")));
                    star.setSkype(req.getParameter("Skype"));
                    star.setComment(req.getParameter("Comment"));
                        if (Integer.parseInt(req.getParameter("Category")) == 0) {
                            if (serviceCategory.getCategoryByName(req.getParameter("OtherCategory")) != null) {
                                Category category = serviceCategory.getCategoryByName(req.getParameter("OtherCategory"));
                                star.setCategory(category);
                            } else {
                                Section section=new Section();
                                if(sectionService.getSection("andere")==null){
                                    section.setName("andere");
                                    section=sectionService.addSection(section);
                                }else {
                                    section = sectionService.getSection("andere");
                                }
                                Category category = new Category();
                                category.setName(req.getParameter("OtherCategory"));
                                category.setStatus(false);
                                category.setSection(section);
                                star.setCategory(category);
                            }
                        }else{
                            Category category = serviceCategory.getCategory(Integer.parseInt(req.getParameter("Category")));
                            System.out.println(req.getParameter("Category"));
                            star.setCategory(category);
                        }
                    star.setStatus(Boolean.parseBoolean(req.getParameter("status")));
                    star.setSkypecheck(Boolean.parseBoolean(req.getParameter("deposit")));
                    star.setAboutme(Boolean.parseBoolean(req.getParameter("about")));
                    service.editStar(star);
                    if (!req.getParameter("about").equals("true")) {
                        model.addAttribute("status", "editcabinet");
                    } else {
                        try {
                            sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/emailCommentAboutClient.html"));
                        }catch(Exception e){
                           /* LOGGER.error("ошибка отправки уведомления, файл шаблона письма не найден");*/
                        }

                        model.addAttribute("status", "editcabinetabout");
                    }
                }else {
                    model.addAttribute("status", "editcabineterror");
                }
            }
        }
        return "validationMessage";
    }
    @RequestMapping(value="/submit-skype", method= RequestMethod.POST)
    public String submitskype(Model model, HttpServletRequest req) throws IOException {
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.STAR.toString().equals(auth.getAuthority())) {
                User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
                Star star = service.getStarByUser(user);
                star.setSkype(req.getParameter("skype"));
                star.setSkypecheck(true);
                try {
                    sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/emailSkypeWithClient.html"));
                }catch(Exception e){
                   /* LOGGER.error("ошибка отправки уведомления, файл шаблона письма не найден");*/
                }
                model.addAttribute("status", "editcabinetskype");
                service.addStar(star);
            }
        }
        return "validationMessage";
    }
    @RequestMapping(value="/send-status", method= RequestMethod.POST)
    public void submitstatus(Model model, HttpServletRequest req) throws IOException {
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.STAR.toString().equals(auth.getAuthority())) {
                User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
                Star star = service.getStarByUser(user);
                star.setStatus(Boolean.parseBoolean(req.getParameter("status")));
                service.editStar(star);
                try {
                    sender.sendMail(Constants.ADMIN_EMAIL, star, req.getServletContext().getRealPath("/template/email-with-video.html"));
                }catch(Exception e){
                    /*LOGGER.error("ошибка отправки уведомления, файл шаблона письма не найден");*/
                }
            }
        }
    }
    @RequestMapping(value="/send-active", method= RequestMethod.POST)
    public void submitactive(Model model, HttpServletRequest req) throws IOException {
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())) {
                Star star = service.getStarById(Integer.parseInt(req.getParameter("id")));
                star.setActivate(Boolean.parseBoolean(req.getParameter("active")));
                service.editStar(star);
            }
        }
    }
}
