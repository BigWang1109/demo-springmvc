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

    <link href="<%=path%>/includes/fine-uploader-5.3.1/fine-uploader-gallery.min.css" rel="stylesheet" />
    <link href="<%=path%>/includes/fine-uploader-5.3.1/fine-uploader-new.min.css" rel="stylesheet" />
    <script src="<%=path%>/includes/fine-uploader-5.3.1/fine-uploader.5.3.1.min.js"></script>

    <script type="text/javascript">
        function openUploadFileWindow(){
            utils.openWindow('上传文件', 1, '<%=path%>/upload/window?foreignid=12345', function(){

                if(!window.top.$('#form-dialog').form('validate')) return;
                window.top.submit();
                _topWindow.dialog('close');
            })
        }
    </script>
</head>
<body>
    <h1>
        文件上传
    </h1>

    <form id="form-dialog">
        <input type="hidden" name="foreignid" value="${foreignid}"/>

        <a href="javascript:void(0)" onclick="openUploadFileWindow()" >打开上传组件窗口</a>
    </form>

</body>
</html>
