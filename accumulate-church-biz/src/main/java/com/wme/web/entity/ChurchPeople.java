package com.wme.web.entity;

import com.wme.base.utils.DateUtils;
import sun.misc.BASE64Encoder;

import java.util.Date;

/**
 * Created by ming on 2017/3/12.
 * 敬拜者表
 */
public class ChurchPeople extends BaseEntity {

    private String name;

    private String mobile;

    private String gender;

    private Date birthday;

    private String birthdayStr;

    private String remark;

    private Integer sort;

    private byte[] headPortrait;

    private Long parishId;

    private String headBase64;

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

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public byte[] getHeadPortrait() {
        return headPortrait;
    }

    public void setHeadPortrait(byte[] headPortrait) {
        this.headPortrait = headPortrait;
    }

    public Long getParishId() {
        return parishId;
    }

    public void setParishId(Long parishId) {
        this.parishId = parishId;
    }

    public Integer getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(Integer ageGroup) {
        this.ageGroup = ageGroup;
    }

    public String getHeadBase64() {
        if(headBase64 == null || headBase64 == "") {
            if(headPortrait != null){
                BASE64Encoder encoder = new BASE64Encoder();
                headBase64 = "data:image/jpeg;base64,"+encoder.encode(headPortrait);
            }
        }

        return headBase64;
    }

    public String getBirthdayStr() {
        if(birthday != null){
            birthdayStr = DateUtils.dateToString(birthday);
        }
        return birthdayStr;
    }
}
