package com.wme.web.service.impl;

import com.wme.base.service.impl.BaseServiceImpl;
import com.wme.web.entity.PrLessonPeople;
import com.wme.web.persistence.mysql.PrLessonPeopleMapper;
import com.wme.web.service.PrLessonPeopleService;
import org.springframework.stereotype.Service;

/**
 * Created by ming on 2017/3/12.
 */
@Service
public class PrLessonPeopleServiceImpl extends
        BaseServiceImpl<PrLessonPeopleMapper, PrLessonPeople> implements PrLessonPeopleService {

        @Override
        public int deleteByLessonPeople(PrLessonPeople prLessonPeople) {
                return mapper.deleteByLessonPeople(prLessonPeople);
        }

}
