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
@Entity
@Table(name = "T_ORGTREE")
public class OrgTree {
    private static final long serialVersionUID = 1L;

    public OrgTree() {
        super();
    }

    @Id
    @Column(name = "ID")
    private String id;

    @Column(name = "PARENTID", length = 64)
    private String parentid;

    @Column(name = "ORGCODE", length = 64)
    private String orgcode;

    @Column(name = "ORGNAME", length = 64)
    private String orgname;

    @Column(name = "LEVERCODE", length = 254)
    private String levercode;

    @Column(name = "STATE")
    private int state;

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getLevercode() {
        return levercode;
    }

    public void setLevercode(String levercode) {
        this.levercode = levercode;
    }

    @Override
    public String toString() {
        return "ORGTREE [id=" + id + ", parentid=" + parentid + ", orgcode=" + orgcode
                + ", orgname=" + orgname
                + ", levercode=" + levercode
                + ", state=" + state +"]";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid;
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
