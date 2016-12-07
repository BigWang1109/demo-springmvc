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
            //初始化tree1
            $('#tree1').tree({
                url:'<%=path%>/demo/easyui/tree/loadByID',
                method:'get',
                checkbox:true,
                onSelect:function(node){
                    $('#lbSelectNode').html("id:"+node.id +
                            "<br/>text:" + node.text +
                            "<br/>attributes:" + node.attributes.levercode);
                },
                onLoadSuccess:function(node, data){
                    //默认展开到节点
                    var node = $('#tree1').tree('find', '402883a236ea3a110136f70689ce04eb');
                    if(node != null){
                        $('#tree1').tree('expandTo', node.target);
                        $('#tree1').tree('select', node.target);
                    }
                }
            });

            //初始化tree2
            initAsyncTree();
        });

        function getCheckNodes(){
            var nodes = $('#tree1').tree('getChecked');
            var checks="";
            for(i=0; i<nodes.length; i++){
                checks += nodes[i].text + ' - ' + nodes[i].id + '\r\n\r\n';
            }
            alert(checks);
        }


        function initAsyncTree(){
            $('#tree2').combotree({
                url:'<%=path%>/demo/easyui/tree/async?parentid=402881fa2c3e722b012c3e7b56a00005', //民航局 注意配置为常量使用
                method:'get',
                checkbox:true,
                width:'173',
                panelHeight: '300',
                panelWidth: '400',
                onSelect:function(node){
                    $('#lbSelectNode').html("id:"+node.id +
                            "<br/>text:" + node.text +
                            "<br/>attributes:" + node.attributes.levercode);
                },
                onBeforeExpand:function(node){


                }
            });
        }

    </script>
</head>
<body>

<div class="content padding-space" data-options="region:'center'">

    树

    <h1>js 一次性加载树</h1>
    <p>
        当前选择节点:
        <br/><br/>
        <span id="lbSelectNode"></span>
        <br/><br/>
        <a href="#" onclick="getCheckNodes()">获取check选中的节点</a>
    </p>
    <ul id="tree1"></ul>


    <br /><br />
    <h1>js 异步加载树</h1>
    <ul id="tree2"></ul>


    <br /><br />
    <h1>html属性配置 一次性加载树</h1>
    <ul id="tree3" name="ParentID" class="easyui-combotree"
        data-options="url:'<%=path%>/demo/easyui/tree/loadByParent',
                                method:'get',
                                width:'173',
                                multiple:true,
                                checkbox:true,
                                panelHeight: 'auto',
                                panelWidth: '240',
                                cascadeCheck: false
                                "></ul>





</div>


</body>
</html>
