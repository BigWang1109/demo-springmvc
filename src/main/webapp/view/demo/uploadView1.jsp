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


</head>
<body>
    <script type="text/javascript">
        //js 代码写在这里, 用于弹出窗口调用
        $(function(){
            $('#btnSave').click(function(){
                //获取上传组件的文件id
                submit();
            })
        })


        function submit(){
            var ids = "";
            $('input[data-foreignid="${foreignid}"]').each(function(){
                ids += $(this).val();
            })

            var tem = ids.replace(new RegExp(/(,)/g), '\r\n');
            alert(tem);

            var jsonObj = [];
            jsonObj.push({"name": "foreignid", "value": ${foreignid}});
            jsonObj.push({"name": "ids", "value": ids});

            $.post('<%=path%>/upload/submit',
                    jsonObj,
                    function (data, status) {
                        if (status != 'success') {
                            window.top.$.messager.alert('提示', constant.FailedToSubmitOnNetwork + data.status);
                            return;
                        }
                        if (!data.result) {
                            window.top.$.messager.alert('提示', constant.FailedToSubmit + data.message);
                            return;
                        }

                        window.top.$.messager.alert('提示', '提交成功');
                        //刷新页面
                        window.location.reload();
                    });
        }

        function onUploadComplete(id, fileName, data){
            //当前文件 id 后面提交数据使用
            var id = data.qquuid;
            $("#img").attr('src', '<%=path%>/upload/download/' + data.qquuid);
        }
    </script>
    <h1>
        文件上传
    </h1>
    <p>
        需要引用 uploader 静态资源 webapp/includes/fine-uploader-5.3.1 <br/>
        使用了 T_UPLOADFILE 表和 UploadFile 对象 <br/>
        上传文件保存路径需要修改配置文件 globals.properties <br/>
        pom.xml 需要增加 file upload 相关jar包 <br/><br/>

    </p>
    <form id="form-dialog">
        <input type="hidden" name="foreignid" value="${foreignid}"/>

        <table class="table-layout">
            <tr>
                <td class="table-layout-title">
                    category = sfz <br />无扩展名限制<br/>一次可以上传多个文件
                </td>
                <td>
                    <jsp:include flush="true" page="/view/common/uploadfile.jsp">
                        <jsp:param name="foreignid" value="${foreignid}" />
                        <jsp:param name="category" value="sfz" />
                        <jsp:param name="multiple" value="true" />
                        <jsp:param name="allowedExtensions" value="" />
                        <jsp:param name="sizeLimit" value="12480000" />
                        <jsp:param name="list" value="${list}" />
                        <jsp:param name="onComplete" value="" />
                    </jsp:include>
                </td>
            </tr>
            <tr>
                <td class="table-layout-title">
                    category = doc <br />扩展名图片<br/>一次只可以上传一个文件
                </td>
                <td>
                    <jsp:include flush="true" page="/view/common/uploadfile.jsp">
                        <jsp:param name="foreignid" value="${foreignid}" />
                        <jsp:param name="category" value="doc" />
                        <jsp:param name="multiple" value="false" />
                        <jsp:param name="allowedExtensions" value="['jpeg', 'jpg', 'gif', 'png']" />
                        <jsp:param name="sizeLimit" value="12480000" />
                        <jsp:param name="list" value="${list}" />
                        <jsp:param name="onComplete" value="" />
                    </jsp:include>
                </td>
            </tr>
            <tr>
                <td class="table-layout-title">
                    category = doc <br />
                    扩展名图片<br/>
                    一次只可以上传一个文件<br/>
                    自定义上传完毕js事件 onComplete<br/>
                    图片文件的保存没有实现
                </td>
                <td>
                    <jsp:include flush="true" page="/view/common/uploadfile.jsp">
                        <jsp:param name="foreignid" value="${foreignid}" />
                        <jsp:param name="category" value="exe" />
                        <jsp:param name="multiple" value="false" />
                        <jsp:param name="allowedExtensions" value="['jpeg', 'jpg', 'gif', 'png']" />
                        <jsp:param name="sizeLimit" value="12480000" />
                        <jsp:param name="list" value="${list}" />
                        <jsp:param name="onComplete" value="onUploadComplete" />
                    </jsp:include>

                    <img id="img" src="" style="width:100px" />
                </td>
            </tr>
            <tr>
                <td class="table-layout-title">

                </td>
                <td>
                    <a href="javascript:void(0)" id="btnSave">保存(只有执行保存上传或删除的操作才生效, 保存操作需要根据业务情况集成)</a>
                </td>
            </tr>
        </table>
    </form>

</body>
</html>
