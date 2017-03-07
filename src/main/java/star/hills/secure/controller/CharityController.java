package star.hills.secure.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import star.hills.secure.entity.*;
import star.hills.secure.entity.enums.UserRoleEnum;
import star.hills.secure.service.CharityService;
import star.hills.secure.service.StarCharityService;
import star.hills.secure.service.StarService;
import star.hills.secure.service.UserService;
import star.hills.secure.service.impl.EmailService;
import star.hills.secure.service.impl.StarServiceImpl;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Date;
import java.util.List;
import java.util.Locale;

/**
 * Created by Admin on 28.07.2016.
 */
@Controller
public class CharityController {
    @Autowired
    private EmailService sender;
    @Autowired
    private StarService service;
    @Autowired
    private CharityService charityService;
    @Autowired
    private UserService serviceUser;
    @Autowired
    private StarCharityService serviceStarCharity;
    @Autowired
    private StarService starservice = new StarServiceImpl();

    @RequestMapping(value="/add-charity", method= RequestMethod.GET)
    public String addCharity(Model model){
        List<Star> stars = starservice.getAllActiv(true,true);
        model.addAttribute("stars", stars);
                model.addAttribute("currentPage", "/pages/addcharity.jsp");
                return "index";
    }
    @RequestMapping(value="/charity", method= RequestMethod.GET)
    public String getCharityFirst(Model model){
        return "redirect:/charity-page-1";
    }
    @RequestMapping(value="/charity-page-{pageNumber}", method= RequestMethod.GET)
    public String getCharity(@PathVariable Integer pageNumber, Model model){
        Page<Charity> charityAll = charityService.getCharityByActivate(pageNumber - 1, true);
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())) {
                charityAll = charityService.getAllCharity(pageNumber - 1);
            }
        }
        List<Charity> charityNew=charityService.charityByStatus(-1);
        List<Charity> charityActual=charityService.charityByStatus(0);
        List<Charity> charityClose=charityService.charityByStatus(1);
        System.out.println(charityAll.getTotalPages());
        model.addAttribute("pageNumber", pageNumber);
        model.addAttribute("charityAll", charityAll);
        model.addAttribute("charityNew", charityNew);
        model.addAttribute("charityActual", charityActual);
        model.addAttribute("charityClose", charityClose);
        model.addAttribute("currentPage", "/pages/charity.jsp");
        return "index";
    }
    @RequestMapping(value="/charity-video", method = RequestMethod.GET)
    @ResponseBody
    public void  yourVideo(Locale locale, Model model, HttpServletRequest    request, HttpServletResponse response) throws IOException {
        String nameVideo=request.getParameter("video");
        String charity=request.getParameter("charity");
        String path = request.getServletContext().getRealPath("/")+"/starSource/charity/"+charity+"/video_"+nameVideo;
        int fileSize = (int) new File(path).length();
        response.setContentLength(fileSize);
        response.setContentType("video");
        FileInputStream inputStream = new FileInputStream(path);
        ServletOutputStream outputStream = response.getOutputStream();
        int value = IOUtils.copy(inputStream, outputStream);
        System.out.println("File Size :: "+fileSize);
        System.out.println("Copied Bytes :: "+value);
        IOUtils.closeQuietly(inputStream);
        IOUtils.closeQuietly(outputStream);
        response.setStatus(HttpServletResponse.SC_OK);
    }
    @RequestMapping(value="/save-charity", method=RequestMethod.POST)
    public String saveCharity(@RequestParam("file") List<MultipartFile> files, @RequestParam("mainfile") MultipartFile mainfile, @RequestParam("docfile") MultipartFile docfile, Model model, HttpServletRequest req) throws IOException {
            User user = serviceUser.getUser(SecurityContextHolder.getContext().getAuthentication().getName());
            Star star;
            if(user == null) star = service.getStarById(30);
            else star = service.getStarByUser(user);
            Charity charity = new Charity();
            /*charity.setStar(star);*/
            charity.setNameproject(req.getParameter("ProjeckName"));
            charity.setName(req.getParameter("FoolName"));
            charity.setMoney(Double.parseDouble(req.getParameter("Summa")));
            charity.setEmail(req.getParameter("Email"));
            System.out.println(req.getParameter("When"));
            charity.setDate(Date.valueOf(req.getParameter("When")));
            charity.setAdress((req.getParameter("Adress")));
            charity.setWhereknow(req.getParameter("How"));
            charity.setComment(req.getParameter("editor"));
            charity.setStatus(-1);
            charity.setActivate(false);
            String root = req.getServletContext().getRealPath("/");
            charity = charityService.addCharity(charity);
            StarCharity starCharity = new StarCharity(star, charity);
           /* starCharity.setCharity(charity);*/
           /* starCharity.setStar(star);*/
            serviceStarCharity.addStarCharity(starCharity);
            System.out.println(starCharity);
            File path = new File(root + "/starSource/charity/" + charity.getId());
            if (!path.exists()) {
                boolean status = path.mkdir();
            }
            if (path.exists()) {
                System.out.println("succ folder create");
            } else {
                System.out.println("error folder create");
            }
            int photocount = 1;
            int videocount = 1;
            int doccount = 1;
            for (MultipartFile file : files) {
                System.out.println(file.getContentType());
                String contentName = file.getContentType().split("/")[0];
                String contentEnd = file.getContentType().split("/")[1];
                System.out.println(contentName);
                if (contentName.equals("video")) {
                    String status = service.fileUpload(file, root + "/starSource/charity/" + charity.getId() + "/" + contentName + "_" + videocount + "." + contentEnd);
                    if (charity.getVideo() == null) {
                        charity.setVideo(contentName + "_" + videocount + "." + contentEnd + "*");
                    } else {
                        charity.setVideo(charity.getVideo() + contentName + "_" + videocount + "." + contentEnd + "*");
                    }
                    videocount++;
                } else if (contentName.equals("image")) {
                    String status = service.fileUpload(file, root + "/starSource/charity/" + charity.getId() + "/" + contentName + "_" + photocount + "." + contentEnd);
                    if (charity.getPhoto() == null) {
                        charity.setPhoto(contentName + "_" + photocount + "." + contentEnd + "*");
                    } else {
                        charity.setPhoto(charity.getPhoto() + contentName + "_" + photocount + "." + contentEnd + "*");
                    }
                    photocount++;
                }
            }
            if (Integer.parseInt(req.getParameter("croppedphoto")) == 1) {
                System.out.println(mainfile.getSize());
                String contentEnd = mainfile.getContentType().split("/")[1];
                Path path2 = new File(root + "/starSource/charity/" + charity.getId() + "/mainimage." + contentEnd).toPath();
                Path path1 = new File(root + "/starSource/defaultcharitycrop.png").toPath();
                Path path3 = new File(root + "/starSource/defaultcharity.png").toPath();
                BufferedImage originalImage = ImageIO.read(new File(root + "/starSource/defaultcharitycrop.png"));
                int scaledWidth=220;
                int scaledHeight=160;
                BufferedImage scaled = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
                Graphics2D g = scaled.createGraphics();
                g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
                g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
                g.dispose();
                ImageIO.write(scaled, "png", new File(root + "/starSource/defaultcharitycrop.png"));
                try {
                    Files.copy(path1, path2);
                    charity.setMainphoto("mainimage." + contentEnd);
                    System.out.println("succ file copy");
                    Files.delete(path1);
                    Files.delete(path3);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            String contentEnd1 = docfile.getContentType().split("/")[1];
            String status1 = service.fileUpload(docfile, root + "/starSource/charity/" + charity.getId() + "/document." + contentEnd1);
            charity.setDocument("document." + contentEnd1);
            charity = charityService.editCharity(charity);


        return "validationMessage";
    }
    @RequestMapping(value="/change-charity-status", method=RequestMethod.POST)
    public String changeStatus(HttpServletRequest req){
        boolean status=Boolean.parseBoolean(req.getParameter("status"));
        int id=Integer.parseInt(req.getParameter("id"));
        Charity charity = charityService.getBuyId(id);
        charity.setActivate(status);
        charityService.editCharity(charity);
        return "validationMessage";
    }
}
