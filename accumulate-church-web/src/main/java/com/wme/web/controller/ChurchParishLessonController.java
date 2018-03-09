package com.wme.web.controller;

import com.wme.base.constants.GenderEnum;
import com.wme.base.constants.StatusEnum;
import com.wme.base.utils.PaginationSupport;
import com.wme.web.controller.base.BaseController;
import com.wme.web.entity.ChurchParish;
import com.wme.web.entity.ChurchParishLesson;
import com.wme.web.entity.ChurchPeople;
import com.wme.web.query.ChurchParishLessonQuery;
import com.wme.web.query.ChurchPeopleQuery;
import com.wme.web.service.ChurchParishLessonService;
import com.wme.web.service.ChurchParishService;
import com.wme.web.service.ChurchPeopleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ming on 2017/3/18.
 */
@Controller
@RequestMapping(value = "/churchParishLesson")
public class ChurchParishLessonController extends BaseController{

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private ChurchParishLessonService lessonService;
    @Resource
    private ChurchPeopleService churchPeopleService;
    @Resource
    private ChurchParishService churchParishService;

    @RequestMapping(value = "/parishIndex")
    public ModelAndView parishIndex(ChurchParishLessonQuery lessonQuery){
        ModelAndView view = new ModelAndView("/churchParishLesson/parishIndex");

        ChurchParish parish = churchParishService.get(lessonQuery.getParishId());

        ChurchPeopleQuery churchPeopleQuery = new ChurchPeopleQuery();
        churchPeopleQuery.setStatus(1);
        churchPeopleQuery.setParishId(lessonQuery.getParishId());
        churchPeopleQuery.setPageSize(1000);
        PaginationSupport<ChurchPeople> paginationPeople = churchPeopleService.pageList(churchPeopleQuery);

        if(lessonQuery.getStatus()==null){
            lessonQuery.setStatus(1);
        }
        PaginationSupport<ChurchParishLesson> paginationSupport = lessonService.pageList(lessonQuery);
        int total = paginationSupport.getTotalCount();

        view.addObject("GenderEnumArr", GenderEnum.values());
        view.addObject("lessonQuery", lessonQuery);
        view.addObject("total", total);
        view.addObject("parish", parish);
        view.addObject("parishLessons", paginationSupport.getItems());
        view.addObject("churchPeoples", paginationPeople.getItems());
        return view;
    }

    @RequestMapping(value = "/list")
    public ModelAndView list(ChurchParishLessonQuery lessonQuery){
        ModelAndView view = new ModelAndView("/churchParishLesson/list");

        ChurchParish parish = churchParishService.get(lessonQuery.getParishId());

        if(lessonQuery.getStatus()==null){
            lessonQuery.setStatus(1);
        }
        PaginationSupport<ChurchParishLesson> paginationSupport = lessonService.pageList(lessonQuery);
        int total = paginationSupport.getTotalCount();

        view.addObject("parish", parish);
        view.addObject("lessonQuery", lessonQuery);
        view.addObject("total", total);
        view.addObject("parishLessons", paginationSupport.getItems());
        return view;
    }

    @RequestMapping(value = "/addOrUpdate")
    @ResponseBody
    public String addOrUpdate(ChurchParishLesson parishLesson) {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "");
        try{
            if(parishLesson==null || parishLesson.getWorshipDate()==null || parishLesson.getParishId() == null){
                result.put("message", "参数异常");
                return gson.toJson(result);
            }

            int count = 0;
            if(parishLesson.getId() == null){
                parishLesson.setStatus(StatusEnum.VALID.getStatus());
                count = lessonService.insert(parishLesson);
            }else{
                count = lessonService.update(parishLesson);
            }

            if (count>0) {
                result.put("code", "true");
            }

        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        return gson.toJson(result);
    }

}
