package star.hills.secure.config;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.multipart.support.MultipartFilter;
import org.springframework.web.servlet.DispatcherServlet;
import star.hills.secure.main.IeFilter;

import javax.servlet.*;
import javax.servlet.ServletRegistration.Dynamic;
import java.util.EnumSet;

public class Initializer implements WebApplicationInitializer {

    private static final String DISPATCHER_SERVLET_NAME = "dispatcher";

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        AnnotationConfigWebApplicationContext ctx = new AnnotationConfigWebApplicationContext();
        ctx.register(WebAppConfig.class);
        ctx.register(SecurityConfig.class);
        ctx.register(DataConfigAmazon.class);
        ctx.register(MailConfig.class);
        ctx.register(AsyncConfig.class);
        servletContext.addListener(new ContextLoaderListener(ctx));
        //servletContext.addListener(MainListner.class);
        FilterRegistration.Dynamic multipartFilter = servletContext.addFilter("multipartFilter", new MultipartFilter());
        multipartFilter.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), false, "/*");
        FilterRegistration.Dynamic ieFilter = servletContext.addFilter("ieFilter", new IeFilter());
        ieFilter.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), false, "/*");
        ctx.setServletContext(servletContext);
        ctx.refresh();
        Dynamic servlet = servletContext.addServlet(DISPATCHER_SERVLET_NAME, new DispatcherServlet(ctx));
        servlet.addMapping("/");
        servlet.setLoadOnStartup(1);
        servlet.setMultipartConfig(new MultipartConfigElement("/tmp", 1024 * 1024 * 5, 1024 * 1024 * 6, 1024 * 1024));
    }
}
