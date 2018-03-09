package com.wme.web.query;

import com.wme.base.utils.PageQuery;
import com.wme.web.entity.ChurchParish;

/**
 * Created by ming on 2017/3/12.
 */
public class ChurchParishQuery extends PageQuery  {

    private String name;

    private String address;

    private String remark;

    private Integer status;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
