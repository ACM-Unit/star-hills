package star.hills.secure.test.service;


import com.messagebird.MessageBirdClient;
import com.messagebird.MessageBirdService;
import com.messagebird.MessageBirdServiceImpl;
import com.messagebird.exceptions.GeneralException;
import com.messagebird.exceptions.NotFoundException;
import com.messagebird.exceptions.UnauthorizedException;
import com.messagebird.objects.Balance;
import com.messagebird.objects.MessageResponse;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import star.hills.secure.service.*;
import star.hills.secure.service.impl.EmailService;
import star.hills.secure.service.impl.ImageGrabber;
import star.hills.secure.test.config.TestDataBaseConfig;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.io.*;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@DirtiesContext
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = TestDataBaseConfig.class)
@WebAppConfiguration
public class UserServiceTest {
    public static final String ACCOUNT_SID = "AC5000fde03d2bb02487bf8dc322a6ac41";
    public static final String AUTH_TOKEN = "2e2bc50e6179fd2a4fdc1a574c2a3546";
    @Resource
    private EntityManagerFactory emf;
    protected EntityManager em;
    @Resource
    private EmailService sender;
    @Resource
    private UserService userService;
    @Resource
    private VideoService videoService;
    @Resource
    private StarService starService;
    @Resource
    private SectionService sectionService;
    @Resource
    private CategoryService categoryService;
    @Resource
    private OrderService orderService;
    @Resource
    private ImageGrabber grabber;
    @Before
    public void setUp() throws Exception {
        em = emf.createEntityManager();
    }

    @Test
    public void testSaveUser() throws Exception {

   /*     TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);   // Build the parameters
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("To", "+380500814356"));
        params.add(new BasicNameValuePair("From", "+12243331042"));
        params.add(new BasicNameValuePair("Body", "Tomorrow's forecast in Financial District, San Francisco is Clear."));
        params.add(new BasicNameValuePair("MediaUrl", "https://climacons.herokuapp.com/clear.png"));
        MessageFactory messageFactory = client.getAccount().getMessageFactory();
        Message message = messageFactory.create(params);
        System.out.println(message.getSid());*/
        /*Order order =orderService.getOrder(1);
        Star star=order.getStar();*/
        String realPath="D:/2/starhills/src/main/webapp";
       /* String realPathUbuntu="/home/slava/IdeaProjects/MySites/starhills/src/main/webapp";
        grabber.setRealPath(realPath);
        grabber.setOrder(order);
        grabber.graberImage();
        sender.sendMailOrder(Constants.ADMIN_EMAIL, order, realPath +"/template/emailWithVideo.html");*/
        ZipOutputStream out = null;
        try {
            out = new ZipOutputStream(new FileOutputStream(realPath + "/starSource.zip"));
            File file = new File(realPath + "/starSource");
            doZip(file, out);
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
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
    @Test
    public void testSMS() throws NotFoundException {
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
            phones.add(new BigInteger("4917670203532"));
            final MessageResponse response = messageBirdClient.sendMessage("StarHills", "This message from easy-it", phones);
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
    @Test
    public void testjava(){
        int[] mass={1,2,3,8,5,4,7,6,10,9};
        int mas;
        for(int i=0; i<mass.length; i++){
            for(int j=i+1; j<mass.length; j++){
                if(mass[i]> mass[j]){
                    mas=mass[i];
                    mass[i]=mass[j];
                    mass[j]=mas;
                }
            }
        }
        for(int i=0; i<mass.length; i++){
            System.out.print(mass[i]+", ");
        }
    }
}
