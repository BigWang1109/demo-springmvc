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
                var jsonObj = $('#form-dialog').serializeArray();

                $.post('<%=path%>/demo/hibernate/clob',
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
<form id="form-dialog">
    <table class="table-layout">
        <tr>
            <td class="table-layout-title">
                <span class="required">ID</span>
            </td>
            <td>
                <input type="text" class="easyui-textbox" data-options="width:150,required:true" name="id" />
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">
                大字段CLOB
            </td>
            <td>
                <textarea name="dataXml" >


                </textarea>
            </td>
        </tr>
        <tr>
            <td class="table-layout-title">

            </td>
            <td>
                <input id="btnSubmit" type="button" value="提交">
            </td>
        </tr>
    </table>
</form>



</body>
</html>
