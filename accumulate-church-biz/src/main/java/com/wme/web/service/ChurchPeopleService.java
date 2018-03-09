package com.wme.web.service;

import com.wme.base.service.BaseService;
import com.wme.web.entity.ChurchPeople;
import com.wme.web.persistence.mysql.ChurchPeopleMapper;

/**
 * Created by ming on 2017/3/12.
 */
public interface ChurchPeopleService extends BaseService<ChurchPeopleMapper, ChurchPeople> {

    int changeStatus(Long id, Integer status);
}
