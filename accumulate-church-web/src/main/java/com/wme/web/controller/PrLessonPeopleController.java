package com.wme.web.controller;

import com.wme.base.constants.AgeGroupEnum;
import com.wme.base.constants.GenderEnum;
import com.wme.base.constants.StatusEnum;
import com.wme.web.controller.base.BaseController;
import com.wme.web.entity.ChurchParishLesson;
import com.wme.web.entity.PrLessonPeople;
import com.wme.web.query.PrLessonPeopleQuery;
import com.wme.web.service.ChurchParishLessonService;
import com.wme.web.service.PrLessonPeopleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ming on 2017/3/18.
 */
@Controller
@RequestMapping(value = "/prLessonPeople")
public class PrLessonPeopleController extends BaseController{

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private PrLessonPeopleService prLessonPeopleService;

    @Resource
    private ChurchParishLessonService lessonService;

    /*@RequestMapping(value = "/list")
    public ModelAndView list(PrLessonPeopleQuery lessonPeopleQuery){
        ModelAndView view = new ModelAndView("/prLessonPeople/list");

        lessonPeopleQuery.setPageNo(1);
        lessonPeopleQuery.setPageSize(1000);
        PaginationSupport<PrLessonPeople> paginationSupport = prLessonPeopleService.pageList(lessonPeopleQuery);
        int total = paginationSupport.getTotalCount();

        view.addObject("lessonPeopleQuery", lessonPeopleQuery);
        view.addObject("total", total);
        view.addObject("lessonPeoples", paginationSupport.getItems());
        return view;
    }*/

    @RequestMapping(value = "/toSignView")
    public ModelAndView toSignView(PrLessonPeopleQuery lessonPeopleQuery){
        ModelAndView view = new ModelAndView("/prLessonPeople/list");

        ChurchParishLesson lesson = lessonService.get(lessonPeopleQuery.getLessonId());
        lessonPeopleQuery.setParishId(lesson.getParishId());
        List<PrLessonPeople> prLessonPeopleList = prLessonPeopleService.list(lessonPeopleQuery);
        view.addObject("lessonPeopleQuery", lessonPeopleQuery);
        view.addObject("prLessonPeopleList", prLessonPeopleList);
        view.addObject("lesson", lesson);
        view.addObject("GenderEnumArr", GenderEnum.values());
        view.addObject("AgeGroupEnumArr", AgeGroupEnum.values());
        return view;
    }
    @RequestMapping(value = "/getByLessonPeople")
    @ResponseBody
    public String getByLessonPeople(PrLessonPeopleQuery lessonPeopleQuery) {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "");
        try{
            int count = prLessonPeopleService.count(lessonPeopleQuery);
            if(count>0){
                result.put("code", "true");
            }

        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        return gson.toJson(result);
    }

    @RequestMapping(value = "/insert")
    @ResponseBody
    public String insert(PrLessonPeople lessonPeople) {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "");
        try{
            if(lessonPeople==null || lessonPeople.getLessonId()==null || lessonPeople.getLessonId()<=0
                    || lessonPeople.getPeopleId()==null || lessonPeople.getPeopleId()<=0){
                result.put("message", "参数异常");
                return gson.toJson(result);
            }

            lessonPeople.setStatus(StatusEnum.VALID.getStatus());
            int insert = prLessonPeopleService.insert(lessonPeople);
            if(insert==1){
                result.put("code", "true");
            }

        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        return gson.toJson(result);
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public String delete(PrLessonPeople lessonPeople) throws IOException {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "");
        try{
            if(lessonPeople==null || lessonPeople.getLessonId()==null || lessonPeople.getLessonId()<=0
                    || lessonPeople.getPeopleId()==null || lessonPeople.getPeopleId()<=0){
                result.put("message", "参数异常");
                return gson.toJson(result);
            }

            int num = prLessonPeopleService.deleteByLessonPeople(lessonPeople);
            if(num>=1){
                result.put("code", "true");
            }

        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        return gson.toJson(result);
    }

    @RequestMapping(value = "/signName")
    @ResponseBody
    public String signName(PrLessonPeople lessonPeople) throws IOException {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "");
        try{
            if(lessonPeople==null || lessonPeople.getLessonId()==null || lessonPeople.getLessonId()<=0
                    || lessonPeople.getPeopleId()==null || lessonPeople.getPeopleId()<=0){
                result.put("message", "参数异常");
                return gson.toJson(result);
            }
            int i = prLessonPeopleService.deleteByLessonPeople(lessonPeople);
            if(i>0){
                lessonPeople.setStatus(StatusEnum.VALID.getStatus());
                int insert = prLessonPeopleService.insert(lessonPeople);
                if(insert==1){
                    result.put("code", "true");
                }
            }

        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        return gson.toJson(result);
    }

}
