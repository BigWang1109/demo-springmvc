package com.icss.demo.model;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;


//使用默认大小写属性转换json
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY, getterVisibility = JsonAutoDetect.Visibility.NONE)
public class UserOrg {
    private static final long serialVersionUID = 1L;

    public UserOrg() {
        super();
    }

    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "USERNAME", length = 64)
    private String username;

    @Column(name = "GENDER")
    private Integer gender;

    @Column(name = "BIRTHDAY", length = 64)
    private String loginname;

    @Column(name = "ORGCODE", length = 64)
    private String orgcode;

    @Column(name = "ORGNAME", length = 64)
    private String orgname;

    @Column(name = "EMAIL")
    private String email;

    @DateTimeFormat(pattern = "yyyy-MM-dd" )
    @Column(name = "CREATETIME")
    private Date createtime;

//    @Override
//    public String toString() {
//        return "UserJSON [id=" + id + ", username=" + username + ", gender=" + gender
//                + ", loginname=" + loginname + ", birthday=" + birthday + "]";
//    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getOrgcode() {
        return orgcode;
    }

    public void setOrgcode(String orgcode) {
        this.orgcode = orgcode;
    }

    public String getOrgname() {
        return orgname;
    }

    public void setOrgname(String orgname) {
        this.orgname = orgname;
    }
}
