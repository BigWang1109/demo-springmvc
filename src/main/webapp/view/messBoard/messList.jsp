<%--
  Created by IntelliJ IDEA.
  User: thinkpad
  Date: 2016/12/5
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
  String path = request.getContextPath();
%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <%--<meta charset="UTF-8">--%>
  <!--Declare page as mobile friendly -->
  <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0"/>
  <!-- Declare page as iDevice WebApp friendly -->
  <meta name="apple-mobile-web-app-capable" content="yes"/>
    <title>留言板列表</title>
  <jsp:include flush="true" page="/view/common/resource1.jsp"></jsp:include>
  <style>
    .add {
      width:100%;
      height:45px;
      margin:0 auto;
      /*background:lightyellow;*/
      position:fixed;
      bottom:0;
      text-align:left;
      font-size: 20px;
      padding: 10px;
    }
    .del {
      width:100%;
      height:30px;
      margin:0 auto;
      /*background:#929ba2;*/
      position:fixed;
      bottom:10px;
      text-align:right;
    }
    .addbutton{
      bottom: 0px;
      font-size: 20px;
      font-weight:bold;
      color: #e6b650;
      text-decoration: none;
      /*padding:10px;*/
    }
    .messTitle{
      padding: 10px;
      color: #666666;
      text-decoration: none;
      height: 20px;
      font-size: 20px;
    }
  </style>
</head>
<body>
<table >
<c:forEach var="message" items="${messList}">
  <tr>
      <td><div class="box"><input type="checkbox"></div></td>
      <td><a class="messTitle" href="<%=path%>/mb/enter/${message.messageId}">${message.content}</a><input type="hidden" value="${message.messageId}"></td>
  </tr>
  <%--<tr><DIV style="BORDER-TOP: #00686b 1px dashed; OVERFLOW: hidden; HEIGHT: 1px"></DIV></tr>--%>
</c:forEach>
</table>
<div class="content"></div>
<div class="add"><a href="<%=path%>/mb/enter/'-1'" class="addbutton">新增</a></div>
<%--<div class="del"><a href="http://www.baidu.com">删除</a></div>--%>
</body>
</html>
