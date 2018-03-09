package com.wme.web.controller;

import com.wme.base.constants.AgeGroupEnum;
import com.wme.base.constants.GenderEnum;
import com.wme.base.constants.StatusEnum;
import com.wme.base.utils.PaginationSupport;
import com.wme.web.controller.base.BaseController;
import com.wme.web.entity.ChurchParish;
import com.wme.web.entity.ChurchPeople;
import com.wme.web.query.ChurchPeopleQuery;
import com.wme.web.service.ChurchParishService;
import com.wme.web.service.ChurchPeopleService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ming on 2017/3/12.
 */
@Controller
@RequestMapping(value = "/churchPeople")
public class ChurchPeopleController extends BaseController{

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Resource
    private ChurchPeopleService churchPeopleService;

    @Resource
    private ChurchParishService churchParishService;

    @RequestMapping(value = "/list")
    public ModelAndView list(ChurchPeopleQuery churchPeopleQuery){
        ModelAndView view = new ModelAndView("/churchPeople/list");

        ChurchParish parish = churchParishService.get(churchPeopleQuery.getParishId());

        churchPeopleQuery.setPageSize(1000);
        /*if(churchPeopleQuery.getStatus()==null){
            churchPeopleQuery.setStatus(1);
        }*/

        List<ChurchPeople> stablePeoples = new ArrayList<>();
        List<ChurchPeople> deletePeoples = new ArrayList<>();
        PaginationSupport<ChurchPeople> paginationSupport = churchPeopleService.pageList(churchPeopleQuery);
        if(paginationSupport != null && paginationSupport.getItems() != null){
            List<ChurchPeople> items = paginationSupport.getItems();
            for (ChurchPeople people : items) {
                if(people != null){
                    if(people.getStatus() != null && people.getStatus().equals(1)){ // 有效
                        stablePeoples.add(people);
                    }else {
                        deletePeoples.add(people);
                    }
                }
            }
        }

        view.addObject("churchPeopleQuery", churchPeopleQuery);
        view.addObject("parish", parish);
        view.addObject("stablePeoples", stablePeoples);
        view.addObject("deletePeoples", deletePeoples);
        view.addObject("GenderEnumArr", GenderEnum.values());
        view.addObject("AgeGroupEnumArr", AgeGroupEnum.values());
        return view;
    }

    @RequestMapping(value = "/writeImage")
    public void writeImage(Long id, HttpServletResponse response) throws IOException {
        ChurchPeople churchPeople = churchPeopleService.get(id);
        if(churchPeople!=null && churchPeople.getHeadPortrait()!=null){
            byte[] bytes = churchPeople.getHeadPortrait();
            if(bytes.length>0){
                response.getOutputStream().write(bytes);
            }
        }
    }

    @RequestMapping(value = "/changeStatus")
    @ResponseBody
    public String changeStatus(Long id, Integer status) throws IOException {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "");
        try{
            if(id==null || id.longValue()<=0 || status==null){
                result.put("message", "参数异常");
                return gson.toJson(result);
            }
            int delete = churchPeopleService.changeStatus(id, status);
            if (delete>0) {
                result.put("code", "true");
            }

        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        return gson.toJson(result);
    }

    /*@RequestMapping(value = "/toAdd")
    public ModelAndView toAdd(Long parishId){
        ModelAndView view = new ModelAndView("/churchPeople/save");

        ChurchParish churchParish = churchParishService.get(parishId);
        view.addObject("GenderEnumArr", GenderEnum.values());
        view.addObject("churchParish", churchParish);
        return view;
    }*/

    @RequestMapping(value = "/findById")
    @ResponseBody
    public Object findById(Long id, HttpServletResponse response){
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "人员id有误");
        ChurchPeople churchPeople = churchPeopleService.get(id);
        if(churchPeople != null){
            result.put("code", "true");
            churchPeople.getHeadBase64(); //
            churchPeople.getBirthdayStr();//
            result.put("result", churchPeople);
        }
        return gson.toJson(result);
    }

    /*@RequestMapping(value = "/add")
    @ResponseBody
    public String add(ChurchPeople churchPeople) throws IOException {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "失败");
        try{
            if(churchPeople==null){
                result.put("message", "参数异常");
                return gson.toJson(result);
            }
            churchPeople.setStatus(StatusEnum.VALID.getStatus());
            int id = churchPeopleService.insert(churchPeople);
            if (id>0) {
                result.put("code", "true");
            }

        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        return gson.toJson(result);
    }

    @RequestMapping(value = "/update")
    @ResponseBody
    public String update(ChurchPeople churchPeople) throws IOException {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "");
        try{
            if(churchPeople==null || churchPeople.getId()==null
                    ||  churchPeople.getId().longValue()<=0){
                result.put("message", "参数异常");
                return gson.toJson(result);
            }

            int count = churchPeopleService.update(churchPeople);
            if (count>0) {
                result.put("code", "true");
            }

        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        return gson.toJson(result);
    }*/

    @RequestMapping(value = "/addOrUpdate")
    @ResponseBody
    public String addOrUpdate(ChurchPeople churchPeople) {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "");
        try{
            if(churchPeople==null || StringUtils.isBlank(churchPeople.getName())
                    || churchPeople.getParishId()==null || churchPeople.getParishId()<=0){
                result.put("message", "参数异常");
                return gson.toJson(result);
            }
            if(churchPeople.getSort() == null){
                churchPeople.setSort(1000);
            }

            int count = 0;
            if(churchPeople.getId() == null){
                churchPeople.setStatus(StatusEnum.VALID.getStatus());
                count = churchPeopleService.insert(churchPeople);
            }else{
                count = churchPeopleService.update(churchPeople);
            }

            if (count>0) {
                result.put("code", "true");
            }

        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        return gson.toJson(result);
    }

    @ResponseBody
    @RequestMapping(value = "/uploadHeadPortrait", method = RequestMethod.POST)
    public Object uploadHeadPortrait(@RequestParam("img") MultipartFile file, Long id) {
        Map<String,Object> result = new HashMap<>();
        result.put("code", "false");
        result.put("message", "");
        if(id==null){
            result.put("message", "参数异常");
            return gson.toJson(result);
        }

        try {
            ChurchPeople churchPeople = new ChurchPeople();
            churchPeople.setId(id);
            churchPeople.setHeadPortrait(file.getBytes());
            int count = churchPeopleService.update(churchPeople);
            if (count>0) {
                result.put("code", "true");
            }

        } catch (IOException e) {
            result.put("message", "获取图片字节异常");
            logger.error(e.getMessage(), e);
        }

        return gson.toJson(result);
    }


}
