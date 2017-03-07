package star.hills.secure.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import star.hills.secure.constants.Constants;
import star.hills.secure.entity.*;
import star.hills.secure.entity.enums.UserRoleEnum;
import star.hills.secure.service.NewsService;
import star.hills.secure.service.StarService;
import star.hills.secure.service.UserService;
import star.hills.secure.service.WishedStarService;
import star.hills.secure.service.impl.EmailService;
import star.hills.secure.service.impl.NewsServiceImpl;
import star.hills.secure.service.impl.UserServiceImpl;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;


/**
 * Created by Admin on 26.07.2016.
 */
@Controller
public class OtherPagesController {
    /*private static final Logger LOGGER = Logger.getLogger(OtherPagesController.class);*/
    @Autowired
    EmailService sender;
    @Autowired
    private StarService service;
    @Autowired
    private NewsService newsService;
    @Autowired
    private UserService serviceUser=new UserServiceImpl();
    @Autowired
    WishedStarService wishedStarService;
    @Autowired
    private NewsService newsservice = new NewsServiceImpl();
    @RequestMapping(value="/aboutus", method=RequestMethod.GET)
    public String aboutus(Model model, HttpServletRequest req){
        model.addAttribute("currentPage", "/pages/aboutus.jsp");
        return "index";
    }
    @RequestMapping(value="/callus", method=RequestMethod.GET)
    public String contacts(Model model, HttpServletRequest req){
        model.addAttribute("currentPage", "/pages/contacts.jsp");
        return "index";
    }
    @RequestMapping(value="/contacts", method=RequestMethod.GET)
    public String callus(Model model, HttpServletRequest req){
        model.addAttribute("currentPage", "/pages/callus.jsp");
        return "index";
    }
    @RequestMapping(value="/call-us", method=RequestMethod.POST)
    public String callussender(Model model, HttpServletRequest req) throws IOException {
        Client client= new Client();
        client.setFirstname(req.getParameter("FistName"));
        client.setLastname(req.getParameter("LastName"));
        client.setEmail(req.getParameter("Email"));
        client.setTitle(req.getParameter("Betreff"));
        client.setText(req.getParameter("Nachricht"));
        try{
        sender.sendMailClient(Constants.ADMIN_EMAIL, client, req.getServletContext().getRealPath("/template/email-call-us.html"));
    }catch(FileNotFoundException e){
        /*LOGGER.error("ошибка отправки уведомления, файл шаблона письма не найден");*/
    }
        return "validationMessage";
    }
    @RequestMapping(value="/safe-information", method=RequestMethod.GET)
    public String safeinf(Model model, HttpServletRequest req){
        model.addAttribute("currentPage", "/pages/safeinf.jsp");
        return "index";
    }
    @RequestMapping(value="/explorer", method=RequestMethod.GET)
    public String ie(Model model){
        model.addAttribute("currentPage", "/pages/iePages.jsp");
        return "index";
    }
    @RequestMapping(value="/partners", method=RequestMethod.GET)
    public String partners(Model model, HttpServletRequest req){
        model.addAttribute("currentPage", "/pages/partners.jsp");
        return "index";
    }
    @RequestMapping(value="/faq", method=RequestMethod.GET)
    public String faq(Model model, HttpServletRequest req){
        model.addAttribute("currentPage", "/pages/faq.jsp");
        return "index";
    }
    @RequestMapping(value="/pressa", method=RequestMethod.GET)
    public String pressa(Model model, HttpServletRequest req){
        model.addAttribute("currentPage", "/pages/pressa.jsp");
        return "index";
    }
    @RequestMapping(value="request-star", method=RequestMethod.POST)
    public String requestStar(HttpServletRequest req, HttpServletResponse resp, Model model){
        WishedStar wishedStar=new WishedStar();
        wishedStar.setName(req.getParameter("Name"));
        wishedStar.setEmail(req.getParameter("Email"));
        wishedStarService.addWishedStar(wishedStar);
        try {
            sender.sendMailWishedStar(Constants.ADMIN_EMAIL, wishedStar, req.getServletContext().getRealPath("/template/email-request-star.html"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("status", "okrequest");
        return "validationMessage";
    }

    @RequestMapping(value = "/news", method = RequestMethod.GET)
    public String newsredirect(){
        return "redirect:/news-page-1";
    }
    @RequestMapping(value = "/news-page-{pageNumber}", method = RequestMethod.GET)
    public String news(@PathVariable Integer pageNumber, Model model){
        Page<News> news = newsservice.getNews(pageNumber-1, 1);
        System.out.println(news.getTotalPages());
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())) {
                news = newsservice.getAllNews(pageNumber-1);
            }
        }
        model.addAttribute("pageNumber", pageNumber);
        model.addAttribute("news", news);
        model.addAttribute("currentPage", "/pages/news.jsp");

        return "index";
    }
    @RequestMapping(value="/photo-upload", method= RequestMethod.POST)
    public String uploadImage(@RequestParam("mainfile") MultipartFile file, Model model, HttpServletRequest req) throws IOException {
                String root = req.getServletContext().getRealPath("/");
                String end=file.getContentType().split("/")[1];
                Path path1 = new File(root + "/starSource/defaultcharity.png").toPath();
                String status = service.fileUpload(file, root + "/starSource/defaultcharity.png");
        int scaledWidth=0;
        int scaledHeight=0;
        String path = root + "/starSource/defaultcharity.png";
        BufferedImage originalImage = ImageIO.read(new File(path));
        if((double)originalImage.getHeight()/originalImage.getWidth()<=0.7272){
            scaledWidth=330;
            scaledHeight=originalImage.getHeight()*330/originalImage.getWidth();
        }else{
            scaledHeight=240;
            scaledWidth=originalImage.getWidth()*240/originalImage.getHeight();
        }
        BufferedImage scaled = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = scaled.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
        g.dispose();
        ImageIO.write(scaled, "png", new File(root + "/starSource/defaultcharity.png"));
                model.addAttribute("status", status);
        return "validationMessage";
    }
    @RequestMapping(value="/photo-news", method= RequestMethod.POST)
    public String newsImage(@RequestParam("mainfile") MultipartFile file, Model model, HttpServletRequest req) throws IOException {
        String root = req.getServletContext().getRealPath("/");
        String end=file.getContentType().split("/")[1];
        Path path1 = new File(root + "/starSource/defaultnews.png").toPath();
        String status = service.fileUpload(file, root + "/starSource/defaultnews.png");
        int scaledWidth=0;
        int scaledHeight=0;
        String path = root + "/starSource/defaultnews.png";
        BufferedImage originalImage = ImageIO.read(new File(path));
        if((double)originalImage.getHeight()/originalImage.getWidth()<=0.7272){
            scaledWidth=330;
            scaledHeight=originalImage.getHeight()*330/originalImage.getWidth();
        }else{
            scaledHeight=240;
            scaledWidth=originalImage.getWidth()*240/originalImage.getHeight();
        }
        BufferedImage scaled = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = scaled.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
        g.dispose();
        ImageIO.write(scaled, "png", new File(root + "/starSource/defaultnews.png"));
        model.addAttribute("status", status);
        return "validationMessage";
    }

    @RequestMapping(value="/photocrop", method= RequestMethod.POST)
    public String submitImage(Model model, HttpServletRequest req, HttpServletResponse response) throws IOException {
        String root = req.getServletContext().getRealPath("/");
        int x = (int) Math.round(Double.parseDouble(req.getParameter("x")));
        int y = (int) Math.round(Double.parseDouble(req.getParameter("y")));
        int w = (int) Math.round(Double.parseDouble(req.getParameter("w")));
        int h = (int) Math.round(Double.parseDouble(req.getParameter("h")));
        String path = root + "/starSource/defaultcharity.png";
        String path1 = root + "/starSource/defaultcharitycrop.png";
        BufferedImage image = ImageIO.read(new File(path));
        BufferedImage out = image.getSubimage(x, y, w, h);
        int scaledWidth=330;
        int scaledHeight=out.getHeight()*330/out.getWidth();
        BufferedImage scaled = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = scaled.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g.drawImage(out, 0, 0, scaledWidth, scaledHeight, null);
        g.dispose();
        ImageIO.write(scaled, "png", new File(path1));
        return "validationMessage";
    }
    @RequestMapping(value="/photocropcabinet", method= RequestMethod.POST)
    public String submitImagecabinet(Model model, HttpServletRequest req, HttpServletResponse response) throws IOException {
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.STAR.toString().equals(auth.getAuthority())) {
                User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
                Star star = service.getStarByUser(user);
                String root = req.getServletContext().getRealPath("/");
                String pathOriginal = root + "/starSource/" + star.getId() + "/mainphoto.png";
                double x =  Math.round(Double.parseDouble(req.getParameter("x")));
                double y =  Math.round(Double.parseDouble(req.getParameter("y")));
                double w =  Math.round(Double.parseDouble(req.getParameter("w")));
                double h =  Math.round(Double.parseDouble(req.getParameter("h")));
                String path = root + "/starSource/default.png";
                String path1 = root + "/starSource/defaultcrop.png";
                BufferedImage originalImage = ImageIO.read(new File(path));
                BufferedImage image = ImageIO.read(new File(path));
                double k=(double)originalImage.getWidth()/image.getWidth();
                double x1=x*k;
                double y1=y*k;
                double w1=w*k;
                double h1=h*k;
                BufferedImage out = originalImage.getSubimage((int)x1, (int)y1, (int)w1, (int)h1);
                ImageIO.write(out, "png", new File(pathOriginal));
                int scaledWidth = 320;
                int scaledHeight = out.getHeight() * 320 / out.getWidth();
                BufferedImage scaled = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
                Graphics2D g = scaled.createGraphics();
                g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
                g.drawImage(out, 0, 0, scaledWidth, scaledHeight, null);
                g.dispose();
                ImageIO.write(scaled, "png", new File(path1));
            }
        }
        return "validationMessage";
    }
    @RequestMapping(value="/photocropnews", method= RequestMethod.POST)
    public String submitImageNews(Model model, HttpServletRequest req, HttpServletResponse response) throws IOException {
        String root = req.getServletContext().getRealPath("/");
        int x = (int) Math.round(Double.parseDouble(req.getParameter("x")));
        int y = (int) Math.round(Double.parseDouble(req.getParameter("y")));
        int w = (int) Math.round(Double.parseDouble(req.getParameter("w")));
        int h = (int) Math.round(Double.parseDouble(req.getParameter("h")));
        String path = root + "/starSource/defaultnews.png";
        String path1 = root + "/starSource/defaultnewscrop.png";

        BufferedImage image = ImageIO.read(new File(path));
        BufferedImage out = image.getSubimage(x, y, w, h);
        ImageIO.write(out, "png", new File(path1));
        return "validationMessage";
    }
    @RequestMapping(value="/save-news", method=RequestMethod.POST)
    public String saveCharity( Model model, HttpServletRequest req) throws IOException {
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())) {
                String root = req.getServletContext().getRealPath("/");
                News news=new News();
                if(Integer.parseInt(req.getParameter("newsid"))!=0){
                    news=newsService.getNewsById(Integer.parseInt(req.getParameter("newsid")));
                }
                java.util.Date utilDate=new java.util.Date();
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                news.setDate(sqlDate);
                news.setTitleNews(req.getParameter("Title"));
                news.setComment(req.getParameter("editor1"));
                news.setStatus(1);
                news=newsservice.addNews(news);
                File path = new File(root+"/starSource/news/"+news.getId());
                if (!path.exists()) {
                    boolean status = path.mkdir();
                }
                if(path.exists()){
                    System.out.println("succ folder create");
                }else{
                    System.out.println("error folder create");
                }
                if(Integer.parseInt(req.getParameter("croppedphoto"))==1) {
                    Path path2 = Paths.get(root + "/starSource/news/" + news.getId() + "/mainimage.png");
                    Path path1 = Paths.get(root + "/starSource/defaultnewscrop.png");
                    Path path3 = new File(root + "/starSource/defaultnews.png").toPath();
                    BufferedImage originalImage = ImageIO.read(new File(root + "/starSource/defaultnewscrop.png"));
                    int scaledWidth=220;
                    int scaledHeight=160;
                    BufferedImage scaled = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
                    Graphics2D g = scaled.createGraphics();
                    g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
                    g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
                    g.dispose();
                    ImageIO.write(scaled, "png", new File(root + "/starSource/defaultnewscrop.png"));
                    try {
                        Files.copy(path1, path2, StandardCopyOption.REPLACE_EXISTING, java.nio.file.LinkOption.NOFOLLOW_LINKS);
                        news.setNewsPhoto("mainimage.png");
                        System.out.println("succ file copy");
                        Files.delete(path1);
                        Files.delete(path3);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                }
                news=newsservice.editNews(news);
                return"validationMessage";
            }
        }
        return "redirect:/";
    }
    @RequestMapping(value="/change-newsstatus", method=RequestMethod.POST)
    public String changeStatus(HttpServletRequest req){
        int status=Integer.parseInt(req.getParameter("status"));
        int id=Integer.parseInt(req.getParameter("id"));
        News news = newsService.getNewsById(id);
        news.setStatus(status);
        newsService.editNews(news);
        return "validationMessage";
    }

}
