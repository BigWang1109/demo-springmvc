package com.icss.demo.controller;

import com.icss.demo.common.Pagination;
import com.icss.demo.model.*;
import com.icss.demo.util.*;

import com.icss.demo.service.DemoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by chairui on 16-1-15.
 */
@RestController
public class DemoController {

    private static final Logger logger = LoggerFactory.getLogger(DemoController.class);

    /**
     * Simply selects the home view to render by returning its name.
     */
    @RequestMapping(value = "/demo/index", method = RequestMethod.GET)
    public ModelAndView index() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/index");

        return mv;
    }
    @RequestMapping(value = "/demo/messBoard" ,method = RequestMethod.GET)
    public ModelAndView messBoard(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("messBoard/messBoard");

        return mv;
    }

    @RequestMapping(value = "/demo/getstring", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String getString(Locale locale, Model model) {
        logger.info("The client locale is {}.", locale);

        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        String formattedDate = dateFormat.format(date);

        return "返回字符串，服务器时间：" + formattedDate;
    }

    @RequestMapping(value = "/demo/gethtml", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public void getHtml(Locale locale, HttpServletRequest request, HttpServletResponse response) {

        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        String formattedDate = dateFormat.format(date);

        StringBuilder sb = new StringBuilder();
        sb.append("<html");
        sb.append("<head><title>HttpServletResponse test</title></head>");
        sb.append(String.format("<body><h1>%1$s</h1><h2>%2$s</h2></body>", formattedDate, "判断中文输出是否乱码"));
        sb.append("</html>");

        response.setHeader("Content-type", "text/html;charset=utf-8");
        try {
            response.getOutputStream().write(sb.toString().getBytes());
            response.flushBuffer();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/demo/getjsonmodel/{id}", method = RequestMethod.GET)
    public UserJSON getJSONModel(@PathVariable("id") String id){
        System.out.println("id = " + id);
        logger.info("id = {}", id);

        UserJSON userJSON = new UserJSON();
        userJSON.setId(id);
        userJSON.setLoginname("admin");
        userJSON.setUsername("管理员");
        userJSON.setGender(1);
        return userJSON;
    }

    @RequestMapping(value = "/demo/getxmlmodel/{id}", method = RequestMethod.GET)
    public UserXML getXMLModel(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response){
        System.out.println("id = " + id);
        logger.info("id = {}", id);

        UserXML userXML = new UserXML();
        userXML.setId(id);
        userXML.setLoginname("admin");
        userXML.setUsername("管理员");
        userXML.setGender(1);
        return userXML;
    }

    @RequestMapping(value = "/demo/getmaplist/{id}", method = RequestMethod.GET)
    public Map<String, Object> getMapList(@PathVariable("id") String id){
        UserJSON userJSON = new UserJSON();
        userJSON.setId(id);
        userJSON.setLoginname("admin");
        userJSON.setUsername("管理员");
        userJSON.setGender(1);

        Map<String, Object> json = new Hashtable<String, Object>(2);
        json.put("result", true);
        json.put("message", "");
        json.put("data", userJSON);
        return json;
    }

    @RequestMapping(value = "/demo/springSubmit", method = RequestMethod.GET)
    public ModelAndView springSubmit() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/springSubmit");
        return mv;
    }

    @RequestMapping(value = "/demo/springSubmit1", method = RequestMethod.POST)
    public ModelAndView springSubmit1(UserJSON userJSON,
                                      String id, String username, String role,
                                      HttpServletRequest request, HttpServletResponse response) {
        //后台多种方式接收前台提交的数据
        String _id = request.getParameter("id");
        String _username = request.getParameter("username");
        String _gender = request.getParameter("gender");
        String[] _role = request.getParameterValues("role");

        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/springSubmit");
        return mv;
    }

    @RequestMapping(value = "/demo/springSubmit2", method = RequestMethod.POST)
    public ModelAndView springSubmit2(UserJSON userJSON) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("user", userJSON);
        mv.setViewName("demo/springSubmit");

        return mv;
    }

    @RequestMapping(value = "/demo/springSubmit3", method = RequestMethod.POST)
    public Map<String, Object> springSubmit3(UserJSON userJSON, String ext){
        logger.info("ext = {}", ext);

        Map<String, Object> json = new Hashtable<String, Object>(2);
        json.put("result", true);
        json.put("message", "返回成功");
        json.put("data", userJSON);
        return json;
    }

    @RequestMapping(value = "/demo/jstl2java", method = RequestMethod.GET)
    public ModelAndView jstl2java() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("jstlvalue", "这是jstl参数值内容");
        mv.setViewName("demo/jstl2java");

        return mv;
    }

    @RequestMapping(value = "/demo/jstl2grid", method = RequestMethod.GET)
    public ModelAndView jstl2grid() {
        ModelAndView mv = new ModelAndView();
        Date date = null;
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        try {
            date = format.parse("2016-01-07");

        } catch (ParseException e) {
            e.printStackTrace();
        }

        List<UserJSON> users = new ArrayList<UserJSON>();
        UserJSON userJSON = new UserJSON();
        userJSON.setId("0");
        userJSON.setLoginname("admin");
        userJSON.setUsername("管理员");
        userJSON.setGender(1);
        userJSON.setCreatetime(date);
        users.add(userJSON);

        UserJSON userJSON1 = new UserJSON();
        userJSON1.setId("1");
        userJSON1.setLoginname("test");
        userJSON1.setUsername("测试人员");
        userJSON1.setGender(0);
        userJSON1.setCreatetime(date);
        users.add(userJSON1);

        UserJSON userJSON2 = new UserJSON();
        userJSON2.setId("2");
        userJSON2.setLoginname("developer");
        userJSON2.setUsername("开发人员");
        userJSON2.setGender(1);
        userJSON2.setCreatetime(date);
        users.add(userJSON2);

        OrgTree orgTree = new OrgTree();
        orgTree.setId("root");
        orgTree.setParentid("");
        orgTree.setOrgcode("CAAC");
        orgTree.setOrgname("泛海控股");

        mv.addObject("value", "单值字符串");
        mv.addObject("orgtree", orgTree);
        mv.addObject("users", users);
        mv.setViewName("demo/jstl2grid");

        return mv;
    }


    @RequestMapping(value = "/demo/hibernate/base", method = RequestMethod.GET)
    public ModelAndView hibernateBase() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/hibernateBase");
        return mv;
    }

    @RequestMapping(value = "/demo/hibernate/base/add", method = RequestMethod.POST)
    public ModelAndView hibernateBaseAdd(OrgTree orgTree) {
        DemoService demoService = new DemoService();
        demoService.addOrgTree(orgTree);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/hibernateBase");
        return mv;
    }

    @RequestMapping(value = "/demo/hibernate/base/update", method = RequestMethod.POST)
    public ModelAndView hibernateBaseUpdate(OrgTree orgTree) {
        DemoService demoService = new DemoService();
        demoService.updateOrgTree(orgTree);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/hibernateBase");
        return mv;
    }

    @RequestMapping(value = "/demo/hibernate/base/delete", method = RequestMethod.POST)
    public ModelAndView hibernateBaseDelete(String id) {
        DemoService demoService = new DemoService();
        demoService.deleteOrgTree(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/hibernateBase");
        return mv;
    }


    @RequestMapping(value = "/demo/hibernate/select", method = RequestMethod.GET)
    public ModelAndView hibernateSelect(String id) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/hibernateSelect");
        return mv;
    }

    @RequestMapping(value = "/demo/hibernate/selectOne", method = RequestMethod.POST)
    public ModelAndView hibernateSelectOne(String id) {
        DemoService demoService = new DemoService();
        OrgTree model = demoService.getOrgTreeByID(id);
        ModelAndView mv = new ModelAndView();
        mv.addObject("orgtree", model);
        mv.addObject("orglist", null);
        mv.setViewName("demo/hibernateSelect");
        return mv;
    }

    @RequestMapping(value = "/demo/hibernate/selectHQL", method = RequestMethod.POST)
    public ModelAndView hibernateSelectHQL(String id) {
        DemoService demoService = new DemoService();
        OrgTree model = demoService.getByHQL(id);
        ModelAndView mv = new ModelAndView();
        mv.addObject("orgtree", model);
        mv.addObject("orglist", null);
        mv.setViewName("demo/hibernateSelect");
        return mv;
    }

    @RequestMapping(value = "/demo/hibernate/selectSQL", method = RequestMethod.POST)
    public ModelAndView hibernateSelectSQL() {
        DemoService demoService = new DemoService();
        List<OrgTree> list = demoService.loadBySQL();
        ModelAndView mv = new ModelAndView();
        mv.addObject("orgtree", null);
        mv.addObject("orglist", list);
        mv.setViewName("demo/hibernateSelect");
        return mv;
    }


    @RequestMapping(value = "/demo/hibernate/clob", method = RequestMethod.GET)
    public ModelAndView hibernateClob() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/hibernateClob");
        return mv;
    }

    @RequestMapping(value = "/demo/hibernate/clob", method = RequestMethod.POST)
    public Map<String, Object>  hibernateClob(TClob clob) {
        DemoService demoService = new DemoService();

        TClob model = demoService.getClob(clob.getId());
        if(model == null){
            demoService.addClob(clob);
        }
        else{
            model.setDataXml(clob.getDataXml());
            demoService.updateClob(model);
        }

        //demoService.deleteClob("");

        Map<String, Object> json = new Hashtable<String, Object>(2);
        json.put("result", true);
        json.put("message", "返回成功");
        return json;
    }


    @RequestMapping(value = "/demo/easyui/grid", method = RequestMethod.GET)
    public ModelAndView easyuiGrid() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/easyuigrid");
        return mv;
    }

    @RequestMapping(value = "/demo/easyui/load", method = RequestMethod.POST)
    public Map<String, Object> easyuiGridLoad(Pagination pagination) {
        DemoService demoService = new DemoService();
        Map<String, Object> json = demoService.loadByPage(pagination);
        return json;
    }

    @RequestMapping(value = "/demo/user/edit", method = RequestMethod.GET)
    public ModelAndView userEdit(String id){
        DemoService demoService = new DemoService();
        UserJSON user = demoService.getUser(id);

        ModelAndView mv = new ModelAndView();
        mv.addObject("user", user);
        mv.setViewName("demo/userEdit");
        return mv;
    }

    @RequestMapping(value = "/demo/user/edit", method = RequestMethod.POST)
    public Map<String, Object> userEdit(UserJSON user){
        DemoService demoService = new DemoService();
        boolean result = false;
        if(StringUtils.isEmpty(user.getId())){
            result = demoService.addUser(user);
        }
        else{
            result = demoService.updateUser(user);
        }

        Map<String, Object> json = new Hashtable<String, Object>(2);
        json.put("result", result);
        json.put("message", "");
        return json;
    }

    @RequestMapping(value = "/demo/user/delete/{id}", method = RequestMethod.POST)
    public Map<String, Object> userDelete(@PathVariable("id") String id){

        DemoService demoService = new DemoService();
        demoService.deleteUser(id);

        Map<String, Object> json = new Hashtable<String, Object>(2);
        json.put("result", true);
        json.put("message", "");
        return json;
    }

    @RequestMapping(value = "/demo/user/genderswitch", method = RequestMethod.POST)
    public Map<String, Object> userGenderSwitch(UserJSON user){
        DemoService demoService = new DemoService();
        int gender = demoService.updateUserGender(user.getId());

        Map<String, Object> json = new Hashtable<String, Object>(1);
        json.put("gender", gender);
        return json;
    }

    @RequestMapping(value = "/demo/user/formValidate", method = RequestMethod.GET)
    public ModelAndView formValidate() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/formValidate");
        return mv;
    }

    @RequestMapping(value = "/demo/easyui/tree", method = RequestMethod.GET)
    public ModelAndView easyuiTree() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("demo/easyuitree");
        return mv;
    }

    //一次性加载树, 按照主键方式加载
    @RequestMapping(value = "/demo/easyui/tree/loadByID", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String treeLoadByID(){
        DemoService demoService = new DemoService();

        //获取组织机构数据
        //4028838636dd08c001377d6048561761 地区管理局 00010011
        List<OrgTree> list = demoService.loadAllOrgTree("00010011");

        String[] textColumns = {"orgcode","orgname"};
        String[] iconStyle = {};
        String[] attributes = {"levercode","state"};
        List<String> checkList = new ArrayList<String>();
        checkList.add("4028838633207e80013320a0f3b1001c");

        //按照 id 初始化, 所以 initRootID 有值 initParentID 无值
        String data = TreeUtil.toJSON(list, "id", "parentid", "4028838636dd08c001377d6048561761", "",
                "%1$s-[%2$s]",textColumns, iconStyle, attributes, checkList );

        return data;
    }


    //一次性加载树, 按照父id方式加载
    @RequestMapping(value = "/demo/easyui/tree/loadByParent", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String treeLoadByParent(){
        DemoService demoService = new DemoService();

        //获取组织机构数据
        //4028838636dd08c001377d6048561761 地区管理局 00010011
        List<OrgTree> list = demoService.loadAllOrgTree("00010011");

        String[] textColumns = {"orgcode","orgname"};
        String[] attributes = {"levercode","state"};
        List<String> checkList = new ArrayList<String>();

        //按照 parentid 初始化 , 所以 initRootID 无值 initParentID 有值
        String data = TreeUtil.toJSON(list, "id", "parentid", "", "402881fa2c954d54012c954d54530000",
                "%1$s-[%2$s]", textColumns, null, attributes, checkList );

        return data;
    }

    //一次加载一级树
    @RequestMapping(value = "/demo/easyui/tree/async", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String treeAsyncLoad(String parentid, String id){
        DemoService demoService = new DemoService();

        if(id != null) {
            //id 为每次加载下级节点 easyui 自动提交的参数
            parentid = id;
        }

        //获取组织机构数据
        List<OrgTree> list = demoService.loadAsnycOrgTree(parentid);

        String[] textColumns = {"orgcode","orgname"};
        String[] iconStyle = {"\"[state]\".indexOf('1') > -1 >>> icon-man"};
        String[] attributes = {"levercode","state"};
        List<String> checkList = new ArrayList<String>();
        checkList.add("4028838633207e80013320a0f3b1001c");

        //按照 parentid 初始化 , 所以 initRootID 无值 initParentID 有值
        String data = TreeUtil.asyncJSON(list, "id", "parentid", "", parentid,
                "%1$s-[%2$s]",textColumns, iconStyle, attributes, checkList );

        return data;
    }


    @RequestMapping(value = "/demo/properties/{key}", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String getProperties(@PathVariable("key") String key) {
        String value = PropertiesUtil.getProperty(key);
        return "配置文件参数：" + key + " 的值为：" + value;
    }
}