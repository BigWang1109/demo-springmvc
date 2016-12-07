<%--
  Created by IntelliJ IDEA.
  User: thinkpad
  Date: 2016/12/1
  Time: 10:23
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
  <meta charset="UTF-8">
  <%--<meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>--%>
  <title>工作内容录入</title>
  <jsp:include flush="true" page="/view/common/resource1.jsp"></jsp:include>
</head>
<body style="font-size: 12px;">
<script type="text/javascript">
    $(document).ready(function(){
        getRev();
        setRev();
    });

    function getRev(){
        var rev =  $(".rev").attr("value");
        if(rev != ''){
         $("#response_person").combobox({
                onLoadSuccess:function(){
                    $("#response_person").combobox('select',rev);
                }
            })
        }

    };
    function setRev(){
        $(".rev").attr("value",'');
    };
</script>
<div align="center" style="height: 90%;width: 90%">
  <form id="form-add" class="easyui-form" method="post" data-options="novalidate:true">
    <table style="width: 99%;height: 98%"  align="center" class="table-input">
      <input type = "hidden" value = "${task.taskId}" name = "taskId"/>
        <input type="hidden" name="rev" class="rev" value="${task.responsePerson}"/>
        <c:if test="${flag eq '0' || flag eq '2'}">
      <tr>
        <td style="height: 35px;line-height: 35px;">
            责任人：
          <input class="easyui-combobox"
                 name="responsePerson"
                 id="response_person"
                 style="height:30px;"
                 data-options="
                    url:'<%=path%>/bd/initializeUser',
                    method:'post',
                    valueField:'USERID',
                    textField:'USERNAME',
                    editable : false,
                    multiple:false,
                    panelHeight:'auto',
                    required:true
                ">
        </td>
      </tr>
        </c:if>
        <c:if test="${flag eq '1' || flag eq '2'}">
      <tr>
        <td>
          <input class="easyui-textbox" name="taskContent"  data-options="multiline:true,required:true,validType: 'length[1,2000]'" value="${task.taskContent}" style="width:280px;height:270px">
        </td>
      </tr>
        </c:if>
      <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
    </table>
  </form>
</div>
</body>
</html>
