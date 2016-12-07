<%--
  Created by IntelliJ IDEA.
  User: wxx
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        组织机构数据维护
    </h1>
    <p>
        操作后通过plsql查询数据库确认执行结果
    </p>

    <h2>录入数据</h2>
    <form id="form1" method="post" action="<%=path%>/demo/hibernate/base/add">
        <input type="hidden" name="id" value="123">

        ParentID:<br>
        <input type="text" name="parentid" value=""><br>

        OrgCode:<br>
        <input type="text" name="orgcode" value=""><br>

        OrgName:<br>
        <input type="text" name="orgname" value=""><br>

        <input type="submit" value="提交">
    </form>


    <h2>根据主键修改</h2>
    <form id="form2" method="post" action="<%=path%>/demo/hibernate/base/update">
        ID:<br>
        <input type="text" name="id" value=""><br>

        OrgCode:<br>
        <input type="text" name="orgcode" value=""><br>

        OrgName:<br>
        <input type="text" name="orgname" value=""><br>

        <input type="submit" value="提交">
    </form>

    <h2>根据主键删除组织机构</h2>
    <form id="form3" method="post" action="<%=path%>/demo/hibernate/base/delete">
        ID:<br>
        <input type="text" name="id" value=""><br>

        <input type="submit" value="提交">
    </form>


</body>
</html>
