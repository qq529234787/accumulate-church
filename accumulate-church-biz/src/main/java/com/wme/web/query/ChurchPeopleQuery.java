package com.wme.web.query;

import com.wme.base.utils.PageQuery;

import java.util.Date;

/**
 * Created by ming on 2017/3/12.
 */
public class ChurchPeopleQuery extends PageQuery {

    private String name;

    private String mobile;

    private String gender;

    private Date birthday;

    private String remark;

    private int sort;

    private Long parishId;

    private Integer status;

    private Integer ageGroup; // 年龄段 1:1~5  2:6~12 3:13~17 4:18~40 5:41~60 6:61以上

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
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

    public Integer getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(Integer ageGroup) {
        this.ageGroup = ageGroup;
    }
}
