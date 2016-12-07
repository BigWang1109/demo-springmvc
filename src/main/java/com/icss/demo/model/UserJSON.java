package com.icss.demo.model;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import org.hibernate.LobHelper;
import org.hibernate.annotations.Nationalized;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.hibernate.annotations.TypeDefs;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.sql.Clob;
import java.util.Date;


//@TypeDefs({
//        @TypeDef(
//                name="clob",
//                typeClass = foo.StringClobType.class
//        )
//})
//使用默认大小写属性转换json
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY, getterVisibility = JsonAutoDetect.Visibility.NONE)
@Entity
@Table(name = "T_USER")
public class UserJSON {
    private static final long serialVersionUID = 1L;

    public UserJSON() {
        super();
    }

    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "USERNAME", length = 64)
    private String username;

    @Column(name = "GENDER")
    private Integer gender;

    @Column(name = "LOGINNAME", length = 64)
    private String loginname;

    @Column(name = "ORGCODE", length = 64)
    private String orgcode;

    @Transient
    private String orgid;

    @Column(name = "ROLENAMES")
    private String rolenames;

    @Column(name = "EMAIL")
    private String email;

    @DateTimeFormat(pattern = "yyyy-MM-dd" )
    //@Temporal(TemporalType= TIMESTAMP)
    @Column(name = "CREATETIME")
    private Date createtime;

    @ManyToOne(fetch=FetchType.EAGER,cascade=CascadeType.REFRESH)
    @JoinColumn(name="ORGID")
    private OrgTree orgTree;


    //@Basic(fetch = FetchType.LAZY)
    //@Lob(type = LobType.CLOB)
    // @Type(type="org.springframework.orm.hibernate4.support.ClobStringType")
    //@Type(type="org.springframework.orm.hibernate4.support.ClobStringType")
   // @Column(name="XMLDATA", columnDefinition="CLOB", nullable=true)
    //@Type(type="org.hibernate.type.MaterializedClobType")
    //@Nationalized

    @Lob
    @Column(name="XMLDATA", columnDefinition="CLOB", nullable=true)
    private String xmlData;

    public String getXmlData() {
        return xmlData;
    }

    public void setXmlData(String xmlData) {
        this.xmlData = xmlData;
    }

//    public Clob getXmlData() {
//        return xmlData;
//    }
//
//    public void setXmlData(Clob xmlData) {
//        this.xmlData = xmlData;
//    }


//    @Transient
//    private String xmlDataString;
//
//    public String getXmlDataString() {
//        return xmlDataString;
//    }
//
//    public void setXmlDataString(String xmlDataString) {
//        this.xmlDataString = xmlDataString;
//    }



    //    @Override
//    public String toString() {
//        return "UserJSON [id=" + id + ", username=" + username + ", gender=" + gender
//                + ", loginname=" + loginname + ", birthday=" + birthday + "]";
//    }

    public OrgTree getOrgTree() {
        return orgTree;
    }

    public void setOrgTree(OrgTree orgTree){
        this.orgTree = orgTree;
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

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public String getOrgcode() {
        return orgcode;
    }

    public void setOrgcode(String orgcode) {
        this.orgcode = orgcode;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public String getRolenames() {
        return rolenames;
    }

    public void setRolenames(String rolenames) {
        this.rolenames = rolenames;
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
}
