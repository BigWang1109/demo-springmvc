package com.icss.demo.model;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

import javax.persistence.*;

/**
 * Created by wxx on 16-11-29.
 */
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY, getterVisibility = JsonAutoDetect.Visibility.NONE)
@Entity
@Table(name = "T_CLOB")
public class TClob {

    private static final long serialVersionUID = 1L;

    public TClob() {
        super();
    }

    @Id
    @Column(name = "ID")
    private String id;

    @Lob
    @Basic(fetch = FetchType.LAZY)
    @Column(name="DATAXML", columnDefinition="CLOB", nullable=true)
    private String dataXml;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDataXml() {
        return dataXml;
    }

    public void setDataXml(String dataXml) {
        this.dataXml = dataXml;
    }
}


