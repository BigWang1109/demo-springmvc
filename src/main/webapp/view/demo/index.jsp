<%--
  Created by IntelliJ IDEA.
  User: wxx
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include flush="true" page="/view/common/resource.jsp"></jsp:include>
</head>
<body>
    <h1>
        Spring 相关测试
    </h1>
    <a href="<%=path%>/demo/getstring" target="_blank">返回字符串</a><br>

    <a href="<%=path%>/demo/gethtml" target="_blank">返回HTML HttpServletResponse</a><br>


    <a href="<%=path%>/demo/getjsonmodel/123" target="_blank">返回单个对象序列化JSON,传入id参数123</a><br>

    <a href="<%=path%>/demo/getxmlmodel/123" target="_blank">返回单个对象序列化XML,传入id参数123 (无值的属性不输出)</a><br>

    <a href="<%=path%>/demo/getmaplist/123" target="_blank">返回复杂JSON对象(推荐)</a><br>

    <a href="<%=path%>/demo/springSubmit" target="_blank">提交数据到后台 JSTL标签示例</a><br>

    <a href="<%=path%>/demo/jstl2grid" target="_blank">JSTL多个对象数据返回前台处理</a><br>

    <a href="<%=path%>/demo/jstl2java" target="_blank">JSTL变量转换为JSP变量</a><br>

    <h1>
        Hibernate 相关测试
    </h1>
    <p>model 属性尽量用简单类型数据结构 VARCHAR2 INTEGER DATE<br>
       数据库新增表后新增model,注意修改resources/hibernate.cfg.xml
    </p>
    <a href="<%=path%>/demo/hibernate/base" target="_blank">数据新增\修改\删除测试</a><br>

    <a href="<%=path%>/demo/hibernate/select" target="_blank">主键单条记录查询\HQL查询\SQL查询测试</a><br>

    <a href="<%=path%>/demo/hibernate/clob" target="_blank">Clob 测试</a><br>


    4.1关联映射的一些定义<br>
    @OneToOne @ManyToOne @OneToMany @ManyToMany<br>
    单项\双向<br>
    多数据源配置<br>

    <h1>
        easyui 相关测试
    </h1>
    <a href="<%=path%>/demo/frame" target="_blank">frame 框架页</a><br>

    <a href="<%=path%>/demo/easyui/grid" target="_blank">grid 控件 分页 + 查询条件 + 表单验证</a><br>

    <a href="<%=path%>/demo/easyui/tree" target="_blank">tree, combtree 控件</a><br>

    <h1>
        读取配置文件测试
    </h1>
    <a href="<%=path%>/demo/properties/UPLOAD_FOLDER_ROOT" target="_blank">配置文件在 src/main/resources/globals.properties</a><br>

    <h1>
        fine uploader 相关测试
    </h1>
    <a href="<%=path%>/upload/view?jsp=uploadView1&foreignid=12345" target="_blank">封装后的上传组件</a><br>

    <a href="<%=path%>/upload/view?jsp=uploadView2&foreignid=12345" target="_blank">弹出窗口中使用上传组件</a><br>

    <a href="<%=path%>/upload/view?jsp=uploadView3&foreignid=12345" target="_blank">原生上传组件(参考,不推荐使用)</a><br>


    <h1>
        单点登录集成
    </h1>


    <h1>
        用户\组织机构\角色\权限测试
    </h1>


    <h1>
        前台js常用标签ID命名规则
    </h1>
    button btnSubmit<br>
    div    divParent<br>
    input[type=text]  tbUsername<br>
    input[type=radio] rbGender<br>
    input[type=checkbox] cbRole<br>
    input[type=hidden] hdRole<br>
    textarea tbMemo<br>
    select ddlCity<br>


</body>
</html>
