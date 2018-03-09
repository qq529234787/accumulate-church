package com.wme.web.entity;

import com.wme.base.utils.DateUtils;

import java.util.Date;

/**
 * Created by ming on 2017/3/12.
 * 敬拜日期表
 */
public class ChurchParishLesson extends BaseEntity {

    private Date start;

    private Date end;

    private Date worshipDate;

    private Long parishId;

    private String worshipDateStr;

    private String teacher;

    public Date getStart() {
        return start;
    }

    public void setStart(Date start) {
        this.start = start;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }

    public Date getWorshipDate() {
        return worshipDate;
    }

    public void setWorshipDate(Date worshipDate) {
        this.worshipDate = worshipDate;
    }

    public Long getParishId() {
        return parishId;
    }

    public void setParishId(Long parishId) {
        this.parishId = parishId;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public String getWorshipDateStr() {
        if(worshipDate != null){
            worshipDateStr = DateUtils.dateToString(worshipDate, "yyyy-MM-dd");
        }
        return worshipDateStr;
    }

}
