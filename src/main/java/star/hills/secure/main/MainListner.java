package star.hills.secure.main;

//import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import star.hills.secure.service.impl.DatabaseContextThread;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Created by Admin on 11.07.2016.
 */
@WebListener
public class MainListner implements ServletContextListener {
   // private static final Logger LOGGER = Logger.getLogger(MainListner.class);
@Autowired
private DatabaseContextThread thread = null;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        final WebApplicationContext springContext = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
        String realpath=sce.getServletContext().getRealPath("/");
      //  LOGGER.info(realpath);
        if ((thread == null) || (!thread.isAlive())) {
           // LOGGER.info("STARTING CONTEXT THREAD");
           this.thread = new DatabaseContextThread();
            thread.setRealPath(realpath);
            this.thread.start();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
       //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        try {
            System.out.println("STOPING CONTEXT THREAD");
            thread.doShutdown();
            thread.interrupt();
        } catch (Exception ex) {
            System.out.println("Error Stoping Thread: " + ex.getMessage());
        }
    }
}
