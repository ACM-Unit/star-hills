package star.hills.secure.main;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Admin on 12.10.2016.
 */
public class IeFilter implements Filter{

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        HttpSession session = request.getSession();
        String userAgent = ((HttpServletRequest) request).getHeader("User-Agent");
        if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
            System.out.println(userAgent);
            if (request.getRequestURI().endsWith(".css")) {
                chain.doFilter(request, response);
                return;
            }
            if (request.getRequestURI().endsWith(".js")) {
                chain.doFilter(request, response);
                return;
            }
           /* if (request.getRequestURI().endsWith("/")) {
                chain.doFilter(request, response);
                return;
            }*/
            if (request.getRequestURI().endsWith(".jpg")) {
                chain.doFilter(request, response);
                return;
            }
            if (request.getRequestURI().endsWith(".png")) {
                chain.doFilter(request, response);
                return;
            }
            request.getRequestDispatcher("/explorer").forward(request, response);
        } else {
            chain.doFilter(request, response);
        }

    }

    @Override
    public void destroy() {

    }
}
