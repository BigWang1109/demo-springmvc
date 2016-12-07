package com.icss.demo.service;

import com.fasterxml.jackson.databind.deser.Deserializers;
import com.icss.demo.common.BaseService;
import com.icss.demo.common.Constants;
import com.icss.demo.common.Pagination;
import com.icss.demo.common.QueryParams;
import com.icss.demo.model.OrgTree;
import com.icss.demo.model.TClob;
import com.icss.demo.model.UploadFile;
import com.icss.demo.model.UserJSON;
import com.icss.demo.util.DateTimeUtil;
import com.icss.demo.util.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;

/**
 * Created by wxx on 16-11-29.
 */
@Service
public class UploadFileService {

    /**
     * 查询某个业务分类文件的最大排序号码
     *
     * @param foreignid 业务对象的主键
     * @param category 分类参数
     * @return
     */
    public int getMaxOrderIndex(String foreignid, String category){

        HashMap<String, Object> param= new HashMap<String, Object>();
        param.put("foreignid", foreignid);

        String hql = "select count(*) from UploadFile where foreignid=:foreignid";
        if(category != null && category.length() >0){
            hql += " and category=:category";
            param.put("category", category);
        }

        int count = BaseService.getCountByHql(hql, param);
        count++;
        return count;
    }


    public void addFile(UploadFile uploadFile){
        BaseService.add(uploadFile);
    }

    /**
     * 标记删除某个文件记录
     *
     * @param fileid 主键
     * @return
     */
    public void markDeleteFile(String fileid){
        UploadFile uploadFile = (UploadFile)BaseService.get(UploadFile.class, fileid);
        uploadFile.setState(2);
        BaseService.update(uploadFile);
    }


    /**
     * 删除某个文件记录及物理文件
     *
     * @param fileid 主键
     * @return
     */
    public void deleteFile(String fileid){
        Object uploadFile = BaseService.get(UploadFile.class, fileid);
        BaseService.delete(uploadFile);
        //TODO:删除文件
    }

    /**
     * 根据某个业务主键 foreignid 查询所有有效状态的文件对象
     *
     * @param foreignid 业务主键
     * @return
     */
    public List<UploadFile> loadFiles(String foreignid, int state){
        String hql = "from UploadFile where state=:state and foreignid = :foreignid";
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("foreignid", foreignid);
        param.put("state", state);
        List<UploadFile> list = BaseService.queryByHql(hql, param);
        return list;
    }

    /**
     * 根据某个业务主键 foreignid 查询所有文件对象
     *
     * @param foreignid 业务主键
     * @return
     */
    public List<UploadFile> loadFiles(String foreignid){
        String hql = "from UploadFile where foreignid = :foreignid";
        HashMap<String, Object> param= new HashMap<String, Object>();
        param.put("foreignid", foreignid);
        List<UploadFile> list = BaseService.queryByHql(hql, param);
        return list;
    }

    /**
     * 根据某个业务主键 foreignid 查询所有文件对象
     *
     * @param fileid 业务主键
     * @return
     */
    public UploadFile getFile(String fileid){
        UploadFile file = (UploadFile)BaseService.get(UploadFile.class, fileid);
        return file;
    }

    /**
     * 批量更新文件对象状态
     *
     * @param files 文件对象
     * @return
     */
    public boolean updateFiles(List<UploadFile> files){
        Session session = null;
        Transaction ts = null;
        boolean result = false;
        try{
            session = HibernateUtil.getSession();
            ts = session.beginTransaction();
            for(UploadFile file :files){
                session.update(file);
            }
            ts.commit();
            result = true;
        }
        catch (Exception ex) {
            if(ts != null) {
                ts.rollback();
            }
            ex.printStackTrace();
        }
        finally {
            if(session != null) {
                session.close();
            }
        }
        return result;

    }
}
