package com.wme.web.query;

import com.wme.base.utils.PageQuery;
import com.wme.web.entity.ChurchParishLesson;

import java.util.Date;

/**
 * Created by ming on 2017/3/12.
 */
public class ChurchParishLessonQuery extends PageQuery  {

    private Integer status;

    private Date start;

    private Date end;

    private Date worshipDate;

    private Long parishId;

    private String teacher;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

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
}
