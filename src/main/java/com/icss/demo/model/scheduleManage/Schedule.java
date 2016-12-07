package com.icss.demo.model.scheduleManage;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by thinkpad on 2016/12/1.
 */
//使用默认大小写属性转换json
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY, getterVisibility = JsonAutoDetect.Visibility.NONE)
@Entity
@Table(name = "SCHEDULE")
public class Schedule {
    @Id
    @Column(name="TASKID")
    private String taskId;

    @Column(name="TASKCONTENT")
    private String taskContent;
    @DateTimeFormat(pattern = "yyyy-MM-dd" )
    @Column(name="MODIFYDATE")
    private Date modifyDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd" )
    @Column(name="CREATEDATE")
    private Date createDate;

    @Column(name="MODIFIER")
    private String modifier;

    @Column(name="RESPONSEPERSON")
    private String responsePerson;



    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getTaskContent() {
        return taskContent;
    }

    public void setTaskContent(String taskContent) {
        this.taskContent = taskContent;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public String getResponsePerson() {
        return responsePerson;
    }

    public void setResponsePerson(String responsePerson) {
        this.responsePerson = responsePerson;
    }


}
