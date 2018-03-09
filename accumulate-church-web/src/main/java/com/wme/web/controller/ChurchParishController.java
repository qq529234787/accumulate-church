package com.wme.web.controller;

import com.wme.base.utils.PaginationSupport;
import com.wme.web.entity.ChurchParish;
import com.wme.web.entity.ChurchParishLesson;
import com.wme.web.query.ChurchParishLessonQuery;
import com.wme.web.query.ChurchParishQuery;
import com.wme.web.service.ChurchParishLessonService;
import com.wme.web.service.ChurchParishService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * Created by ming on 2017/3/18.
 */
@Controller
@RequestMapping(value = "/churchParish")
public class ChurchParishController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private ChurchParishService churchParishService;

    @RequestMapping(value = "/list")
    public ModelAndView list(ChurchParishQuery churchParishQuery){
        ModelAndView view = new ModelAndView("/churchParish/list");

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
