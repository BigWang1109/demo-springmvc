package com.icss.demo.service.common;

import com.icss.demo.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by thinkpad on 2016/12/1.
 */
@Service
public class UMService {

    public static List<Map<String,Object>> getUser(){
        Session session = null;
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        try {
            session = HibernateUtil.getSession();
            String sql_select = " select USERID,USERNAME from FHKGUSER  ";
            Query querySelect = session.createSQLQuery(sql_select);
            list = querySelect.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();

        }catch (Exception e){
            e.printStackTrace();
        } finally {
            if(session != null){
                session.close();
            }
        }
        return list;
    }
}
