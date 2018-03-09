package com.wme.base.constants;

/**
 * 年龄段
 */
public enum AgeGroupEnum {

    baby(1,"婴孩（1~5岁）"),
    ErTong(2,"儿童（6~12岁）"),
    QingShaoNian(3,"青少年（13~17岁）"),
    QingNian(4,"青年（18~40岁）"),
    ChengNian(5,"中年（41~60岁）"),
    LaoNian(6,"老年（61岁以上）");

    private Integer status;
    private String value;

    AgeGroupEnum(Integer status, String value) {
        this.status = status;
        this.value = value;
    }

    public Integer getStatus() {
        return status;
    }

    public String getValue() {
        return value;
    }

    public boolean isEqual(Integer status) {
        return this.status.equals(status);
    }
}
