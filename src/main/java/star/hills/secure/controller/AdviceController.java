package star.hills.secure.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import java.io.PrintWriter;
import java.io.StringWriter;


@ControllerAdvice
public class AdviceController {

    @ExceptionHandler(Exception.class)
    public ModelAndView handleIOException(Exception exception) {
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("currentPage", "/pages/serverError.jsp");
        final StringWriter sw = new StringWriter();
        final PrintWriter pw = new PrintWriter(sw, true);
        exception.printStackTrace(pw);
        modelAndView.addObject("headstack", exception.getMessage());
        modelAndView.addObject("stack", sw.getBuffer().toString());
        return modelAndView;
    }


}