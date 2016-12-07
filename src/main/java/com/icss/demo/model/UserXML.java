package com.icss.demo.model;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import javax.xml.bind.annotation.XmlRootElement;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;


@XmlRootElement(name = "User")
@Entity
@Table(name = "t_user")
public class UserXML {
    private static final long serialVersionUID = 1L;

    public UserXML() {
        super();
    }

    @Id
    @Column(name = "id")
    private String id;

    @Column(name = "username", length = 64)
    private String username;

    @Column(name = "gender")
    private Integer gender;

    @Column(name = "loginname", length = 64)
    private String loginname;


    @Column(name = "email")
    private String email;

    @Column(name = "birthday")
    private Date birthday;

    @Override
    public String toString() {
        return "UserXML [id=" + id + ", username=" + username + ", gender=" + gender
                + ", loginname=" + loginname + ", birthday=" + birthday + "]";
    }

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

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }
}
