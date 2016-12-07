package com.icss.demo.service;

import com.icss.demo.common.BaseService;
import com.icss.demo.common.Constants;
import com.icss.demo.common.Pagination;
import com.icss.demo.common.QueryParams;
import com.icss.demo.model.OrgTree;
import com.icss.demo.model.TClob;
import com.icss.demo.model.UserJSON;
import com.icss.demo.util.DateTimeUtil;
import com.icss.demo.util.HibernateUtil;
import org.hibernate.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import java.sql.Clob;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by wxx on 16-11-29.
 */
public class DemoService {

    private static final Logger logger = LoggerFactory.getLogger(DemoService.class);

    public OrgTree getOrgTreeByID(String id) {
        OrgTree model = null;
        Session session = null;
        try {
            session = HibernateUtil.getSession();
            model = (OrgTree) session.get(OrgTree.class, id);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }
        return model;
    }


    public OrgTree getByHQL(String id) {
        OrgTree model = null;
        Session session = null;
        try {
            session = HibernateUtil.getSession();
            String hql = "from OrgTree as a where a.id=:ID order by a.orgcode desc";
            Query query = session.createQuery(hql);
            query.setString("ID", id);
            List<OrgTree> list =  query.list();

            if(list.size() >0 ) {
                model = list.get(0);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }
        return model;
    }


    public List<OrgTree> loadBySQL() {
        List<OrgTree> list = new ArrayList<OrgTree>();
        Session session = null;
        try {
            session = HibernateUtil.getSession();

            String sql = "select * from T_ORGTREE where PARENTID=:PARENTID or ORGNAME like :ORGNAME";
            SQLQuery query = session.createSQLQuery(sql);
            //注意数据类型 query.setInteger(); query.setDate();
            query.setString("PARENTID", "0000000000000000000000000000000000000000000000000000000000000000");
            query.setString("ORGNAME", "%123%");

            List array = query.list();
            //返回的是二维数组, 需要转换为对象
            for(int i=0; i< array.size(); i++){
                Object[] obj = (Object[]) array.get(i);

                OrgTree orgTree = new OrgTree();
                orgTree.setId(obj[0].toString());
                orgTree.setParentid(obj[1].toString());
                orgTree.setOrgcode(obj[2].toString());
                orgTree.setOrgname(obj[3].toString());
                list.add(orgTree);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }
        return list;
    }


    public List<OrgTree> loadAllOrgTree(String levercode) {
        List<OrgTree> list = new ArrayList<OrgTree>();
        Session session = null;
        try {
            session = HibernateUtil.getSession();

            String hql = "from OrgTree as a where levercode like :levercode order by a.levercode";
            Query query = session.createQuery(hql);
            query.setString("levercode", levercode+"%");
            list =  query.list();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }
        return list;
    }

    public List<OrgTree> loadAsnycOrgTree(String parentid) {
        List<OrgTree> list = new ArrayList<OrgTree>();
        Session session = null;
        try {
            session = HibernateUtil.getSession();

            String hql = "from OrgTree as a where parentid = :parentid order by a.levercode";
            Query query = session.createQuery(hql);
            query.setString("parentid", parentid);
            list =  query.list();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }
        return list;
    }


    public OrgTree getOrgTreeByCode(String orgcode) {
        OrgTree model = null;
        Session session = null;
        try {
            session = HibernateUtil.getSession();
            String hql = "from OrgTree as a where a.orgcode=:ORGCODE order by a.orgcode desc";
            Query query = session.createQuery(hql);
            query.setString("ORGCODE", orgcode);
            List<OrgTree> list =  query.list();

            if(list.size() >0 ) {
                model = list.get(0);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }
        return model;
    }

    public boolean addOrgTree(OrgTree orgTree) {
        boolean result = false;
        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            String id = UUID.randomUUID().toString();
            orgTree.setId(id);
            session.save(orgTree);
            ts.commit();
            result = true;
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return result;
    }


    public boolean updateOrgTree(OrgTree orgTree) {
        boolean result = false;

        OrgTree model = getOrgTreeByID(orgTree.getId());

        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            // 根据不同的业务场景有多个update方法
            model.setOrgcode(orgTree.getOrgcode());
            model.setOrgname(orgTree.getOrgname());

            session.update(model);
            ts.commit();
            result = true;
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return result;
    }

    public boolean deleteOrgTree(String id) {
        boolean result = false;

        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            OrgTree model = (OrgTree) session.get(OrgTree.class, id);
            session.delete(model);
            ts.commit();
            result = true;
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return result;
    }

    public UserJSON getUser(String id) {
        UserJSON model = null;
        Session session = null;
        try {
            session = HibernateUtil.getSession();
            String hql = "from UserJSON as a where a.id=:ID";
            Query query = session.createQuery(hql);
            query.setString("ID", id);
            List<UserJSON> list =  query.list();

            if(list.size() >0 ) {
                model = list.get(0);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }
        return model;
    }

    public boolean addUser(UserJSON user) {
        boolean result = false;
        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            String id = UUID.randomUUID().toString();
            user.setId(id);
            //增加组织机构信息
            OrgTree org = getOrgTreeByCode(user.getOrgcode());
            user.setOrgTree(org);
            user.setCreatetime(new Date());

//            LobHelper lobHelper = session.getLobHelper();
//            Clob clob = lobHelper.createClob(user.getXmlDataString());
           // user.setXmlData(user.getXmlDataString());

            //user.setXmlData(user.getXmlDataString());
            session.save(user);


//            user.setXmlData(empty); //先保存一个空的clob
//            session.save(user);
//            session.flush();  //锁定这条记录
//            session.refresh(user, LockMode.UPGRADE_SKIPLOCKED);
//            oracle.sql.CLOB clob = (oracle.sql.CLOB) user.getXmlData();
//            java.io.Writer pw = clob.getCharacterOutputStream();
//            pw.write(user.getXmlDataString());//longText是一个长度超过255的字符串
//            pw.close();


            ts.commit();
            result = true;
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return result;
    }

    public boolean updateUser(UserJSON user) {
        boolean result = false;

        UserJSON model = getUser(user.getId());

        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            // 根据不同的业务场景有多个update方法
            model.setUsername(user.getUsername());
            model.setLoginname(user.getLoginname());
            model.setGender(user.getGender());
            model.setEmail(user.getEmail());
            model.setRolenames(user.getEmail());

            if(model.getOrgcode() != null &&
               !model.getOrgcode().equals(user.getOrgcode())){
                model.setOrgcode(user.getOrgcode());
                model.setOrgTree(getOrgTreeByCode(user.getOrgcode()));
            }

            session.update(model);
            ts.commit();
            result = true;
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return result;
    }

    public boolean deleteUser(String id) {
        boolean result = false;

        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            UserJSON model = (UserJSON) session.get(UserJSON.class, id);
            session.delete(model);
            ts.commit();
            result = true;
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return result;
    }


    public int updateUserGender(String id)
    {
        int result = 0;

        UserJSON model = getUser(id);

        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            if(model.getGender() ==0)
            {
                result=1;
                model.setGender(1);
            }
            else {
                result=0;
                model.setGender(0);
            }

            session.update(model);
            ts.commit();
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return result;
    }

    public static Map<String, Object> loadByPage(Pagination pagination) {
        String hql_count = "select count(*) from UserJSON [WHERE]";
        String hql_select = "from UserJSON [WHERE]";
        String where = "";
        HashMap<String, Object> param = new HashMap<String, Object>();

        try {
            //拼接 sql where 条件
            for (QueryParams query : pagination.getQuerys()) {
                if (query.getName().equals("username") && !StringUtils.isEmpty(query.getValue().toString())) {
                    where += "".equals(where) ? " username like :USERNAME " : " and username like :USERNAME";
                    param.put("USERNAME", "%" + query.getValue() + "%");
                }
                if (query.getName().equals("loginname") && !StringUtils.isEmpty(query.getValue().toString())) {
                    where += "".equals(where) ? " loginname like :LOGINNAME " : " and username like :LOGINNAME";
                    param.put("LOGINNAME", "%" + query.getValue() + "%");
                }
                if (query.getName().equals("gender") && !StringUtils.isEmpty(query.getValue().toString())) {
                    where += "".equals(where) ? " gender like :GENDER " : " and gender like :GENDER";
                    param.put("GENDER", Integer.parseInt(query.getValue().toString()));
                }
                if (query.getName().equals("email") && !StringUtils.isEmpty(query.getValue().toString())) {
                    where += "".equals(where) ? " email like :EMAIL " : " and email like :EMAIL";
                    param.put("EMAIL", "%" + query.getValue() + "%");
                }
                if (query.getName().equals("createDate0") && !StringUtils.isEmpty(query.getValue().toString())) {
                    where += "".equals(where) ? " createtime >= :CREATEDATE0 " : " and createtime >= :CREATEDATE0";
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    param.put("CREATEDATE0", sdf.parse(query.getValue().toString()));
                }
                if (query.getName().equals("createDate1") && !StringUtils.isEmpty(query.getValue().toString())) {
                    where += "".equals(where) ? " createtime <= :CREATEDATE1 " : " and createtime <= :CREATEDATE1";
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    param.put("CREATEDATE1", sdf.parse(query.getValue().toString()));
                }
            }
        }catch (Exception ex){
            logger.error(ex.toString());
            ex.printStackTrace();
        }

        if(where.length()>0){
            where = "where " + where;
            hql_count = hql_count.replace("[WHERE]", where);
            hql_select = hql_select.replace("[WHERE]", where);
        } else {
            hql_count = hql_count.replace("[WHERE]", "");
            hql_select = hql_select.replace("[WHERE]", "");
        }

        //拼接 sql 排序
        hql_select += " order by " + pagination.getSort() + " " + pagination.getOrder();

        Map<String, Object> map = BaseService.queryPageByHql(hql_count, hql_select, param, pagination);
        return map;
    }


    //已不使用, 原始分页写法
    private static Map<String, Object> loadByPage_bak(Pagination pagination) {
        Map<String, Object> map = new Hashtable<String, Object>(3);
        List<UserJSON> list = new ArrayList<UserJSON>();
        int totalCount = 0;
        Session session = null;

        try {
            session = HibernateUtil.getSession();

            String hql_count = "select count(*) from UserJSON [WHERE]";
            String hql_select = "from UserJSON [WHERE]";
            String where = "";

            HashMap<String, Object> param = new HashMap<String, Object>();

            //拼接 sql where 条件
            for(QueryParams query : pagination.getQuerys())
            {
                if(query.getName().equals("username") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    where += "".equals(where) ? " username like :USERNAME " : " and username like :USERNAME";
                }
                if(query.getName().equals("loginname") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    where += "".equals(where) ? " loginname like :LOGINNAME " : " and username like :LOGINNAME";
                }
                if(query.getName().equals("gender") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    where += "".equals(where) ? " gender like :GENDER " : " and gender like :GENDER";
                }
                if(query.getName().equals("email") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    where += "".equals(where) ? " email like :EMAIL " : " and email like :EMAIL";
                }
                if(query.getName().equals("createDate0") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    where += "".equals(where) ? " createtime >= :CREATEDATE0 " : " and createtime >= :CREATEDATE0";
                }
                if(query.getName().equals("createDate1") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    where += "".equals(where) ? " createtime <= :CREATEDATE1 " : " and createtime <= :CREATEDATE1";
                }
            }

            if(where.length()>0){
                where = "where " + where;
                hql_count = hql_count.replace("[WHERE]", where);
                hql_select = hql_select.replace("[WHERE]", where);
            } else {
                hql_count = hql_count.replace("[WHERE]", "");
                hql_select = hql_select.replace("[WHERE]", "");
            }

            //拼接 sql 排序
            hql_select += " order by " + pagination.getSort() + " " + pagination.getOrder();

            Query queryCount = session.createQuery(hql_count);
            Query querySelect = session.createQuery(hql_select);

            //为 where 条件中的参数赋值
            for(QueryParams query : pagination.getQuerys())
            {
                if(query.getName().equals("username") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    queryCount.setString("USERNAME", "%" + query.getValue() + "%");
                    querySelect.setString("USERNAME", "%" + query.getValue() + "%");
                }
                if(query.getName().equals("loginname") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    queryCount.setString("LOGINNAME", "%" + query.getValue() + "%");
                    querySelect.setString("LOGINNAME", "%" + query.getValue() + "%");
                }
                if(query.getName().equals("gender") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    queryCount.setString("GENDER", "%" + query.getValue() + "%");
                    querySelect.setString("GENDER", "%" + query.getValue() + "%");
                }
                if(query.getName().equals("email") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    queryCount.setString("EMAIL", "%" + query.getValue() + "%");
                    querySelect.setString("EMAIL", "%" + query.getValue() + "%");
                }
                if(query.getName().equals("createDate0") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    queryCount.setTimestamp("CREATEDATE0", DateTimeUtil.formatStringToDate(query.getValue().toString(),"yyyy-MM-dd"));
                    querySelect.setTimestamp("CREATEDATE0", DateTimeUtil.formatStringToDate(query.getValue().toString(),"yyyy-MM-dd"));
                }
                if(query.getName().equals("createDate1") && !StringUtils.isEmpty(query.getValue().toString()))
                {
                    queryCount.setTimestamp("CREATEDATE1",  DateTimeUtil.formatStringToDate(query.getValue().toString(),"yyyy-MM-dd"));
                    querySelect.setTimestamp("CREATEDATE1",  DateTimeUtil.formatStringToDate(query.getValue().toString(),"yyyy-MM-dd"));
                }
            }

            //计算总页数
            totalCount = pagination.getClientPageCount();
            //避免每次都查询总页数
            if (totalCount == 0)
            {
                totalCount = ((Number) queryCount.iterate().next()).intValue();
            }

            //获取分页处理
            querySelect.setFirstResult((pagination.getPage() - 1) * Constants.PAGE_ROW_COUNT);
            querySelect.setMaxResults(pagination.getRows());
            list = querySelect.list();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        map.put("total", totalCount);
        map.put("rows", list);
        map.put("QueryKey", pagination.getQueryKey());

        return map;
    }

    public boolean addClob(TClob model) {
        boolean result = false;
        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            String id = UUID.randomUUID().toString();
            model.setId(id);
            session.save(model);
            ts.commit();
            result = true;
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return result;
    }


    public TClob getClob(String id) {
        TClob model = null;
        Session session = null;
        try {
            session = HibernateUtil.getSession();
            String hql = "from TClob as a where a.id=:ID";
            Query query = session.createQuery(hql);
            query.setString("ID", id);
            List<TClob> list =  query.list();

            if(list.size() >0 ) {
                model = list.get(0);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }
        return model;
    }


    public boolean updateClob(TClob clob) {
        boolean result = false;

        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            session.update(clob);
            ts.commit();
            result = true;
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return result;
    }

    public int deleteClob(String id) {
        int count = 0;

        Session session = HibernateUtil.getSession();
        Transaction ts = session.beginTransaction();
        try {
            String sql ="delete from T_Clob";
            Query query = session.createSQLQuery(sql);
            count= query.executeUpdate();
            ts.commit();
        } catch (Exception ex) {
            ts.rollback();
            ex.printStackTrace();
        } finally {
            if (session != null)
                session.close();
        }

        return count;
    }



}
