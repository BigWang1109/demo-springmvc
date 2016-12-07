package com.icss.demo.service.scheduleManage;

import com.icss.demo.common.Constants;
import com.icss.demo.common.Pagination;
import com.icss.demo.common.QueryParams;
import com.icss.demo.model.scheduleManage.Schedule;
import com.icss.demo.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;

/**
 * Created by thinkpad on 2016/12/1.
 */
@Service
public class SMService {

    public static Map<String,Object> loadByPage(Pagination pagination){
        Map<String, Object> map = new Hashtable<String, Object>(3);
        List list = new ArrayList();
        int totalCount = 0;
        Session session = null;
        try{
            session = HibernateUtil.getSession();

            String hql_count = "select count(*) from SCHEDULE where 1=1 ";
            String hql_select = "select s.TASKID,s.TASKCONTENT,s.CREATEDATE,f.username from SCHEDULE s left join fhkguser f on s.responseperson = f.userid where 1=1 ";

            for(QueryParams query : pagination.getQuerys()){
                if(query.getName().equals("responsePerson") && !StringUtils.isEmpty(query.getValue().toString()) && !query.getValue().toString().equals("0"))
                {
                    hql_select += " and RESPONSEPERSON =:responsePerson ";
                    hql_count += " and RESPONSEPERSON =:responsePerson ";
                }
                if(query.getName().equals("taskContent") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    hql_select += " and TASKCONTENT like:taskContent ";
                    hql_count += " and TASKCONTENT like:taskContent ";
                }
                if(query.getName().equals("enter_date_from") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    hql_select += " and CREATEDATE >=to_date(:enter_date_from,'yyyy-MM-dd') ";
                    hql_count +=  " and CREATEDATE >=to_date(:enter_date_from,'yyyy-MM-dd') ";
                }
                if(query.getName().equals("enter_date_to") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    hql_select += " and CREATEDATE <=to_date(:enter_date_to,'yyyy-MM-dd') ";
                    hql_count +=  " and CREATEDATE <=to_date(:enter_date_to,'yyyy-MM-dd') ";
                }
            }

            hql_select += "order by CREATEDATE asc";

            SQLQuery queryCount = session.createSQLQuery(hql_count);
            SQLQuery querySelect = session.createSQLQuery(hql_select);

            for(QueryParams query : pagination.getQuerys()){
                if(query.getName().equals("taskContent") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    queryCount.setString("taskContent", "%"+query.getValue().toString()+"%");
                    querySelect.setString("taskContent", "%"+query.getValue().toString()+"%");
                }
                if(query.getName().equals("responsePerson") && !StringUtils.isEmpty(query.getValue().toString())&& !query.getValue().toString().equals("0"))
                {
                    queryCount.setString("responsePerson", query.getValue().toString());
                    querySelect.setString("responsePerson", query.getValue().toString());
                }
                if(query.getName().equals("enter_date_from") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    queryCount.setString("enter_date_from", query.getValue().toString());
                    querySelect.setString("enter_date_from", query.getValue().toString());
                }
                if(query.getName().equals("enter_date_to") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    queryCount.setString("enter_date_to", query.getValue().toString());
                    querySelect.setString("enter_date_to", query.getValue().toString());
                }
            }
            //计算总页数
            totalCount = pagination.getClientPageCount();
            totalCount = ((Number) queryCount.list().get(0)).intValue();
            //获取分页处理
            querySelect.setFirstResult((pagination.getPage() - 1) * Constants.PAGE_ROW_COUNT);
            querySelect.setMaxResults(pagination.getRows());
            List array = querySelect.list();
            for(int i=0;i<array.size();i++){
                Object []obj = (Object[])array.get(i);
                Map mapt = new HashMap();
                mapt.put("taskId",obj[0]);
                int len = obj[1].toString().length();
                mapt.put("taskContent",obj[1].toString().substring(0,len<6?len:6)+"...");
                mapt.put("createDate",obj[2]);
                mapt.put("responsePerson",obj[3]);

                list.add(mapt);
            }


        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(session !=null){
                session.close();
            }
        }
        map.put("total",totalCount);
        map.put("rows", list);
        map.put("QueryKey", pagination.getQueryKey());

        return map;
    }

    /**
     * 根据UUID查询工作内容
     * @param uuid
     * @return
     */
    public Schedule getScheduleByUUID(String uuid){
        Schedule res = null;
        Session session = null;
        try {
            session = HibernateUtil.getSession();
            String hql_select = "from Schedule where taskId =:UUID";
            Query querySelect = session.createQuery(hql_select);
            querySelect.setString("UUID", uuid);
            List<Schedule> list = querySelect.list();
            if(list != null && list.size() == 1){
                res = list.get(0);
            }
        }catch (Exception e){
            e.printStackTrace();
        } finally {
            if(session != null){
                session.close();
            }
        }
        return res;
    }

    /**
     * 保存工作内容
     * @param schedule
     * @return
     */
    public boolean saveTask(Schedule schedule){
        Session session = null;
        try {
            session = HibernateUtil.getSession();
            Transaction ts = session.beginTransaction();
            session.saveOrUpdate(schedule);
            session.flush();
            ts.commit();
        } catch (Exception e){
            e.printStackTrace();
            return false;
        } finally {
            if(session != null){
                session.close();
            }
        }
        return true;
    }

    public Boolean deleteTasks(String ids){
        Session session = null;
        try {
            session = HibernateUtil.getSession();
            Transaction ts = session.beginTransaction();
            String sql_delete = "delete from schedule where TASKID in(:ids)";
            Query querySelect = session.createSQLQuery(sql_delete);
            String[] idsArr = ids.replace("'", "").split(",");
            querySelect.setParameterList("ids", idsArr);
            int s = querySelect.executeUpdate();
            if(s < 1){
                return false;
            }
            ts.commit();
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            if(session != null){
                session.close();
            }
        }
        return true;
    }
}
