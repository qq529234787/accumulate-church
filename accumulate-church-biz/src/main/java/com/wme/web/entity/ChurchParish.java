package com.wme.web.entity;

/**
 * Created by ming on 2017/3/12.
 * 堂点
 */
public class ChurchParish extends BaseEntity {

    private String name;

    private String address;

    private String remark;


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
}
