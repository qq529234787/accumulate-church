package com.wme.base.utils;

import org.springframework.util.StringUtils;

import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.List;

public class MultiDateParseEditor extends PropertyEditorSupport {
    private List<DateFormat> dateFormats;

    private boolean allowEmpty;

    private final int exactDateLength;

    /**
     * 构造多日期格式编辑器
     * @param dateFormats 多个日期格式应保证详细日期优先处理
     * @param allowEmpty 是否允许为空
     */
    public MultiDateParseEditor(List<DateFormat> dateFormats, boolean allowEmpty){
        if (dateFormats== null || dateFormats.size() == 0){
            throw new IllegalArgumentException("Param dateFormats could not be empty");
        }
        this.dateFormats = dateFormats;
        this.allowEmpty = allowEmpty;
        this.exactDateLength = -1;
    }

    /**
     * 构造多日期格式编辑器
     * @param dateFormats 多个日期格式应保证详细日期优先处理
     * @param allowEmpty 是否允许为空
     * @param exactDateLength 控制精确日期信息长度
     */
    public MultiDateParseEditor(List<DateFormat> dateFormats, boolean allowEmpty, int exactDateLength){
        if (dateFormats== null || dateFormats.size() == 0){
            throw new IllegalArgumentException("Param dateFormats could not be empty");
        }
        this.dateFormats = dateFormats;
        this.allowEmpty = allowEmpty;
        this.exactDateLength = exactDateLength;
    }

    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        if (this.allowEmpty && !StringUtils.hasText(text)) {
            // Treat empty String as null value.
            setValue(null);
        }else if (text != null && this.exactDateLength >= 0 && text.length() != this.exactDateLength) {
            throw new IllegalArgumentException(
                    "Could not parse date: it is not exactly" + this.exactDateLength + "characters long");
        }else {
            ParseException lastException = null;
            for (DateFormat dateFormat : dateFormats) {
                try {
                    setValue(dateFormat.parse(text));
                    return;
                } catch (ParseException e) {
                    lastException = e;
                }
            }
            throw new IllegalArgumentException("Could not parse date: " + lastException.getMessage(), lastException);
        }
    }
}
