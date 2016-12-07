<%--
  Created by IntelliJ IDEA.
  User:wxx
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
<form id="form-dialog">
    <input type="hidden" name="id" value="${user.id}"/>
    <table class="table-layout">
        <tr>
            <td class="table-layout-title">
                <span class="required">用户名</span>
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150,required:true,validType:'length[2,5]'" name="username" value="${user.username}" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                <span class="required">登录名</span>
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150,required:true,validType:'minLength[2]'" name="loginname" value="${user.loginname}" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">性别</td>
            <td>
                <c:if test="${user.gender=='0' || user.gender == null}">
                    <label><input type="radio" name="gender" value="0" checked="checked">女</label>
                    <label><input type="radio" name="gender" value="1">男</label><br>
                </c:if>
                <c:if test="${user.gender=='1' && user.gender != null }">
                    <label><input type="radio" name="gender" value="0">女</label>
                    <label><input type="radio" name="gender" value="1" checked="checked">男</label><br>
                </c:if>
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                部门代码
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150" name="orgcode" value="${user.orgcode}" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                电子邮件
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150,validType:['email','length[0,10]']" name="email" value="${user.email}" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                角色
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150" name="rolenames" value="${user.rolenames}" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                大字段CLOB <br/>(使用 ojdbc6.jar , tomcat\lib 也要更新)
            </td>
            <td>
                <textarea name="xmlData" >${user.xmlData}</textarea>
            </td>
        </tr>
    </table>
</form>



</body>
</html>
