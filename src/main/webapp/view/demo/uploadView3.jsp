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
    <h1>
        文件上传
    </h1>
    <p>
        需要引用 uploader 静态资源 webapp/includes/fine-uploader-5.3.1 <br/>
        使用了 T_UPLOADFILE 表和 UploadFile 对象 <br/>
        上传文件保存路径需要修改配置文件 globals.properties <br/>
        pom.xml 需要增加 file upload 相关jar包 <br/><br/>

        上传组件具体实现的js代码需要配置下面参数<br/>
        foreignid: 业务表主键<br/>
        category: 扩展参数,业务数据分类
    </p>
<form id="form-dialog">
    <input type="hidden" name="foreignid" value="${foreignid}"/>


    <table class="table-layout">
        <tr>
            <td class="table-layout-title">
                原生上传附件
            </td>
            <td>
                <div id="fine-uploader"></div>


                <script type="text/template" id="qq-template">
                    <div class="qq-uploader-selector qq-uploader" qq-drop-area-text="拖动文件到此区域上传">
                        <div class="qq-total-progress-bar-container-selector qq-total-progress-bar-container">
                            <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-total-progress-bar-selector qq-progress-bar qq-total-progress-bar"></div>
                        </div>
                        <div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
                            <span class="qq-upload-drop-area-text-selector"></span>
                        </div>
                        <div class="qq-upload-button-selector qq-upload-button">
                            <div>浏览上传</div>
                        </div>
                        <span class="qq-drop-processing-selector qq-drop-processing">
                            <span>处理拖动文件...</span>
                            <span class="qq-drop-processing-spinner-selector qq-drop-processing-spinner"></span>
                        </span>
                        <ul class="qq-upload-list-selector qq-upload-list" aria-live="polite" aria-relevant="additions removals" style="display:none">
                            <li>
                                <div class="qq-progress-bar-container-selector">
                                    <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-progress-bar-selector qq-progress-bar"></div>
                                </div>
                                <span class="qq-upload-spinner-selector qq-upload-spinner"></span>
                                <img class="qq-thumbnail-selector" qq-max-size="100" qq-server-scale>
                                <span class="qq-upload-file-selector qq-upload-file"></span>
                                <span class="qq-edit-filename-icon-selector qq-edit-filename-icon" aria-label="Edit filename"></span>
                                <input class="qq-edit-filename-selector qq-edit-filename" tabindex="0" type="text">
                                <span class="qq-upload-size-selector qq-upload-size"></span>
                                <button type="button" class="qq-btn qq-upload-cancel-selector qq-upload-cancel">取消</button>
                                <button type="button" class="qq-btn qq-upload-retry-selector qq-upload-retry">重试</button>
                                <button type="button" class="qq-btn qq-upload-delete-selector qq-upload-delete">删除</button>
                                <span role="status" class="qq-upload-status-text-selector qq-upload-status-text"></span>
                            </li>
                        </ul>

                        <dialog class="qq-alert-dialog-selector">
                            <div class="qq-dialog-message-selector"></div>
                            <div class="qq-dialog-buttons">
                                <button type="button" class="qq-cancel-button-selector">关闭</button>
                            </div>
                        </dialog>

                        <dialog class="qq-confirm-dialog-selector">
                            <div class="qq-dialog-message-selector"></div>
                            <div class="qq-dialog-buttons">
                                <button type="button" class="qq-cancel-button-selector">否</button>
                                <button type="button" class="qq-ok-button-selector">是</button>
                            </div>
                        </dialog>

                        <dialog class="qq-prompt-dialog-selector">
                            <div class="qq-dialog-message-selector"></div>
                            <input type="text">
                            <div class="qq-dialog-buttons">
                                <button type="button" class="qq-cancel-button-selector">取消</button>
                                <button type="button" class="qq-ok-button-selector">确定</button>
                            </div>
                        </dialog>
                    </div>
                </script>

                <ul id="upload-file-list" class="upload-file-list">
                <c:forEach var="file" items="${list}">
                    <li id="li_${file.fileId}">
                        <a href="<%=path%>/upload/download?fileID=${file.fileId}" target="_blank" class="filename">
                            <span>${file.fileName}${file.extension}</span>
                            <span class="print-hide">[${file.fileSize}]</span>
                        </a>
                        <a href="javascript:void(0)" onclick="deleteFile('${file.fileId}')">删除</a>
                    </li>
                </c:forEach>
                </ul>
            </td>

        </tr>
    </table>
</form>

    <script type="text/javascript">

        $(function () {

            var uploader = new qq.FineUploader({
                debug: true,
                template: "qq-template",
                element: document.getElementById('fine-uploader'),
                request: {
                    endpoint: '<%=path%>/upload/file',
                    params: {
                        'foreignId': '${foreignid}',
                        'category': '${category}'
                    },
                    paramsInBody: true
                },
                validation: {
                    //allowedExtensions: ['jpeg', 'jpg', 'gif', 'png'],
                    sizeLimit: 20480000 // 20M
                },
                deleteFile: {
                    enabled: true,
                    endpoint: '<%=path%>/upload/delete?qquuid=',
                    forceConfirm: true
                },
                retry: {
                    enableAuto: true
                },
                multiple: true,
                callbacks: {
                    onSubmit: function (id, fileName) {

                    },
                    onUpload: function (id, fileName) {

                    },
                    onComplete: function (id, fileName, data) {

                        if (data.errormsg != '') {
                            $('#uploader-detailimg').fineUploader('getItemByFileId', id).remove();
                            window.top.$.messager.alert('提示', data.errormsg);
                            return;
                        }

                        var html = "<li id=\"li_" + data.qquuid + "\">" +
                                    "   <a href=\"<%=path%>/upload/download?fileID=" + data.qquuid + "\" target=\"_blank\" class=\"filename\"><span>" + data.qqfilename + " [" + data.qqtotalfilesize + "]</span></a>" +
                                    "   <a href=\"javascript:void(0)\" onclick=\"deleteFile('" + data.qquuid + "')\">删除</a>" +
                                    "</li>";
                        $("#upload-file-list").append(html);
                    }
                }
            });
        });


        function deleteFile(qquuid) {
            window.top.$.messager.confirm('提示', '@ConfirmDelete', function (value) {
                if (value) {
                    $('#ul_' + qquuid).find('.qq-upload-spinner-selector').removeClass('qq-hide')

                    $.ajax({
                        url: '<%=path%>/upload/delete?fileid=' + qquuid,
                        type: 'POST',
                        success: function (data, status) {
                            if (data.result) {
                                $('#ul_' + qquuid).remove();
                            }
                        }
                    });
                }
            });
            return false;
        }

    </script>

</body>
</html>
