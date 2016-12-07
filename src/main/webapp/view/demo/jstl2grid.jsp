<%--
  Created by IntelliJ IDEA.
  User: wxx
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>Title</title>
</head>
<body>
    <p>
    注意: jstl 格式化日期
    </p>
    <h1>${orgtree.orgcode} - ${orgtree.orgname} - ${value}</h1>

    <table>
        <thead>
        <tr>
            <th>用户id</th>
            <th>性别</th>
            <th>登录名</th>
            <th>用户名</th>
            <th>创建时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td><c:if test="${user.gender=='0'}">女</c:if> <c:if test="${model.STATE=='1'}">男</c:if></td>
                <td>${user.loginname}</td>
                <td>${user.username}</td>
                <td><fmt:formatDate value="${user.createtime }" type="date"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</body>
</html>
