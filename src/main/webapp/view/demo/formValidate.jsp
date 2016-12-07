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
<form id="form-dialog">
    <input type="hidden" name="id" value="${user.id}"/>
    <div class="info">
        扩展了easyui的验证函数, 具体扩展方法在 includes\jquery\script.js
        必须引用该js资源
    </div>
    <table class="table-layout">
        <tr>
            <td class="table-layout-title">
                <span class="required">用户名(字符长度范围验证[2,5])</span>
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150,required:true,validType:'length[2,5]'" name="username" value="${user.username}" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                <span class="required">登录名(字符最小长度验证[2])</span>
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150,required:true,validType:'minLength[2]'" name="loginname" value="${user.loginname}" />
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
                电子邮件(邮件格式验证, 多个验证条件叠加)
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150,validType:['email','length[0,10]']" name="email" value="${user.email}" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                数值类型验证
            </td>
            <td>
                <input class="easyui-numberbox" data-options="width:150,required:true,min:10,max:90,precision:2" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                日期1
            </td>
            <td>
                <input id="datebox1" class="easyui-datebox" data-options="width:150,required:true" editable="false" />
            </td>
        </tr>

        <tr>
            <td class="table-layout-title">
                日期(必须大于日期1)
            </td>
            <td>
                <input class="easyui-datebox" data-options="width:150,required:true, validType:'maxThan[\'#datebox1\']'" editable="false" invalidMessage="时间必须大于日期1" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                自定义提示消息
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150,required:true,validType:'minLength[2]'" missingMessage="xxx必填, 至少输入 2 个字符" invalidMessage="出错了" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                密码
            </td>
            <td>
                <input id="password1" type="password" class="easyui-textbox" data-options="width:150,required:true" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                验证密码(两次是否相等)
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150,validType:'equals[\'#password1\']'" invalidMessage="两次输入的密码不一致, 请重新输入" />
            </td>
        </tr>

    </table>
</form>



</body>
</html>
