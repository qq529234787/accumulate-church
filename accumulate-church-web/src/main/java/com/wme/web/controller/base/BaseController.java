package com.wme.web.controller.base;

import com.google.gson.Gson;
import com.wme.base.utils.MultiDateParseEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by ming on 2017/7/8.
 */
public class BaseController {

    protected Gson gson = new Gson();

    @InitBinder
    protected void initBinder(ServletRequestDataBinder binder) {
        List<DateFormat> dateFormats = new LinkedList<DateFormat>();
        dateFormats.add(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        dateFormats.add(new SimpleDateFormat("yyyy-MM-dd"));
        binder.registerCustomEditor(Date.class, new MultiDateParseEditor(dateFormats, true));
        //将提交上来的String类型参数主动进行trim()过滤
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
        //binder.registerCustomEditor(Integer.class, new IntegerEditor());
    }

}
