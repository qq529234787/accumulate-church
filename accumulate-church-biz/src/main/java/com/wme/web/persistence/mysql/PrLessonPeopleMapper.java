package com.wme.web.persistence.mysql;

import com.wme.base.persistance.BaseMapper;
import com.wme.web.entity.PrLessonPeople;

/**
 * Created by ming on 2017/3/12.
 */
public interface PrLessonPeopleMapper extends BaseMapper<PrLessonPeople> {

    int deleteByLessonPeople(PrLessonPeople prLessonPeople);

}
