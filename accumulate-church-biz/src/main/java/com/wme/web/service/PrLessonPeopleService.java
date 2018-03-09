package com.wme.web.service;

import com.wme.base.service.BaseService;
import com.wme.web.entity.PrLessonPeople;
import com.wme.web.persistence.mysql.PrLessonPeopleMapper;

/**
 * Created by ming on 2017/3/12.
 */
public interface PrLessonPeopleService extends BaseService<PrLessonPeopleMapper, PrLessonPeople> {

    int deleteByLessonPeople(PrLessonPeople prLessonPeople);

}
