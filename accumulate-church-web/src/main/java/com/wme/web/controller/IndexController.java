package com.wme.web.controller;

import com.wme.base.utils.PaginationSupport;
import com.wme.web.entity.ChurchParish;
import com.wme.web.query.ChurchParishQuery;
import com.wme.web.service.ChurchParishService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * Created by Wangmingen on 2015/9/14.
 */

@Controller
public class IndexController {

    @Resource
    private ChurchParishService churchParishService;

    /*@RequestMapping("index")
    public String index(){
        return "index";
    }*/

    @RequestMapping(value = "login",method = RequestMethod.GET)
    public String login(@ModelAttribute("name") String name){
        return "login";
    }


    @RequestMapping(value = "/index")
    public ModelAndView list(ChurchParishQuery churchParishQuery){
        ModelAndView view = new ModelAndView("/index");

        if(churchParishQuery.getStatus()==null){
            churchParishQuery.setStatus(1);
        }
        PaginationSupport<ChurchParish> paginationSupport = churchParishService.pageList(churchParishQuery);
        int total = paginationSupport.getTotalCount();

        view.addObject("lessonQuery", churchParishQuery);
        view.addObject("total", total);
        view.addObject("churchParishs", paginationSupport.getItems());
        return view;
    }

}
