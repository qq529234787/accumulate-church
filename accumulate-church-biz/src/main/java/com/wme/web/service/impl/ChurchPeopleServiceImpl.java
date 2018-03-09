package com.wme.web.service.impl;

import com.wme.base.service.impl.BaseServiceImpl;
import com.wme.web.entity.ChurchPeople;
import com.wme.web.persistence.mysql.ChurchPeopleMapper;
import com.wme.web.service.ChurchPeopleService;
import org.springframework.stereotype.Service;

/**
 * Created by ming on 2017/3/12.
 */
@Service
public class ChurchPeopleServiceImpl extends
        BaseServiceImpl<ChurchPeopleMapper, ChurchPeople> implements ChurchPeopleService {


        @Override
        public int changeStatus(Long id, Integer status) {
                ChurchPeople churchPeople = new ChurchPeople();
                churchPeople.setStatus(status);
                churchPeople.setId(id);
                int update = this.update(churchPeople);
                return update;
        }
}
