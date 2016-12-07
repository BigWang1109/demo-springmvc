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
        Hibernate 查询测试
    </h1>
    <p>
        操作后通过断点跟踪确认执行结果
    </p>

    <h2>主键单条记录查询</h2>
    <form id="form1" method="post" action="<%=path%>/demo/hibernate/selectOne">
        <input type="text" name="id" value="1"><br>

        ParentID: ${orgtree.parentid}<br>

        OrgCode:${orgtree.orgcode}<br>

        OrgName:${orgtree.orgname}<br>

        <input type="submit" value="提交">
    </form>


    <h2>HQL查询</h2>
    <form id="form2" method="post" action="<%=path%>/demo/hibernate/selectHQL">
        <input type="text" name="id" value="1"><br>

        ParentID: ${orgtree.parentid}<br>

        OrgCode:${orgtree.orgcode}<br>

        OrgName:${orgtree.orgname}<br>

        <input type="submit" value="提交">
    </form>

    <h2>SQL查询测试</h2>
    <form id="form3" method="post" action="<%=path%>/demo/hibernate/selectSQL">
        <table>
            <thead>
            <tr>
                <th>id</th>
                <th>orgcode</th>
                <th>orgname</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="model" items="${orglist}">
                <tr>
                    <td>${model.id}</td>
                    <td>${model.orgcode}</td>
                    <td>${model.orgname}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <input type="submit" value="提交">
    </form>

</body>
</html>
