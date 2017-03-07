package star.hills.secure.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;
import star.hills.secure.entity.Order;
import star.hills.secure.service.OrderService;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by Admin on 12.07.2016.
 */
@Service
public class DatabaseContextThread extends Thread {
    private static final Logger LOGGER = Logger.getLogger(DatabaseContextThread.class);
    private String realPath;

    public void setRealPath(String realPath) {
        this.realPath = realPath;
    }
    @Autowired
    private ImageGrabber grabber;
    @Autowired
    private OrderService orderService;
    @Autowired
    private EmailService sender;
    @Override
    public void run() {
        SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
        Date dateFirst=new Date();
        System.out.println(dateFirst);
        int i=0;
        while(true) {
            try {
                Date dateSecond = new Date();
                System.out.println("start thread cycle");
                LOGGER.info("start thread cycle");
                List<Order> orderList = new ArrayList<Order>();
                orderList = orderService.getOrderByDate(dateFirst, dateSecond);
                if (orderList.size() > 0) {
                    for (Order order : orderList) {
                        if (order.getActive() == -1 && order.isPaidstatus()) {
                            order.setActive(1);
                            orderService.editOrder(order);
                            try {
                            /* sender.sendMailOrder("natalia.shulhaa@gmail.com", order, realPathUbuntu +"/template/emailWithVideo.html");*/
                                if(order.getTypemessage()==1) {
                                    sender.sendMailOrder(order.getEmail(), order, realPath + "/template/emailWithVideo.html");
                                }else if(order.getTypemessage()==2){
                                    sender.sendSMS(order.getPhone(), "https://star-hills.de/your-video?star="+order.getStar().getId()+"&video="+order.getPathvideo());
                                }
                            } catch (IOException e) {
                               // LOGGER.info(e.getMessage());
                            }
                        }
                    }
                }

                dateFirst=dateSecond;
            }catch(Exception e) {
                System.out.println(e.getMessage());
            }
            try {
                sleep(1000*60*15);
                i++;
            } catch (InterruptedException e) {
                System.out.println(e.getMessage());
            }
            if(i==96){
                ZipOutputStream out = null;
                try {
                    out = new ZipOutputStream(new FileOutputStream("/home/logs/starSource.zip"));
                    File file = new File(realPath + "/starSource");
                    doZip(file, out);
                    out.close();
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                i=0;
            }
        }

    }

    public void doShutdown() {

    }
    private static void doZip(File dir, ZipOutputStream out) throws IOException {
        for (File f : dir.listFiles()) {
            if (f.isDirectory())
                doZip(f, out);
            else {
                out.putNextEntry(new ZipEntry(f.getPath()));
                write(new FileInputStream(f), out);
            }
        }
    }

    private static void write(InputStream in, OutputStream out) throws IOException {
        byte[] buffer = new byte[1024];
        int len;
        while ((len = in.read(buffer)) >= 0)
            out.write(buffer, 0, len);
        in.close();
    }

}