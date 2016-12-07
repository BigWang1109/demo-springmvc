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
        $(function () {
            $('#grid').datagrid({
                nowrap: true,
                striped: false,
                fitColumns: true,
                resizable: true,
                singleSelect: false,
                url: '<%=path%>/demo/easyui/load',
                idField: 'id',
                sortName: 'createtime',
                sortOrder: 'asc',
                remoteSort: true,
                pagination: true,
                pageNumber: 1,
                pageSize: 10,
                pageList: [10, 20, 50, 100],
                loadMsg: constant.Loading,
                columns: [[
                    { field: 'ck', checkbox: true},
                    { field: 'index', title: '序号', width: '30',
                        formatter: function (value, row, index) {
                            return index+1;
                        }
                    },
                    { field: 'username', title: '用户名', width: '100', sortable: true },
                    { field: 'loginname', title: '登录名', width: '100', sortable: true },
                    {
                        field: 'gender', title: '性别', width: '50', sortable: true,
                        formatter: function (value, row, index) {

                            return utils.formatBoolean(value,'男','女')
                        }
                    },
                    { field: 'orgTree', title: '组织机构名称', width: '100', sortable: true,
                        formatter: function (value, row, index) {
                            if(value != null){
                                return value.orgname;
                            }
                            return '';
                        }
                    },
                    { field: 'orgcode', title: '组织机构代码', width: '100', sortable: true },
                    {
                        field: 'createtime', title: '创建时间', width: '100', sortable: true,
                        formatter: function (value, row, index) {
                            return utils.formatJsonDate(value);
                        }
                    },
                    { field: 'id', title: '操作', width: '100',
                        formatter: function (value, row, index) {
                            return '<a href="#" onclick="window.top.tochild(\'/jsp/oeas/demoDetail.html\')">修改</a> ' +
                                    '<a href="#" onclick="return userGenderSwitch(\'' + row.id + '\',' + index + ');">性别</a> ';
                        }
                    }
                ]],
                toolbar: [{
                    id: 'btnAdd',
                    text: '新增用户',
                    iconCls: 'icon-add',
                    handler: function () {
                        openNewWindow();
                    }
                },
                {
                    id: 'btnEdit',
                    text: '修改用户',
                    iconCls: 'icon-edit',
                    handler: function () {
                        var rows = $('#grid').datagrid('getSelections');
                        if (rows.length != 1) {
                            window.top.$.messager.alert('提示', constant.OnlyOneSelected);
                            return;
                        }
                        openUserWindow(rows[0].id);
                    }
                },
                {
                    id: 'btnFormValidate',
                    text: '表单验证测试',
                    iconCls: 'icon-edit',
                    handler: function () {
                        openformValidateWindow();
                    }
                },
                '-',
                {
                    id: 'btnDelete',
                    text: '删除用户',
                    iconCls: 'icon-remove',
                    handler: function () {
                        deleteRow();
                    }
                }],
                onBeforeLoad: function (param) {
                    attachParams(param);
                },
                onLoadSuccess: function (data) {

//                    var rowData = data.rows;
//                    $.each(rowData, function(index, row){
//                        if (row.LoginName == 'admin') {
//                            $("#grid").datagrid("checkRow", index);
//                            $("#grid").datagrid('getPanel').find("input[type='checkbox']")[index + 1].disabled = true;
//                        }
//                    });
                }
            });

            $(window).resize(function () {
                setTimeout(function () {
                    $('#grid').datagrid('resize');
                }, 500);
            });
        });

        //包装后的 弹出窗口条用实示例
        function openformValidateWindow(){
            //第二个参数决定窗口大小  0小 1中 2大 自定义尺寸  宽高: '300,200'
            utils.openWindow('表单验证示例', 1, '<%=path%>/demo/user/formValidate', function(){

                if(!window.top.$('#form-dialog').form('validate')) return;
                //验证通过后 post 提交数据, 处理业务
            })
        }


        //包装后的 弹出窗口条用实示例
        function openNewWindow(){

            //第二个参数决定窗口大小  0小 1中 2大 自定义尺寸  宽高: '300,200'
            utils.openWindow('用户信息管理', 1, '<%=path%>/demo/user/edit?id=', function(){

                if(!window.top.$('#form-dialog').form('validate')) return;

                var jsonObj = $(window.top.document).find('#form-dialog').serializeArray();
                $.post('<%=path%>/demo/user/edit',
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

                            $('#grid').datagrid('reload');
                            _topWindow.dialog('close');
                        });
            })
        }

        //原生easyui dialog 调用示例
        var _topWindow;
        function openUserWindow(id){
            _topWindow = window.top.$('#topWindow');
            if (_topWindow.length <= 0){
                _topWindow = window.top.$('<div id="topWindow"/>').appendTo(window.top.document.body);
            }

            //width:350 650 850  height:450
            _topWindow.dialog({
                title: '用户管理',
                href: '<%=path%>/demo/user/edit?id=' + id,
                width: 650,
                height: 450,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                cache: false,
                modal: true,
                closed: false,
                buttons: [{
                    text: '确定',
                    handler: function () {
                        if(!window.top.$('#form-dialog').form('validate')) return;

                        var jsonObj = $(window.top.document).find('#form-dialog').serializeArray();
                        $.post('<%=path%>/demo/user/edit',
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

                                    $('#grid').datagrid('reload');
                                    _topWindow.dialog('close');
                                });
                    }
                },
                    {
                        text: '取消',
                        handler: function () {
                            _topWindow.dialog('close');
                        }
                    }],
                onClose: function () {
                    _topWindow.window('destroy');
                }
            });
        }

        function deleteRow() {
            var array = [];
            var rows = $('#grid').datagrid('getSelections');
            if (rows.length != 1) {
                window.top.$.messager.alert('提示', constant.OnlyOneSelected);
                return;
            }

            for (var i = 0; i < rows.length; i++) {
                array.push(rows[i].id);
            }
            var ids = array.join(',');

            window.top.$.messager.confirm('提示', constant.ConfirmDelete, function (value) {
                if (value) {

                    $.post('<%=path%>/demo/user/delete/'+ ids,
                            null,
                            function (data, status) {
                                if (status != 'success') {
                                    window.top.$.messager.alert('提示', constant.OnlyOneSelected + status);
                                    return;
                                }
                                if (!data.result) {
                                    window.top.$.messager.alert('提示', constant.FailedToDelete + data.message);
                                    return;
                                }
                                $('#grid').datagrid('clearSelections');
                                $('#grid').datagrid('reload');
                            });
                }
            });
            return false;
        }

        function attachParams(param) {
            var jsonObj = $('#form-search').serializeArray();
            var PageCount = {};
            PageCount.name = 'PageCount';
            PageCount.value = $('#grid').datagrid('getPager').data('pagination').options.total;
            jsonObj.push(PageCount);

            var QueryKey = {};
            QueryKey.name = 'QueryKey';
            QueryKey.value = $('#grid').datagrid('getData').QueryKey;
            jsonObj.push(QueryKey);

            var jsonStr = $.toJSON(jsonObj);
            param.query = jsonStr;

        }

        function reloadGrid() {
            $('#grid').datagrid('reload');
            return false;
        }

        function advancedSearch(){
            $('.tr-adv').each(function () {
                if ($(this).css('display') == "none") {
                    $(this).show();
                }
                else {
                    $(this).hide();
                }
            });
        }

        function userGenderSwitch(id, index){
            $.post('<%=path%>/demo/user/genderswitch',
                    {id:id},
                    function(data){
                        $('#grid').datagrid('updateRow',{'index':index, 'row':{'gender': data.gender}});
                    });
        }
    </script>
</head>
<body>

<div class="content padding-space" data-options="region:'center'">
    <form id="form-search">
    <table class="table-search">
        <tr>
            <td class="table-search-title">
                组织机构
            </td>
            <td>
                <input type="text" id="OrgCode" />
                <script type="text/javascript">
                    $(function(){
                        $('#OrgCode').combotree({
                            method: 'get',
                            width: 120,
                            valueField: 'id',
                            textField: 'text'
                        });
                    });
                </script>
            </td>
            <td class="table-search-title">
                用户名
            </td>
            <td>
                <input name="username" type="text" class="easyui-textbox" data-options="width:120"/>
            </td>
            <td class="table-search-title">
                登录名
            </td>
            <td >
                <input name="loginname" type="text" class="easyui-textbox" data-options="width:120"/>
            </td>
            <td>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="reloadGrid()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onClick="advancedSearch()">高级查询</a>
            </td>
        </tr>
        <tr>
            <td class="table-search-title">
                性别
            </td>
            <td>
                <select id="gender" name="gender" class="easyui-combobox" data-options="width:120,panelHeight:'auto'">
                    <option value="">请选择</option>
                    <option value="1">男</option>
                    <option value="0">女</option>
                </select>
            </td>
            <td class="table-search-title">创建时间从到</td>
            <td>
                <input name="createDate0" type="text" editable="false" class="easyui-datebox" data-options="width:120"/>
            </td>
            <td class="table-search-title-center">到</td>
            <td>
                <input name="createDate1" type="text" editable="false" class="easyui-datebox" data-options="width:120"/>
            </td>
            <td></td>
        </tr>
        <tr class="tr-adv" style="display:none">
            <td class="table-search-title">邮件</td>
            <td>
                <input name="email" type="text" class="easyui-textbox" data-options="width:120"/>
            </td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
    </table>
    </form>
    <table id="grid"></table>
</div>


</body>
</html>
