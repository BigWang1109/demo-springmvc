<%--
  Created by IntelliJ IDEA.
  User: wxx
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="jstlvalue" value="${jstlvalue}" />
<%
    String javavalue = pageContext.getAttribute("jstlvalue").toString();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>Title</title>
</head>
<body>

    <h1><%=javavalue%></h1>

</body>
</html>
