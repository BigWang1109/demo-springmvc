package com.icss.demo.service.messBoardManage;

import com.icss.demo.model.messBoard.messBoard;
import com.icss.demo.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by thinkpad on 2016/11/30.
 */
@Service
public class MBService {

    public boolean leaveMessage(messBoard mess){
        Session session = null;
        try{
            session = HibernateUtil.getSession();
            Transaction ts = session.beginTransaction();
            session.saveOrUpdate(mess);
            ts.commit();
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }finally{
            if(session != null){
                session.close();
            }
        }
        return true;
    }

    public messBoard getMessage(String messageId){
        Session session = null;

        messBoard mess = new messBoard();
        try{
            session = HibernateUtil.getSession();
            String hql = " from messBoard  where messageId =:UUID  order by modifytime desc";
            Query queryContent = session.createQuery(hql);
            queryContent.setString("UUID",messageId);
//            int len = queryContent.list().size();
//            mess = (messBoard)queryContent.list().get(len-1);
            if(queryContent.list().size()!=0){
                mess = (messBoard)queryContent.list().get(0);
                String str = mess.getContent();
//            str = str.replaceAll("\r\n","</br>");
                if(str!=null && !"".equals(str) && str.indexOf("\r\n")!=-1){
                    str = str.replaceAll("\r\n","&#13;&#10;");
//                str = str.replaceAll("\r\n","</br>");
                }
                mess.setContent(str);
            }

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(session != null){
                session.close();
            }
        }
        return mess;
    }

    public List loadMessList(){
        Session session = null;
        List messList = new ArrayList();
        try{
            session = HibernateUtil.getSession();
            String str = "from messBoard order by modifytime desc";
            Query query = session.createQuery(str);
            List array = query.list();
            for(int i=0;i<array.size();i++){
                messBoard mess = (messBoard)array.get(i);
                if(mess.getContent()!=null && !"".equals(mess.getContent().toString())){
                    int len = mess.getContent().toString().length();
                    mess.setContent(mess.getContent().substring(0,len<10?len:10)+"...");
                    messList.add(mess);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(session!=null){
                session.close();
            }
        }
        return messList;
    }

    public Boolean delMess(String ids){
        Session session = null;
        int count = 0;
        try{
            session = HibernateUtil.getSession();
            Transaction ts = session.beginTransaction();

            String sql_delete = "delete from message where MESSAGEID in(:ids)";
            Query querySelect = session.createSQLQuery(sql_delete);
            String[] idsArr = ids.replace("'", "").split(",");
            querySelect.setParameterList("ids", idsArr);

            count = querySelect.executeUpdate();

            if(count<1){
                return false;
            }

            ts.commit();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(session!=null){
                session.close();
            }
        }
        return true;
    }
}
