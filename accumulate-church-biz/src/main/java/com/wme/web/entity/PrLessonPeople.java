package com.wme.web.entity;

import sun.misc.BASE64Encoder;

/**
 * Created by ming on 2017/3/12.
 */
public class PrLessonPeople extends BaseEntity {

    private Long lessonId;

    private Long peopleId;

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


    private String peopleName;

    private boolean isSign;

    private byte[] headPortrait;

    private String headBase64;

    public String getPeopleName() {
        return peopleName;
    }

    public void setPeopleName(String peopleName) {
        this.peopleName = peopleName;
    }

    public boolean isSign() {
        return isSign;
    }

    public void setIsSign(boolean isSign) {
        this.isSign = isSign;
    }

    public byte[] getHeadPortrait() {
        return headPortrait;
    }

    public void setHeadPortrait(byte[] headPortrait) {
        this.headPortrait = headPortrait;
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

}
