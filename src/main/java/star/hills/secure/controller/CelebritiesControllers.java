package star.hills.secure.controller;

import com.messagebird.exceptions.NotFoundException;
import com.stripe.Stripe;
import com.stripe.exception.*;
import com.stripe.model.Charge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
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
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;


/**
 * Created by androlekss on 23.06.16.
 */


@Controller
public class CelebritiesControllers {
   /* private static final Logger LOGGER = Logger.getLogger(CelebritiesControllers.class);*/
    @Autowired
    private StarService starservice = new StarServiceImpl();
    @Autowired
    private StarCharityService starCharityService;
    @Autowired
    private CategoryService categoryservice = new CategoryServiceImpl();
    @Autowired
    private SectionService sectionservice = new SectionServiceImpl();
    @Autowired
    private OrderService orderservice = new OrderServiceImpl();
    @Autowired
    private CharityService charityservice = new CharityServiceImpl();
    @Autowired
    private StarService service=new StarServiceImpl();
    @Autowired
    private EmailService sender=new EmailService();
    @Autowired
    WishedStarService wishedStarService;
    @Autowired
    private NewsService newsservice = new NewsServiceImpl();

    @RequestMapping(value = "/orderingstar", method = RequestMethod.GET)
    public String orderingstar(Model model,HttpServletRequest request ) {
        try {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Star star = starservice.getStarById(id);
        List<StarCharity> charities = starCharityService.charityByStar(star);
        List<Star> stars = starservice.getAllActiv(true,true);
        List<Order> allorders=orderservice.getOrderByStar(star);
        int i=0;

        for(Order o:allorders){
            if(o.getActive()!=0 && o.getCreateddate()!=null) {
                Calendar calendar = Calendar.getInstance();
                int month = calendar.get(Calendar.MONTH);
                calendar.setTime(o.getCreateddate());
                int month1 = calendar.get(Calendar.MONTH);
                if (month == month1) {
                    i++;
                }
            }
        }
        i=star.getVideo()-i;
        model.addAttribute("freevideo", i);
        model.addAttribute("stars", stars);
        model.addAttribute("star", star);
        model.addAttribute("charities", charities);
        model.addAttribute("currentPage", "/pages/orderingstar.jsp");
        }catch(NullPointerException e){
            throw new NullPointerException("Star unter dieser Nummer nicht existiert");
        }
        return "index";
    }
    @RequestMapping(value = "/ordering", method = RequestMethod.GET)
    public String ordering(Model model,HttpServletRequest request, HttpServletResponse response ) {
        try{
        Integer id = Integer.parseInt(request.getParameter("id"));
        Star star = starservice.getStarById(id);
        List<Order> allorders=orderservice.getOrderByStar(star);
        int i=0;

        for(Order o:allorders){
            if(o.getActive()!=0 && o.getCreateddate()!=null) {
                Calendar calendar = Calendar.getInstance();
                int month = calendar.get(Calendar.MONTH);
                calendar.setTime(o.getCreateddate());
                int month1 = calendar.get(Calendar.MONTH);
                if (month == month1) {
                    i++;
                }
            }
        }

        i=star.getVideo()-i;
        if(i>0) {
            model.addAttribute("star", star);
            model.addAttribute("currentPage", "/pages/ordering.jsp");
            List<Star> stars = starservice.getAllActiv(true, true);
            model.addAttribute("stars", stars);
            return "index";
        }else{
            return "redirect:/";
        }
        }catch(NullPointerException e){
            throw new NullPointerException("Star unter dieser Nummer nicht existiert");
        }
    }
    @RequestMapping(value = "/successfulordering", method = RequestMethod.GET)
    public String successfulordering(Model model,HttpServletRequest request ) {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Order order = orderservice.getOrder(id);
        try {
            sender.sendSMS(order.getStar().getPhone(), "Hallo "+order.getStar().getName()+",\n" +
                    "Sie haben eine neue Bestellung. Um diese Bestellung zu bearbeiten, folgen Sie dem https://star-hills.de\n" +
                    "Mit freundlichen Grüßen\n" +
                    "Ihr StarHills-Team");
        } catch (NotFoundException e) {
            e.printStackTrace();
        } catch(NullPointerException e){
            final StringWriter sw = new StringWriter();
            final PrintWriter pw = new PrintWriter(sw, true);
            e.printStackTrace(pw);
            model.addAttribute("stack", "такого юзера не существует<br>"+sw.getBuffer().toString());
            model.addAttribute("currentPage", "/pages/serverError.jsp");
            return "index";
        }
        List<Star> stars = starservice.getAllActiv(true, true);
        model.addAttribute("stars", stars);
        model.addAttribute("order", order);
        model.addAttribute("currentPage", "/pages/successfulordering.jsp");
        return "index";
    }
    @RequestMapping(value = "/successfulcharity", method = RequestMethod.GET)
    public String successfulcharity(Model model,HttpServletRequest request ) {
        model.addAttribute("currentPage", "/pages/charity.jsp");
        return "index";
    }
    @RequestMapping(value = "/search-star", method = RequestMethod.POST)
    public String searchstar(Model model,HttpServletRequest req ) {
        String srh = req.getParameter("Search");
        List<Star> stars = starservice.getAllSearh(srh, srh);
        String srhrez = "&laquo;" + srh + "&raquo; " + stars.size();
        model.addAttribute("stars", stars);
        model.addAttribute("srh", srhrez);
        if(stars.size() == 0 ) {
            model.addAttribute("status", "SearchZero");
            model.addAttribute("srch", srh);
        }
        else model.addAttribute("status", "Search");
        return "validationMessage";
    }

    @RequestMapping(value = "/celebrities", method = RequestMethod.GET)
    public String celebrities(Model model){
        List<Section> sections = sectionservice.getAll("andere");
        List<Category> categories = categoryservice.getAllByStatus(true);
        Category newCategory = categoryservice.getCategoryByName("neu");
        Section section =sectionservice.getSection("andere");
        List<Star> stars = starservice.getAllActiv(true, true);
        for(GrantedAuthority auth : SecurityContextHolder.getContext().getAuthentication().getAuthorities()) {
            if (UserRoleEnum.ADMIN.toString().equals(auth.getAuthority())){
                stars = starservice.getAll();
            }
        }
        model.addAttribute("currentPage", "/pages/celebrities.jsp");
        model.addAttribute("section", section);
        model.addAttribute("sections", sections);
        model.addAttribute("categories", categories);
        model.addAttribute("newCategory", newCategory);
        model.addAttribute("stars", stars);
        return "index";
    }



    @RequestMapping(value = "/ordering-star", method = RequestMethod.POST)
    public String order(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException, IOException {
        Order order = new Order();
        String id = req.getParameter("Idorder");
        int ids;
        if(id.equals("0")){
            order.setNametwo(req.getParameter("NameOrdering").equals("") ?  "audio" : req.getParameter("NameOrdering"));
            order.setEmailtwo(req.getParameter("EmailOrdering"));
            order.setPhonetwo(req.getParameter("PhoneOrdering"));
            order.setName(req.getParameter("NameTwo").equals("") ?  "audio" : req.getParameter("NameTwo"));
            order.setEmail(req.getParameter("EmailTwo"));
            order.setPhone(req.getParameter("PhoneTwo"));
            order.setText(req.getParameter("Compliments").equals("") ?  "audio" : req.getParameter("Compliments"));
            order.setEvent(req.getParameter("Event").equals("") ?  "audio" : req.getParameter("Event"));
            order.setPhoto("/starSource/Foto.jpg");
            order.setTypemessage(Integer.parseInt(req.getParameter("MethodUp")));
            order.setPayment(Integer.parseInt(req.getParameter("Price")));
            order.setCreateddate(new Date(System.currentTimeMillis()));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String dateInString = req.getParameter("Date");
            String timeInString = req.getParameter("Time");
            String datetime = dateInString + " "+timeInString.replace(" ","");
            try {
                Date date = formatter.parse(datetime);
                order.setDate(date);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            String idstar = req.getParameter("Idstar2");
            Star star = starservice.getStarById(Integer.parseInt(idstar));
            order.setStar(star);
            order.setActive(-2);
            order = orderservice.addOrder(order);
            ids = order.getId();
           /* model.addAttribute("idord", "0");
            model.addAttribute("status", "Idord");*/
        }else{
            order = orderservice.getOrder(Integer.parseInt(id));
            order.setNametwo(req.getParameter("NameOrdering").equals("") ?  "audio" : req.getParameter("NameOrdering"));
            order.setEmailtwo(req.getParameter("EmailOrdering"));
            order.setPhonetwo(req.getParameter("PhoneOrdering"));
            order.setName(req.getParameter("NameTwo").equals("") ?  "audio" : req.getParameter("NameTwo"));
            order.setEmail(req.getParameter("EmailTwo"));
            order.setPhone(req.getParameter("PhoneTwo"));
            order.setText(req.getParameter("Compliments").equals("") ?  "audio" : req.getParameter("Compliments"));
            order.setEvent(req.getParameter("Event").equals("") ?  "audio" : req.getParameter("Event"));
            order.setTypemessage(Integer.parseInt(req.getParameter("MethodUp")));
            order.setPayment(Integer.parseInt(req.getParameter("Price")));
            if((req.getParameter("filestatus")).equals("0")) order.setPhoto("/starSource/Foto.jpg");
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String dateInString = req.getParameter("Date");
            String timeInString = req.getParameter("Time");
            String datetime = dateInString + " "+timeInString.replace(" ","");
            try {

                Date date = formatter.parse(datetime);

                order.setDate(date);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            order.setActive(-2);
            orderservice.addOrder(order);
           /* model.addAttribute("idord", "0");
            model.addAttribute("status", "Idord");*/
            ids = order.getId();

        }

        //sender.sendMailOrder(Constants.ADMIN_EMAIL, order, req.getServletContext().getRealPath("/template/emailNewOrder.html") );

        model.addAttribute("idord", ids);
        model.addAttribute("status", "Idord");

      try {

            sender.sendMailOrder(Constants.ADMIN_EMAIL, order, req.getServletContext().getRealPath("/template/emailNewOrder.html"));

        }catch (Exception e){


        }
            return "validationMessage";
    }
    @RequestMapping(value="/orderingphoto", method= RequestMethod.POST)
    public String submitImage(@RequestParam("file") MultipartFile file, Model model, HttpServletRequest req) throws IOException {
        System.out.println("content name " + file.getContentType());
        if(!file.getContentType().split("/")[0].equals("image") || file.getSize()>6000000){
            System.out.println(file.getContentType().split("/")[0]);
            System.out.println("size " + file.getSize());
            model.addAttribute("status", "errror");
            return "validationMessage";
        }
        String idstar = req.getParameter("Idstar2");
        String root = req.getServletContext().getRealPath("/");
        String ids = req.getParameter("Idorder");
        String end = "." + file.getContentType().split("/")[1];
        String url="";
        if(ids.equals("0")) {
            Order order = new Order();
            Star star = starservice.getStarById(Integer.parseInt(idstar));
            order.setStar(star);
            order.setCreateddate(new Date(System.currentTimeMillis()));
            order = orderservice.addOrder(order);
            int id = order.getId();
            url = root + "/starSource/" + idstar + "/orderingphoto/" + id + end;
            order.setPhoto("/starSource/" + idstar + "/orderingphoto/" + id + end);
            orderservice.addOrder(order);
            String status = service.fileUpload(file, url);
            model.addAttribute("idord", order.getId());

        }else {
            url = root + "starSource/" + idstar + "/orderingphoto/" + ids + end;
            String status = service.fileUpload(file, url);

            if((req.getParameter("filestatus")).equals("0")){
                Order order = orderservice.getOrder(Integer.parseInt(ids));
                order.setPhoto("/starSource/" + idstar + "/orderingphoto/" + ids + end);
                orderservice.addOrder(order);
            }
            model.addAttribute("idord", ids);

        }
        BufferedImage originalImage = ImageIO.read(new File(url));
        BufferedImage scaled;
        int scaledWidth = 180;
        int scaledHeight = originalImage.getHeight() * 180 / originalImage.getWidth();
        if(originalImage.getHeight()>180 && originalImage.getWidth()<=originalImage.getHeight()) {
            scaledHeight = 180;
            scaledWidth = originalImage.getWidth() * 180 / originalImage.getHeight();
        }
        scaled = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = scaled.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
        g.dispose();
        ImageIO.write(scaled, "png", new File(url));
        model.addAttribute("status", "Idord");
        return "validationMessage";
    }
    @RequestMapping(value = "/paypal", method = RequestMethod.POST)
    public void paypal(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException, IOException {
        Order order;
        Charity charity;
        try{
                Enumeration<?> en = req.getParameterNames();
                String str = "cmd=_notify-validate";
                    while (en.hasMoreElements()) {
                        String paramName = (String) en.nextElement();
                        String paramValue = req.getParameter(paramName);
                        str = str + "&" + paramName + "=" + URLEncoder.encode(paramValue, "UTF-8");
                    }
            /*LOGGER.info("[Paypal IPN string] " + str);*/
        URL url = new URL("https://www.paypal.com/cgi-bin/webscr");
        URLConnection conn = url.openConnection();
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        OutputStreamWriter wr = new OutputStreamWriter(
                conn.getOutputStream());
        wr.write(str);
        wr.flush();
        /*LOGGER.info("[PayPal otpravil] ");*/
        // response from PayPal - VERIFIED or INVALID
        BufferedReader br = new BufferedReader(new InputStreamReader(
                conn.getInputStream()));
        String line = br.readLine();
        wr.close();
        br.close();
        /*LOGGER.info("[PayPal check string] " + line);*/
        String itemName = req.getParameter("item_name");
        String itemNumber = req.getParameter("item_number");
        String paymentStatus = req.getParameter("payment_status");
        String paymentAmount = req.getParameter("mc_gross");
        String paymentCurrency = req.getParameter("mc_currency");
        String txnId = req.getParameter("txn_id");
        String receiverEmail = req.getParameter("receiver_email");
        String payerEmail = req.getParameter("payer_email");
        /*LOGGER.info("itemName= " + itemName);
        LOGGER.info("itemNumber= " + itemNumber);
        LOGGER.info("paymentStatus= " + paymentStatus);
        LOGGER.info("paymentAmount= " + paymentAmount);
        LOGGER.info("paymentCurrency= " + paymentCurrency);
        LOGGER.info("txnId= " + txnId);
        LOGGER.info("receiverEmail= " + receiverEmail);
        LOGGER.info("payerEmail= " + payerEmail);*/
            if (line.equals("VERIFIED")) {
                    if(Integer.parseInt(itemNumber) != 1 ) {
                        order = orderservice.getOrder(Integer.parseInt(itemName));
                        //order.setPaidstatus(true);
                        order.setPaymentsystem("paypal");
                        orderservice.addOrder(order);
                        try {
                            sender.sendMailOrderPayment(order.getEmailtwo(), order, req.getServletContext().getRealPath("/template/email-success-order.html"));
                            sender.sendMailOrderPayment(order.getStar().getEmail(), order, req.getServletContext().getRealPath("/template/email-new-order.html"));
                            sender.sendMailOrderPayment(Constants.ADMIN_EMAIL, order, req.getServletContext().getRealPath("/template/emailNewOrderPayment.html"));
                        } catch (Exception e) {
           /* LOGGER.error("[ipn] " + e);*/
                        }

                    }else {
                        charity = charityservice.getBuyId(Integer.parseInt(itemName));
                        double amount = Double.parseDouble(paymentAmount);
                        charity.setMoneycollected((charity.getMoneycollected() + amount));
                        charity.setPaymentsystem("paypal");
                        charityservice.addCharity(charity);

                        try {
                            sender.sendMailCharityPayment(Constants.ADMIN_EMAIL, charity, amount, req.getServletContext().getRealPath("/template/emailNewCharityPayment.html"));
                        } catch (Exception e) {
           /* LOGGER.error("[ipn] " + e);*/
                        }

                    }

            } else if (line.equals("INVALID")) {
                // log for investigation
                /*LOGGER.info("PayPal payment INVALID");*/
            } else {
                /*LOGGER.error("Error PayPal");// error*/
            }

        } catch (Exception e) {
           /* LOGGER.error("[ipn] " + e);*/
        }
    }

    @RequestMapping(value = "/sofort", method = RequestMethod.POST)
    public void sofort(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException, IOException {

        Order order;
        Charity charity;

        try{

            Enumeration<?> en = req.getParameterNames();
            String str = "cmd=_notify-validate";
            while (en.hasMoreElements()) {
                String paramName = (String) en.nextElement();
                String paramValue = req.getParameter(paramName);
                str = str + "&" + paramName + "=" + URLEncoder.encode(paramValue, "UTF-8");
            }

                /*LOGGER.info("sofortURL= " + str);*/

            String user_variable_3 = req.getParameter("user_variable_3");
            String user_variable_1 = req.getParameter("user_variable_1");
            String amountString = req.getParameter("amount");

            if(Integer.parseInt(user_variable_3) != 1 ) {
                order = orderservice.getOrder(Integer.parseInt(user_variable_1));
                //order.setPaidstatus(true);
                order.setPaymentsystem("sofort");
                orderservice.addOrder(order);
                try {
                    sender.sendMailOrderPayment(order.getEmailtwo(), order, req.getServletContext().getRealPath("/template/email-success-order.html"));
                    sender.sendMailOrderPayment(order.getStar().getEmail(), order, req.getServletContext().getRealPath("/template/email-new-order.html"));
                    sender.sendMailOrderPayment(Constants.ADMIN_EMAIL, order, req.getServletContext().getRealPath("/template/emailNewOrderPaymentSF.html"));
                } catch (Exception e) {
           /* LOGGER.error("[ipn] " + e);*/
                }
            }else {
                charity = charityservice.getBuyId(Integer.parseInt(user_variable_1));
                double amount = Double.parseDouble(amountString);
                charity.setMoneycollected((charity.getMoneycollected() + amount));
                charity.setPaymentsystem("sofort");
                charityservice.addCharity(charity);
                try {
                    sender.sendMailCharityPayment(Constants.ADMIN_EMAIL, charity, amount, req.getServletContext().getRealPath("/template/emailNewCharityPayment.html"));
                } catch (Exception e) {
           /* LOGGER.error("[ipn] " + e);*/
                }

            }

        } catch (Exception e) {
            /*LOGGER.error("[ipn] " + e);*/
        }



    }

    @RequestMapping(value = "/stripe", method = RequestMethod.POST)
    public String stripe(Model model, HttpServletRequest req, HttpServletResponse response)  throws ServletException, IOException {

        Order order;
        Charity charity;

        Stripe.apiKey = "sk_test_a8GS4OwcZKlQHIQst7ijuH7t";
        int amount;

// Get the credit card details submitted by the form
        String token = req.getParameter("stripeToken");
        int id = Integer.parseInt(req.getParameter("id"));

        if (id > 0) {

            order = orderservice.getOrder(id);
            amount = order.getPayment() * 100;
        } else {

            amount = Integer.parseInt(req.getParameter("amount"));

        }


// Create the charge on Stripe's servers - this will charge the user's card
        try {
            Map<String, Object> chargeParams = new HashMap<String, Object>();

            chargeParams.put("amount", amount); // amount in cents, again
            chargeParams.put("currency", "eur");
            chargeParams.put("source", token);
            chargeParams.put("description", "Example charge");



            try {
                Charge charge = Charge.create(chargeParams);

                if(id > 0 ) {
                    System.out.println("Order " + id + "   " + amount);
                    order = orderservice.getOrder(id);
                    //order.setPaidstatus(true);
                    order.setPaymentsystem("stripe");
                    orderservice.addOrder(order);
                    try {
                        sender.sendMailOrderPayment(order.getEmailtwo(), order, req.getServletContext().getRealPath("/template/email-success-order.html"));
                        sender.sendMailOrderPayment(order.getStar().getEmail(), order, req.getServletContext().getRealPath("/template/email-new-order.html"));
                        sender.sendMailOrderPayment(Constants.ADMIN_EMAIL, order, req.getServletContext().getRealPath("/template/emailNewOrderPaymentS.html"));
                    } catch (Exception e) {
           /* LOGGER.error("[ipn] " + e);*/
                    }
                }else {
                    System.out.println("Charity " + id + "   " + amount);
                    charity = charityservice.getBuyId(-1*id);
                    charity.setMoneycollected((charity.getMoneycollected() + amount/100));
                    charity.setPaymentsystem("stripe");
                    charityservice.addCharity(charity);
                    try {
                        sender.sendMailCharityPayment(Constants.ADMIN_EMAIL, charity, amount/100, req.getServletContext().getRealPath("/template/emailNewCharityPayment.html"));
                    } catch (Exception e) {
           /* LOGGER.error("[ipn] " + e);*/
                    }
                    model.addAttribute("status", "CharityPay");
                    model.addAttribute("chpay", charity.getMoneycollected());
                    return "validationMessage";
                }
            } catch (AuthenticationException e) {
                e.printStackTrace();
            } catch (InvalidRequestException e) {
                e.printStackTrace();
            } catch (APIConnectionException e) {
                e.printStackTrace();
            } catch (APIException e) {
                e.printStackTrace();
            }
        } catch (CardException e) {
            /*LOGGER.error("The card has been declined");*/
        }

        model.addAttribute("status", "CharityPay");
        return "validationMessage";
    }

    @RequestMapping(value="request-star-srch", method=RequestMethod.POST)
    public String requestStarSrch(HttpServletRequest req, HttpServletResponse resp, Model model){
        WishedStar wishedStar=new WishedStar();
        wishedStar.setName(req.getParameter("Namerem"));
        wishedStar.setEmail(req.getParameter("Emailrem"));
        wishedStarService.addWishedStar(wishedStar);
        try {
            sender.sendMailWishedStar(Constants.ADMIN_EMAIL, wishedStar, req.getServletContext().getRealPath("/template/email-request-star.html"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        model.addAttribute("status", "okrequest");
        return "validationMessage";
    }

}
