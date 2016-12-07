<%--
  Created by IntelliJ IDEA.
  User: thinkpad
  Date: 2016/12/7
  Time: 9:30
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
  <jsp:include flush="true" page="/view/common/menuResource.jsp"></jsp:include>
  <jsp:include flush="true" page="/view/common/resource1.jsp"></jsp:include>
    <title>留言板</title>
  <!--Declare page as mobile friendly -->
  <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0"/>
  <!-- Declare page as iDevice WebApp friendly -->
  <meta name="apple-mobile-web-app-capable" content="yes"/>
</head>
<body>
<script type="text/javascript">
  function sub(){
    var jsonObj = $(window.top.document).find('#form-add').serializeArray();
    $.post('<%=path%>/mb/save',
            jsonObj,
            function (data) {
//              var dataObj=eval("("+data+")");//转换为json对象
//              if(dataObj.flag == "success") {
              if(data = true){
                //_topWindow.dialog('close');
//                $($(window.top.document).find("[name='uuid']")[0]).val(dataObj.uuid);
                alert("保存成功");
                window.location.href=document.referrer;
              }else{
                alert("保存失败");
              }
            });
  }
</script>
<style>
    .messContent{
      font-size: 20px;
      color: #666666;
    }
</style>
<div align="center" >
  <form id="form-add" class="easyui-form" method="post" data-options="novalidate:true">
    <table>
      <input type="hidden" name="messageId" value="${mess.messageId}" >
      <%--<textarea rows="30" cols="50" placeholder="请留言..." style="background-color: aliceblue"></textarea><br>--%>
      <%--<tr><input class="easyui-textbox" name="content"  data-options="multiline:true,required:true,validType: 'length[1,2000]'" value="${mess.content}" style="width:300px;height:500px"></tr>--%>
      <%--<tr><textarea rows="15" cols="50" name="content" style="width:300px;height:500px">${mess.content}</textarea>--%>
      <p></p>
      <tr><textarea  name="content" class = "messContent" style="width:360px;height:545px">${mess.content}</textarea>
        <br>
      <%--<tr><input type="submit" onclick="sub()"></tr>--%>
    </table>
  </form>
</div>
<div data-role="widget" data-widget="nav4" class="nav4">
  <nav>
    <div id="nav4_ul" class="nav_4">
      <ul class="box">
        <li>
          <a href="#" class=""  onclick="sub()"><span>保存</span></a>
        </li>
      </ul>
    </div>
  </nav>
</div>
</body>
</html>
