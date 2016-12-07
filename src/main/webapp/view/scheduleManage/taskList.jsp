<%--
  Created by IntelliJ IDEA.
  User: thinkpad
  Date: 2016/12/1
  Time: 10:20
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
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <%--<meta charset="UTF-8">--%>
  <meta charset="UTF-8" name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
  <title>泛海控股工作安排</title>
  <jsp:include flush="true" page="/view/common/resource1.jsp"></jsp:include>

    <style>
      .testcontent{
        /*padding: 10px;*/
        color: #666666;
        text-decoration: none;
        /*height: 20px;*/
        /*font-size: 20px;*/
      }
    </style>

  <script type="text/javascript">
    $(document).ready(function () {
      $('#grid').datagrid({
        striped: false,
        fitColumns: true,
        resizable: true,
        singleSelect: false,
        url: '<%=path%>/sm/scheduleManage/load',
        idField: 'taskId',
        sortName: 'modifyDate',
        sortOrder: 'asc',
        remoteSort: true,
        pagination: true,
        pageNumber: 1,
        pageSize: 10,
        pageList: [10, 20, 50, 100],
        nowrap: false,
        loadMsg: constant.Loading,
        columns: [[
          { field: 'taskId', hidden : true},
          { field: 'ck', checkbox: true},
          { field: 'index', title: '序号', width: '10%',
            formatter: function (value, row, index) {
              return index+1;
            },align:'center'
          },
          { field: 'taskContent', title: '工作内容', width: '30%' ,align:'left',
            formatter:function(value, row, index){
              return '<a href="#" class="testcontent" onclick="addTextInput(\''+ row.taskId + '\', 1)">'+value+'</a>';
            }
          },

//          {
//            field: 'modifyDate', title: '修改日期', width: '25%', sortable: true,
//            formatter: function (value, row, index) {
//              return utils.formatJsonDate(value);
//            },align:'center'
//          },
          { field: 'responsePerson', title: '责任人', align: 'center',width: '30%',
            formatter: function (value, row, index) {
                return '<a href="#" class="testcontent" onclick="addTextInput(\''+ row.taskId + '\', 0)">'+value+'</a>';
            }
          },
          {
            field: 'createDate', title: '添加日期', width: '30%', sortable: true,
            formatter: function (value, row, index) {
              return utils.formatJsonDate(value);
            },align:'center'
          }
        ]],
        onBeforeLoad: function (param) {

          attachParams(param);

        },
        onLoadSuccess: function (data) {
          var rowData = data.rows;
          $.each(rowData, function(index, row){
            if (row.LoginName == 'admin') {
              $("#grid").datagrid("checkRow", index);
              $("#grid").datagrid('getPanel').find("input[type='checkbox']")[index + 1].disabled = true;
            }
          });
        }
      });
      $(window).resize(function () {
        setTimeout(function () {
          $('#grid').datagrid('resize');
        }, 500);
      });
    });

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

    };

    function reloadGrid() {
      $('#grid').datagrid('reload');
      return false;
    };

    function addTextInput(uuid, flag){

      var _topWindow;
      _topWindow = window.top.$('#topWindow');
      if (_topWindow.length <= 0){
        _topWindow = window.top.$('<div id="topWindow"/>').appendTo(window.top.document.body);
      }
      var btn;
//      if(flag == 0){
//        btn =
//                [{
//                  text: '返回',
//                  handler: function () {
//                    _topWindow.dialog('close');
//                  }
//                }];
//      } else  if(flag == 1){
        btn = [
          {
            text: '提交',

            handler: function () {
              //提交时进行校验，保存时不校验
              window.top.$("#form-add").form('enableValidation').form('validate');
              if(!window.top.$('#form-add').form('validate')) return;
              var jsonObj = $(window.top.document).find('#form-add').serializeArray();
              $.post('<%=path%>/sm/scheduleManage/save',
                      jsonObj,
                      function (data) {
                        var dataObj=eval("("+data+")");//转换为json对象
                        if(dataObj.flag == "success") {
                          _topWindow.dialog('close');
                          alert("提交成功");
                        }else{
                          alert("提交失败");
                        }
                      });
            }
          },
          {
            text: '返回',
            handler: function () {
              _topWindow.dialog('close');
            }
          }];
//      }
      _topWindow.dialog({
        title: '工作录入',
        href: '<%=path%>/sm/addtask/'+uuid+'/'+flag+'' ,
        width: 300,
        height: 400,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        cache: false,
        modal: true,
        closed: false,
        onClose: function () {
          _topWindow.window('destroy');
          $('#grid').datagrid('reload');
        },
        buttons: btn
      });
    };

    function deleteTasks(){
      var ids = '';
      var rows = $('#grid').datagrid('getSelections');
      if(rows.length == 0){
        return;
      }
      for(var i=0; i<rows.length; i++){
        if(i==0){
          ids += rows[i].taskId;
        } else {
          ids += "," + rows[i].taskId;
        }
      }
      $.ajax({
        url : '<%=path%>/sm/scheduleManage/delete',
        data :{'ids':ids},
        type : 'post',
        success : function(v){
          if(v == "success"){
            $('#grid').datagrid('reload');
            alert('操作成功');
          }else{
            alert('操作失败');
          }

        }
      })
    };
  </script>
</head>
<body style="font-size: 12px;" class="body">

<div class="easyui-panel" title="工作安排" style="width: 100%;" data-options="region:'center'" >
  <form id = "form-search">
    <table class="table-search">
      <div style="padding-top: 5px;">
        <span >工作内容：</span>
        <input class="easyui-textbox" name="taskContent"  data-options="validType: 'length[1,2000]'">
        <br>
          <span >责任人：</span>&nbsp;&nbsp;&nbsp;
          <input class="easyui-combobox"
                 name="responsePerson"
                 data-options="
                    url:'<%=path%>/bd/initializeUser',
                    method:'post',
                    valueField:'USERID',
                    textField:'USERNAME',
                    value:0,
                    editable : false,
                    multiple:false,
                    panelHeight:'auto',
                    required:true
                ">
        <%--<br>--%>
        <%--<span >添加日期：</span>--%>
        <%--<input class="easyui-datebox"  name="enter_date_from">--%>
        <%--<br>--%>
        <%--<span >&nbsp;&nbsp;&nbsp;&nbsp;至：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
        <%--<input class="easyui-datebox"  name="enter_date_to"></span>--%>
        <span style="padding-left: 10px;">&nbsp;</span>
        <a class="easyui-linkbutton easyui-linkbutton-primary" href="javascript:void(0);" onclick="reloadGrid()">查询</a>
      </div>
    </table>
  </form>
  <div style="padding-top: 0px;padding-left: 6px;margin-bottom: 0px;padding-right:6px;">
    <table id="grid"></table>
  </div>
  <div style="text-align:center; padding-bottom:5px;">
    <a href="javascript:void(0)" style="margin-top: 5px;"align="center" class="easyui-linkbutton easyui-linkbutton-primary" onClick="addTextInput('-1',2)">添加工作</a>
      <a href="javascript:void(0)" style="margin-top: 5px;" class="easyui-linkbutton easyui-linkbutton-primary" onClick="deleteTasks()">批量删除</a>
  </div>
</div>

</body>
</html>

