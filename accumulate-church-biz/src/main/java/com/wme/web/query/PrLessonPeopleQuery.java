package com.wme.web.query;

import com.wme.base.utils.PageQuery;

/**
 * Created by ming on 2017/3/18.
 */
public class PrLessonPeopleQuery extends PageQuery {

    private Long lessonId;

    private Long peopleId;

    private Long parishId;

    private Integer status;


    public Long getLessonId() {
        return lessonId;
    }

    public void setLessonId(Long lessonId) {
        this.lessonId = lessonId;
    }

    public Long getPeopleId() {
        return peopleId;
    }

    public void setPeopleId(Long peopleId) {
        this.peopleId = peopleId;
    }

    public Long getParishId() {
        return parishId;
    }

    public void setParishId(Long parishId) {
        this.parishId = parishId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
