package star.hills.secure.controller;

/**
 * Created by Admin on 21.10.2016.
 */

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HttpErrorHandler{


    @RequestMapping(value="/404")
    public String error404(Model model){
        model.addAttribute("currentPage", "/pages/pageNotFound.jsp");
        return "index";
    }

    @RequestMapping(value="/500")
    public String error500(Model model){
        model.addAttribute("currentPage", "/pages/serverError.jsp");
        return "index";
    }


}
