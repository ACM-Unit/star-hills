package star.hills.secure.service.impl;

import com.messagebird.MessageBirdClient;
import com.messagebird.MessageBirdService;
import com.messagebird.MessageBirdServiceImpl;
import com.messagebird.exceptions.GeneralException;
import com.messagebird.exceptions.NotFoundException;
import com.messagebird.exceptions.UnauthorizedException;
import com.messagebird.objects.Balance;
import com.messagebird.objects.MessageResponse;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import star.hills.secure.entity.*;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Admin on 17.05.2016.
 */

public class EmailService {
    @Autowired
    private JavaMailSender sender;
    private StringBuffer templates;

    private JavaMailSender getSender() {
        return sender;
    }

@Async
    public void sendMail(String to, Star star, String urlToFile) throws IOException {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!"+Thread.currentThread().getName()+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        templates = new StringBuffer(FileUtils.readFileToString(new File(urlToFile), "utf-8"));
        this.setVariable("name", star.getName());
        this.setVariable("password", star.getUser().getPassword());
        this.setVariable("skype", star.getSkype());
        this.setVariable("phone", star.getPhone());
        this.setVariable("email", star.getEmail());
        this.setVariable("recover", star.getRecoverpass());
        this.setVariable("balance", String.valueOf(star.getBalance()));
        this.setVariable("alias", String.valueOf(star.getUser().getLogin()));
        if(star.isStatus()){
            this.setVariable("status", "ON");
        }else{
            this.setVariable("status", "OFF");
        }
        MimeMessage message = sender.createMimeMessage();
        try {
            message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(to));
            message.setSubject("message from site star-hills.de", "UTF-8");
            message.setHeader("Content-Type", "text/plain; charset=UTF-8");
            message.setContent(templates, "text/html; charset=utf-8");
            message.setText(templates.toString(), "utf-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        sender.send(message);
    /*    SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("star-hils");
        message.setTo(to);
        message.setSubject(title);
        message.setText(text);
        sender.send(message);*/
    }
    public void setVariable(String parameter, String value) throws UnsupportedEncodingException {
        if (value == null) {
            value = "not set";
        }
        parameter = "${" + parameter + "}";
        int index = templates.indexOf(parameter);
        while (index != -1) {
            templates.replace(index, index + parameter.length(), value);
            index += value.length();
            index = templates.indexOf(parameter, index);
        }
    }
    @Async
    public void sendMailOrder(String to, Order order, String urlToFile) throws IOException {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!"+Thread.currentThread().getName()+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        String typemessage = null;

        switch (order.getTypemessage()){
            case 1:
                typemessage = "Email";
		        break;
            case 2:
                typemessage = "Phone";
                break;

            case 3:
                typemessage = "Viber";
                break;

            case 4:
                typemessage = "WhatsApp";
                break;

            case 5:
                typemessage = "Facebook";
                break;

        }

        templates = new StringBuffer(FileUtils.readFileToString(new File(urlToFile), "utf-8"));
        this.setVariable("nameStar", order.getStar().getName());
        this.setVariable("idStar", String.valueOf(order.getStar().getId()));
        this.setVariable("id", String.valueOf(order.getId()));
        this.setVariable("nametwo", order.getNametwo());
        this.setVariable("namevideo", order.getPathvideo());
        this.setVariable("phonetwo", order.getPhonetwo());
        this.setVariable("emailtwo", order.getEmailtwo());
        this.setVariable("name", order.getName());
        this.setVariable("phone", order.getPhone());
        this.setVariable("email", order.getEmail());
        /*this.setVariable("audio", if order.get());*/
        this.setVariable("photo", (order.getPhoto().equals("/starSource/Foto.jpg")) ? "no photo" : "with photo");
        this.setVariable("event", order.getEvent());
        this.setVariable("text", order.getText());
        this.setVariable("date", order.getDate().toString());
        this.setVariable("sendUp", typemessage);
        MimeMessage message = sender.createMimeMessage();
        try {
            message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(to));
            message.setSubject("message from site star-hills.de", "UTF-8");
            message.setHeader("Content-Type", "text/plain; charset=UTF-8");
            message.setContent(templates, "text/html; charset=utf-8");
            message.setText(templates.toString(), "utf-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        sender.send(message);


    }
    @Async
    public void sendMailWishedStar(String to, WishedStar wishedStar, String urlToFile) throws IOException {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!"+Thread.currentThread().getName()+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        templates = new StringBuffer(FileUtils.readFileToString(new File(urlToFile), "utf-8"));
        this.setVariable("name", wishedStar.getName());
        this.setVariable("email", String.valueOf(wishedStar.getEmail()));
        MimeMessage message = sender.createMimeMessage();
        try {
            message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(to));
            message.setSubject("message from site star-hills.de", "UTF-8");
            message.setHeader("Content-Type", "text/plain; charset=UTF-8");
            message.setContent(templates, "text/html; charset=utf-8");
            message.setText(templates.toString(), "utf-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        sender.send(message);
    }
    @Async
    public void sendMailClient(String to, Client client, String urlToFile) throws IOException {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!"+Thread.currentThread().getName()+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        templates = new StringBuffer(FileUtils.readFileToString(new File(urlToFile), "utf-8"));
        this.setVariable("firstname", client.getFirstname());
        this.setVariable("lastname", client.getFirstname());
        this.setVariable("email", client.getEmail());
        this.setVariable("title", client.getTitle());
        this.setVariable("text", client.getText());
        MimeMessage message = sender.createMimeMessage();
        try {
            message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(to));
            message.setSubject("message from site star-hills.de", "UTF-8");
            message.setHeader("Content-Type", "text/plain; charset=UTF-8");
            message.setContent(templates, "text/html; charset=utf-8");
            message.setText(templates.toString(), "utf-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        sender.send(message);
    }
    @Async
    public void sendMailCharityPayment(String to, Charity charity, double money, String realPath)  throws IOException {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!"+Thread.currentThread().getName()+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        templates = new StringBuffer(FileUtils.readFileToString(new File(realPath), "utf-8"));
        this.setVariable("nameCharity", charity.getName());
        this.setVariable("Money", String.valueOf(money));
                MimeMessage message = sender.createMimeMessage();
        try {
            message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(to));
            message.setSubject("message from site star-hills.de", "UTF-8");
            message.setHeader("Content-Type", "text/plain; charset=UTF-8");
            message.setContent(templates, "text/html; charset=utf-8");
            message.setText(templates.toString(), "utf-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        sender.send(message);
    }
    @Async
    public void sendMailOrderPayment(String to, Order order, String realPath) throws IOException {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!"+Thread.currentThread().getName()+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            templates = new StringBuffer(FileUtils.readFileToString(new File(realPath), "utf-8"));

        String typemessage = null;

        switch (order.getTypemessage()){
            case 1:
                typemessage = "Email";
                break;

            case 2:
                typemessage = "Phone";
                break;

            case 3:
                typemessage = "Viber";
                break;

            case 4:
                typemessage = "WhatsApp";
                break;

            case 5:
                typemessage = "Facebook";
                break;

        }

        this.setVariable("nameStar", order.getStar().getName());
            this.setVariable("idStar", String.valueOf(order.getStar().getId()));
            this.setVariable("id", String.valueOf(order.getId()));
            this.setVariable("nametwo", order.getNametwo());
            this.setVariable("namevideo", order.getPathvideo());
            this.setVariable("phonetwo", order.getPhonetwo());
            this.setVariable("payment", String.valueOf(order.getPayment()));
            this.setVariable("emailtwo", order.getEmailtwo());
            this.setVariable("name", order.getName());
            this.setVariable("phone", order.getPhone());
            this.setVariable("email", order.getEmail());
            /*this.setVariable("audio", if order.get());*/
            this.setVariable("photo", (order.getPhoto().equals("/starSource/Foto.jpg")) ? "no photo" : "with photo");
            this.setVariable("event", order.getEvent());
            this.setVariable("starname", order.getStar().getName());
            this.setVariable("text", order.getText());
            this.setVariable("date", order.getDate().toString());
            this.setVariable("sendUp", typemessage);

            MimeMessage message = sender.createMimeMessage();
            try {
                message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(to));
                message.setSubject("message from site star-hills.de", "UTF-8");
                message.setHeader("Content-Type", "text/plain; charset=UTF-8");
                message.setContent(templates, "text/html; charset=utf-8");
                message.setText(templates.toString(), "utf-8", "html");
            } catch (MessagingException e) {
                e.printStackTrace();
            }
            sender.send(message);
    }
    @Async
    public void sendSMS(String number, String text) throws NotFoundException {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!"+Thread.currentThread().getName()+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        final MessageBirdService messageBirdService = new MessageBirdServiceImpl("live_EbLktl796yOT3XHDLCNsj32Yu");
// Add the service to the client
        final MessageBirdClient messageBirdClient = new MessageBirdClient(messageBirdService);
        try {
            // Get Balance
            System.out.println("Retrieving your balance:");
            final Balance balance = messageBirdClient.getBalance();
            // Display balance
            System.out.println(balance.toString());
            final List<BigInteger> phones = new ArrayList<BigInteger>();
            number = number.replaceAll("\\D", "");
            phones.add(new BigInteger(number));
            final MessageResponse response = messageBirdClient.sendMessage("StarHills", text, phones);
            System.out.println(response.toString());
        } catch (UnauthorizedException unauthorized) {
            if (unauthorized.getErrors() != null) {
                System.out.println(unauthorized.getErrors().toString());
            }
            unauthorized.printStackTrace();
        } catch (GeneralException generalException) {
            if (generalException.getErrors() != null) {
                System.out.println(generalException.getErrors().toString());
            }
            generalException.printStackTrace();
        }
    }
}