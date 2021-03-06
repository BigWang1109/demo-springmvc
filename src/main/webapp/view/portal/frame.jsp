<%--
  Created by IntelliJ IDEA.
  User: wxx
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!-- Basic Page Needs
    ================================================== -->
    <meta charset="utf-8" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <meta name="description" content="Font Awesome, the iconic font and CSS framework">
    <meta name="author" content="icss">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>泛海控股管理系统</title>

    <!-- CSS
    ================================================== -->
    <link href="<%=path%>/includes/jquery-easyui-1.4.4/themes/metro/easyui.css" rel="stylesheet" />
    <link href="<%=path%>/includes/jquery-easyui-1.4.4/themes/icon.css" rel="stylesheet" />
    <link href="<%=path%>/includes/font-awesome-4.5.0/css/font-awesome.css" rel="stylesheet" />
    <link href="<%=path%>/includes/jquery-mcustomscrollbar-3.1.3/jquery.mCustomScrollbar.css" rel="stylesheet" />
    <link href="<%=path%>/includes/styles/frame-r1.css" rel="stylesheet" />
    <link href="<%=path%>/includes/styles/base.css" rel="stylesheet" />

    <script src="<%=path%>/includes/jquery/jquery-1.11.3.min.js"></script>
    <script src="<%=path%>/includes/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <script src="<%=path%>/includes/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <script src="<%=path%>/includes/jquery-mcustomscrollbar-3.1.3/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="<%=path%>/includes/jquery/jquery-cookie.1.4.1.js"></script>
    <script src="<%=path%>/includes/jquery/jquery-json.2.4.js"></script>
    <script src="<%=path%>/includes/jquery/script.js?t=160412"></script>
    <script src="<%=path%>/includes/jquery/menu.js?t=160412"></script>

    <script>
        var userid = 'wxx';

        $(function () {
            //初始化左侧导航区滚动条
            $("#sidebar").mCustomScrollbar();

            //初始化子系统
            var systemHtml = "";
            var firstParentId = "";
            for (var i = 0; i < menu.length; i++) {
                if (menu[i].parentId != '') continue;
                systemHtml += '<li data-sysid="' + menu[i].id + '">' + menu[i].text + '</li>';
                if (firstParentId == "") firstParentId = menu[i].id;
            }
            $('#system-list').html('<ul>' + systemHtml + '</ul>');

            var cookieParentId = $.cookie(userid + '_system_id');
            if ('undefined' === typeof cookieParentId) {
                //初始化默认第一个子系统左侧菜单
                initMenu(firstParentId);
            }
            else {
                //初始化默认上次选中菜单
                initMenu(cookieParentId);
            }

            //弹出切换子系统菜单
            $('#header-system-change').click(function (e) {
                var subsys = $(this);
                var subsysList = $('#system-list');

                var top = 30;
                var left = subsys.offset().left - (subsysList.css('width').replace('px', '') * 1.0) + (subsys.css('width').replace('px', '') * 1.0) + 20;
                subsysList.css('top', top + 'px');
                subsysList.css('left', left + 'px');

                if (subsys.hasClass('selected')) {
                    subsys.removeClass('selected');
                    subsysList.hide();
                }
                else {
                    subsys.addClass('selected');
                    subsysList.show();
                }
                hidePopMenu($(this).attr('id'));
                e.stopPropagation();
            })

            //切换子系统
            $('#system-list li').click(function () {
                var systemid = $(this).attr('data-sysid');
                initMenu(systemid);
                hidePopMenu('');
                $.cookie(userid + '_system_id', systemid, { expires: 7 });
            })

            //收缩展开左侧菜单
            $('#sidebar-button').click(function () {
                if ($('#sidebar').css('left') != '0px') {
                    //展开
                    expSidebar(this);
                }
                else {
                    //收缩
                    colSidebar(this);

                }
            }).mouseenter(function () {
                $(this).css('background-color', '#ddd');
                $(this).css('color', '#bbb');
            }).mouseleave(function () {
                $(this).css('background-color', '#f5f5f5');
                $(this).css('color', '#dfdfdf');
            })

            $('#header').click(function (e) {
                hidePopMenu('');
            });

            $('#content').mouseenter(function () {
                hidePopMenu('');
            })

            resizeLayout();
            $(window).resize(function () {
                setTimeout(function () {
                    resizeLayout();
                }, 500);
            });
        })

        function expSidebar(sender) {
            $('#sidebar').css('left', '0px');
            $('#content').css('left', '240px');
            $('#content').css('width', $(document).width() - 240);
            $(sender).css('left', '230px');
            $(sender).find('i').removeClass('fa-chevron-right');
            $(sender).find('i').addClass('fa-chevron-left');


        }

        function colSidebar(sender) {
            $('#sidebar').css('left', '-1000px');
            $('#content').css('left', '0px');
            $('#content').css('width', $(document).width() + 240);
            $(sender).css('left', '0px');
            $(sender).find('i').removeClass('fa-chevron-left');
            $(sender).find('i').addClass('fa-chevron-right');

            resizeLayout();
        }

        function hideSidebar() {
            var btn = $('#sidebar-button');
            if (!btn.is(":hidden")){
                btn.hide();
                colSidebar(btn);
            }
        }

        function showSidebar() {
            var btn = $('#sidebar-button');
            if (btn.is(":hidden")) {
                btn.show();
                expSidebar(btn);
            }
        }

        function resizeLayout() {
            var height = $(document).height() - $('#header').height();
            var width = $(document).width() - $('#sidebar').width();
            $('#sidebar').css('height', height + 'px');
            $('#content').css('height', height + 'px');
            $('#content').css('width', width + 'px');
            //$('#content').html('document.height:' + $(document).height());


            var height = $(document).height() - $('#header').height();
//            var width = $(document).width() - $('#sidebar').width();
            var width = window.screen.width;
            $('#sidebar').css('height', height + 'px');
            $('#content').css('height', height + 'px');

            //modify zhj
            if($('#sidebar-button').css('left')=='230px'){//左侧菜单导航展开
                width = width -240;
            }
            $('#content').css('width', width + 'px');
            //alert('content=='+width);

            //$('#content').html('document.height:' + $(document).height());
        }

        function hidePopMenu(sender) {
            if ('header-system-change' != sender) {
                $('#header-subsys').removeClass('selected');
                $('#system-list').hide();
            }
            if ('header-user' != sender) {
                $('#header-user').removeClass('selected');
                $('#user-info').hide();
            }
            if ('header-config' != sender) {
                //$('#header-subsys').removeClass('selected');
                //$('#subsys-list').hide();
            }
        }

        //初始菜单
        function initMenu(parentId) {
            //初始化top菜单
            var topHtml = "";
            var isFirst = true;
            for (var i = 0; i < menu.length; i++) {
                if (menu[i].id == parentId) {
                    $('#header-system-name').html(menu[i].text);
                }

                if (menu[i].parentId == parentId) {
                    if (isFirst) {
                        topHtml += '<li  class="selected" data-url="' + menu[i].url + '" data-sysid="' + menu[i].id + '" data-sysparentid="' + menu[i].parentId + '"><a href="javascript:void(0)" onclick="initNav(\'' + menu[i].id + '\')" >' + menu[i].text + '</a></li>';
                        if (menu[i].url != "") {
                            //直接打开页面
                            tomain(menu[i].url);
                            //隐藏左侧导航区域
                            hideSidebar();
                        }
                        else {
                            //初始化左侧菜单
                            initNav(menu[i].id);
                        }
                        isFirst = false;
                    }
                    else {
                        topHtml += '<li data-url="' + menu[i].url + '" data-sysid="' + menu[i].id + '" data-sysparentid="' + menu[i].parentId + '"><a href="javascript:void(0)" onclick="initNav(\'' + menu[i].id + '\')" >' + menu[i].text + '</a></li>';
                    }
                }
            }
            $('#menu-root').html(topHtml);
        }

        //初始化左侧导航
        function initNav(parentId) {
            var leftHtml = "";
            var isFirstRoot = true;
            var isFirstSub = true;
            var url = "";

            //处理选中样式
            $('#menu-root li').each(function () {
                $(this).removeClass('selected');
                if ($(this).attr('data-sysid') == parentId) {
                    $(this).addClass('selected');
                }
            })

            for (var i = 0; i < menu.length; i++) {
                if (menu[i].id == parentId) url = menu[i].url;

                if (menu[i].parentId == parentId) {
                    var subHtml = "";
                    for (var j = 0; j < menu.length; j++) {
                        if (menu[j].parentId == menu[i].id) {
                            if (isFirstSub) {
                                if (menu[j].url.length > 0) tomain(menu[j].url);
                                isFirstSub = false;
                                subHtml += '<li class="selected" data-url="' + menu[j].url + '" data-sysid="' + menu[j].id + '" data-sysparentid="' + menu[j].parentId + '" onclick="onNavClick(this)"><i class="fa fa-circle-thin"></i> ' + menu[j].text + '</li>';
                            }
                            else {
                                subHtml += '<li data-url="' + menu[j].url + '" data-sysid="' + menu[j].id + '" data-sysparentid="' + menu[j].parentId + '" onclick="onNavClick(this)"><i class="fa fa-circle-thin"></i> ' + menu[j].text + '</li>';
                            }
                        }
                    }

                    subHtml = '<ul class="nav-sub">' + subHtml + '</ul>';
                    leftHtml += '<li data-sysid="' + menu[i].id + '"><i class="fa fa-clone"></i> ' + menu[i].text + subHtml + '</li>';
                }
            }

            $('.nav-root').html(leftHtml);
            if (leftHtml.length > 0) {
                showSidebar();
            }
            else {
                hideSidebar();
                tomain(url);
            }
        }

        function onNavClick(sender) {
            $('.nav-sub li').each(function () {
                $(this).removeClass('selected');
            })
            $(sender).addClass('selected');

            tomain($(sender).attr('data-url'));
        }


        //打开一级页面
        function tomain(url) {
            $('#childFrame').hide();
            if (url.indexOf('?') == -1) {
                url = url + '?t=' + $.uuid();
            }
            else {
                url = url + '&t=' + $.uuid();
            }
            $('#mainFrame').attr('src', url);
            $('#mainFrame').show();

            $('#childFrame').attr('src', '');
        }

        //打开二级页面
        function tochild(url) {
            $('#mainFrame').hide();
            if (url.indexOf('?') == -1) {
                url = url + '?t=' + $.uuid();
            }
            else {
                url = url + '&t=' + $.uuid();
            }
            $('#childFrame').attr('src', url);
            $('#childFrame').show();
        }

        //返回一级页面
        function toback(url) {
            if (typeof (url) != 'undefined') {
                var src = $('#mainFrame').attr('src');
                if (src.indexOf(url) == -1) {
                    $('#mainFrame').attr('src', url);
                }
            }
            $('#mainFrame').show();
            $('#childFrame').hide();
            $('#childFrame').attr('src', '');

            setTimeout(function () {
                try {
                    $('#mainFrame')[0].contentWindow.reloadGrid();
                } catch (e) {

                }
            }, 800);
        }

    </script>
</head>
<body>
<div id="header">
    <img class="logo" src="<%=path%>/includes/images/logo.png" height="32">
    <h1>泛海控股管理系统<span>FLIGHT STANDARDS OVERSIGHT PROGRAM</span></h1>
    <a id="header-system-name" href="javascript:void(0)"> 使用困难报告系统 </a>
    <a id="header-system-change" href="javascript:void(0)" data-sysid="1">
        快速切换
    </a>
    <a href="javascript:void(0)">
        [注销]
    </a>
    <a id="header-user" href="javascript:void(0)">
        管理员，您好
    </a>
    <div id="menu-bg">
        <ul id="menu-root">
            <li><a href="javascript:void(0)">首页</a></li>
            <li class="selected"><a href="javascript:void(0)">使用困难</a></li>
            <li><a href="javascript:void(0)">使用月报</a></li>
            <li><a href="javascript:void(0)">变化信息</a></li>
        </ul>
    </div>
</div>

<div id="sidebar">
    <ul class="nav-root">
        <li data-sysid="1">
            <i class="fa fa-clone"></i> 初始报告
            <ul class="nav-sub">
                <li data-url=""><i class="fa fa-circle-thin"></i> 近期使用困难报告</li>
                <li data-url=""><i class="fa fa-circle-thin"></i> 初始报告查询</li>
            </ul>
        </li>
        <li data-sysid="2" class="root-selected">
            <i class="fa fa-clone"></i> 调查报告
            <ul class="nav-sub">
                <li class="sub-selected" data-url="http://www.baidu.com"><i class="fa fa-circle-thin"></i> 调查报告签署</li>
                <li data-url="http://www.douban.com"><i class="fa fa-circle-thin"></i> 调查报告查询</li>
                <li data-url="http://www.zol.com.cn"><i class="fa fa-circle-thin"></i> 调查报告附件检索</li>
            </ul>
        </li>
        <li data-sysid="3">
            <i class="fa fa-clone"></i> 通航使用困难报告
            <ul class="nav-sub">
                <li data-url=""><i class="fa fa-circle-thin"></i> 使用困难报告签署</li>
                <li data-url=""><i class="fa fa-circle-thin"></i> 使用困难报告查询</li>
                <li data-url=""><i class="fa fa-circle-thin"></i> 使用困难报告管理</li>
            </ul>
        </li>
        <li data-sysid="4">
            <i class="fa fa-clone"></i> 移交单
            <ul class="nav-sub">
                <li data-url=""><i class="fa fa-circle-thin"></i> 移交单</li>
                <li data-url=""><i class="fa fa-circle-thin"></i> 移交单查询</li>
            </ul>
        </li>
        <li data-sysid="5">
            <i class="fa fa-clone"></i> 使用困难报告管理
            <ul class="nav-sub">
                <li data-url=""><i class="fa fa-circle-thin"></i> 初始报告管理</li>
                <li data-url=""><i class="fa fa-circle-thin"></i> 调查报告管理</li>
            </ul>
        </li>
    </ul>
</div>

<div id="sidebar-button">
    <i class="fa fa-chevron-left"></i>
</div>

<div id="content">
    <iframe id="mainFrame" name="mainFrame" width="100%" height="99%" frameborder="0" src=""></iframe>
    <iframe id="childFrame" name="mainFrame" width="100%" height="99%" frameborder="0" src="" style="display:none"></iframe>
</div>

<div id="system-list" style="display:none">
    <ul>
        <li data-sysid="1">审定监察子系统</li>
        <li data-sysid="2">运行规范子系统</li>
        <li data-sysid="3">电子规章子系统</li>
        <li data-sysid="4">使用困难报告子系统</li>
        <li data-sysid="5">体检合格证子系统</li>
        <li data-sysid="6">签派员委任代表子系统</li>
    </ul>
</div>
</body>
</html>
