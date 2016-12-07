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
    <script type="text/javascript">
        $(function(){
            $('#btnSubmit').click(function(){
                var jsonObj = $('#form3').serializeArray();
                jsonObj.push({'name':'ext', 'value':'abc'});

                $.post('<%=path%>/demo/springSubmit3',
                        jsonObj,
                        function (data, status) {
                            if (status != 'success') {
                                window.top.$.messager.alert('提示', '提交失败，您的网速较慢请重新尝试提交。当前状态：' + data.status);
                                return;
                            }
                            if (!data.result) {
                                window.top.$.messager.alert('提示', '提交失败：' + data.message);
                                return;
                            }
                            else {
                                window.top.$.messager.alert('提示', data.message);
                            }
                        });

            });
        })
    </script>
</head>
<body>
    <h1>
        提交数据到后台
    </h1>

    <p>
        注意表单属性 name\id的区别, name 大小写敏感, 需要与实体或模型属性完全匹配<br/>
        后台可以通过实体或模型, 参数, HttpServletRequest 三种方式获取提交的数据<br/>
        注意: radio, checkbox<br/>
        后台 controller 断点查看具体效果
    </p>
    <h2>form submit 刷新页面, 未还原提交数据</h2>
    <form id="form1" method="post" action="<%=path%>/demo/springSubmit1">
        <input type="hidden" name="id" value="123">

        姓名:<br>
        <input type="text" name="username" value=""><br>

        组织机构代码:<br>
        <input type="text" name="orgcode" value=""><br>

        性别:<br/>
        <label><input type="radio" name="gender" value="0" checked="checked">女</label>
        <label><input type="radio" name="gender" value="1">男</label><br>

        角色:
        <br/>
        <label><input type="checkbox" name="rolenames" value="0">管理员</label>
        <label><input type="checkbox" name="rolenames" value="1">普通用户</label><br>

        创建时间:<br/>
        <input type="text" name="createtime" value="1990-01-02"><br>


        <input type="submit" value="提交">
    </form>


    <h2>form submit 刷新页面, 还原提交数据</h2>
    <form id="form2" method="post" action="<%=path%>/demo/springSubmit2">
        <input type="hidden" name="id" value="${user.id}">

        姓名:<br>
        <input type="text" name="username" value="${user.username}"><br>

        性别:<br/>
        <c:if test="${user.gender=='0' || user.gender == null}">
            <label><input type="radio" name="gender" value="0" checked="checked">女</label>
            <label><input type="radio" name="gender" value="1">男</label><br>
        </c:if>
        <c:if test="${user.gender=='1' && user.gender != null }">
            <label><input type="radio" name="gender" value="0">女</label>
            <label><input type="radio" name="gender" value="1" checked="checked">男</label><br>
        </c:if>

        角色:
        <br/>
        <c:choose>
            <c:when test="${fn:indexOf(user.rolenames,'0') > -1 }">
                <label><input type="checkbox" name="rolenames" value="0" checked="checked">管理员</label>
            </c:when>
            <c:otherwise>
                <label><input type="checkbox" name="rolenames" value="0">管理员</label>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${fn:indexOf(user.rolenames,'1') > -1 }">
                <label><input type="checkbox" name="rolenames" value="1" checked="checked">普通用户</label><br>
            </c:when>
            <c:otherwise>
                <label><input type="checkbox" name="rolenames" value="1">普通用户</label><br>
            </c:otherwise>
        </c:choose>


        创建时间:<br/>
        <input type="text" name="createtime" value="${user.createtime}"><br>

        <input type="submit" value="提交">
    </form>

    <h2>ajax submit 不会刷新页面</h2>
    <p>
    返回json数据结构, result\msg\data, 前两项必须
    </p>
    <form id="form3">
        <input type="hidden" name="id" value="123">

        姓名:<br>
        <input type="text" name="username" value="用户"><br>

        性别:<br/>
        <label><input type="radio" name="gender" value="0">女</label>
        <label><input type="radio" name="gender" value="1">男</label><br>

        角色:
        <br/>
        <label><input type="checkbox" name="gender" value="0">管理员</label>
        <label><input type="checkbox" name="gender" value="1">普通用户</label><br>

        创建时间:<br/>
        <input type="text" name="createtime" value="1990-01-02"><br>

        <input id="btnSubmit" type="button" value="提交">
    </form>

</body>
</html>
