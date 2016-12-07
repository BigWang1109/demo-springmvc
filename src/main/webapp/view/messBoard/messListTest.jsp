<%--
  Created by IntelliJ IDEA.
  User: thinkpad
  Date: 2016/12/6
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
  String path = request.getContextPath();
%>
<html lang="zh-CN">
<head>
  <title> 留言板列表 </title>
  <jsp:include flush="true" page="/view/common/menuResource.jsp"></jsp:include>
  <jsp:include flush="true" page="/view/common/resource1.jsp"></jsp:include>
  <%--<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>--%>
  <!--Declare page as mobile friendly -->
  <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0"/>
  <!-- Declare page as iDevice WebApp friendly -->
  <meta name="apple-mobile-web-app-capable" content="yes"/>
  <style>
    .messTitle{
      padding: 10px;
      color: #666666;
      text-decoration: none;
      height: 20px;
      font-size: 20px;
    }
  </style>
  <script type="text/javascript">
    function del(){
      var str="";
//      $("input[name='checkbox']:checkbox").each(function(){
      $("input:checkbox[name='checkbox']:checked").each(function(i){
        if(0==i){
          str = $(this).val();
        }else{
          str += (","+$(this).val());
        }
      });
        if(str == '' || str == null){
            alert('请先选择要删除的留言')
        }else{
            $.ajax({
                url : '<%=path%>/mb/del',
                data :{'ids':str},
                type : 'post',
                success : function(v){
                    if(v == "success"){
//            $('#grid').datagrid('reload');
                        window.location.reload();
                        alert('删除成功');
                    }else{
                        alert('删除失败');
                    }

                }
            })
        }
    }
  </script>
</head>
<body>
<table style="width: 100%">
<div>
  <c:forEach var="message" items="${messList}">
    <tr>
      <td><input type="checkbox" value="${message.messageId}" name="checkbox"></td>
      <td><a class="messTitle" href="<%=path%>/mb/enter/${message.messageId}">${message.content}</a></td>
    </tr>
    <tr><td></td><td><DIV style="BORDER-TOP: #00686b 1px dashed; OVERFLOW: hidden; HEIGHT: 1px"></DIV></td></tr>
  </c:forEach>
</div>
</table>
<div data-role="widget" data-widget="nav4" class="nav4">
  <nav>
    <div id="nav4_ul" class="nav_4">
      <ul class="box">
        <li>
          <a href="<%=path%>/mb/enter/'-1'" class=""><span>新增</span></a>
        </li>
        <li>
          <a href="javascript:;" class="" onclick="del()"><span>删除</span></a>
        </li>
      </ul>
    </div>
  </nav>
</div>
</body>
</html>

