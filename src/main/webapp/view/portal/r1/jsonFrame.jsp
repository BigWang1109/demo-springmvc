<%@ page pageEncoding="utf-8"%>
<%@ include file="/includes/roneHeader.jsp" %>
<%@ page import="com.icss.resourceone.common.logininfo.UserInfo" %>
<%@ page import="com.icss.resourceone.common.login.LoginConstants" %>
<%@ page import="com.icss.ro.framework.portal.contant.LayoutSkinConfig" %>
<%@page import="com.icss.resourceone.sso.LTPAToken"%>
<%@page import="com.icss.resourceone.configuration.system.SysConfigManager"%>
<%
    String imgPath = skinpath+"/rone/images/";
%>
<title><i18n:message key="resource.one.framework.v4.title" bundleRef="roneBundle"/></title>
<link rel="stylesheet" href="<%=extPath%>/yui-ext/css/ext2/css/ext-all.<%=cssCtrl%>">
<link rel="stylesheet" href="<%=skinpath%>/rone/style/frame.css">
<link REL="SHORTCUT ICON" type="image/x-icon" href="<c:out value='${path}'/>/skin/common/rone.ico">
<%@ include file="/includes/portalFrameHeader.jsp" %>
<script type="text/javascript" src="<c:out value='${path}'/>/includes/ext-min/ext-jsonframe.<%=jsCtrl%>"></script>
<script type="text/javascript" src="<c:out value='${path}'/>/includes/rone-ext/roneFrametab.<%=jsCtrl%>"></script>


<!-- 子系统切换 js 代码注入 by 柴瑞 2016-03-02 -->
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
%>
<script type="text/javascript" src="<c:out value='${path}'/>/portal/layout/standard/jquery-1.11.3.min.js"></script>
<script>

    var systemList = [{"name":"运行规范", "contextPath":"oeas"},
        {"name":"abcdddd", "contextPath":"oeas"},
        {"name":"1234444", "contextPath":"oeas"}
    ];

    ; (function () {
        var maskWindow = function () {
            this.show = function (autoHide) {

                _maskWindow = window.top.$('#maskWindow');
                if (_maskWindow.length <= 0) {
                    _maskWindow = window.top.$('<div id="maskWindow" style="position:absolute; top:0; left:0; z-index:999; width:100%; height:auto;  background-color:#151410;"/>').appendTo(window.top.document.body);
                }
                $("#maskWindow").height(document.body.scrollHeight);
                $("#maskWindow").width(document.body.scrollWidth);

                // fadeTo第一个参数为速度，第二个为透明度
                // 多重方式控制透明度，保证兼容性，但也带来修改麻烦的问题
                $("#maskWindow").fadeTo(200, 0.8);

            },
                    this.hide = function (div) {
                        $("#maskWindow").fadeOut(200);
                    }
        };
        window.maskWindow = maskWindow;
    })();
    var maskWindow = new maskWindow();

    $(function(){
        //替换子系统切换事件
        $('#systemitems div').each(function(){
            var temp = $(this).attr('onclick');
            var title = $(this).html();
            if( typeof(temp) != "undefined" ){
                temp = temp.replace("roneSwitch", "roneSwitchFix");
                temp = temp.replace(")", ",'"+title+"')");
                //$(this).attr('onclick', temp);
                //ifx ie7
                $(this).removeAttr('onclick');
                $(this).unbind('click').click(function(){
                    var id = $(this).attr('id');
                    id = id.replace("system_","");
                    roneSwitchFix('system', id, title);
                });
            }
        });

        $('#subsystemchoide').append("<iframe id='r1ghost' style='width:100; height:100; display:none'>");
        $(window.top.document.body).append("<div id='changeSubsystem' style='width:300px; height:30px; background-color:#fff; border: 1px solid #6593cf; color:#131d77; font-size:12px;  line-height:30px; text-align:center; margin-left:-150px; top:200; left:50%; z-index:1000; position:absolute; display:none'>正在切换子系统，请稍后...</>");

        autoOpenNewPortal();
    });

    function autoOpenNewPortal(){
        if(ronePortalJson.system.length >= 1){
            //默认子系统
            for(i=0; i< systemList.length; i++){
                if( ronePortalJson.system[0].name.indexOf(systemList[i].name) >-1) {
                    $('#changeSubsystem').css('display','block');
                    maskWindow.show(true);
                    window.top.location.href = '<%=basePath%>'+systemList[i].contextPath+'/portal/' + ronePortalJson.system[0].id;
                    //openNewPortal(systemList[i].contextPath, ronePortalJson.system[0].id);
                    break;
                }
            }
        }
    }

    function roneSwitchFix(tp, systemid, title){
        var isbreak = false;
        for(i=0; i< systemList.length; i++){
            //break;
            if( title.indexOf(systemList[i].name) >-1){
                isbreak = true;
                openNewPortal(systemList[i].contextPath, systemid);
            }
        }

        if(!isbreak){
            roneSwitch(tp, systemid);
        }
    }


    function openNewPortal(contextPath, systemid){
        $('#changeSubsystem').css('display','block');
        maskWindow.show(true);

        //模拟r1切换子系统
        $('#r1ghost').attr('src', '<%=basePath%>fsopr1/login?Way=login&entrymode=switch&sysId=' + systemid);
        var iframe = $('#r1ghost')[0];
        if (iframe.attachEvent){
            iframe.attachEvent("onload", function(){
                window.top.location.href = '<%=basePath%>'+contextPath+'/portal/' + systemid;
            });
        } else {
            iframe.onload = function(){
                window.top.location.href = '<%=basePath%>'+contextPath+'/portal/' + systemid;
            };
        }


        //模拟r1切换子系统
        <%--var jsonObj =[{"name":"Way", "value":"login"}];--%>
        <%--jsonObj.push({"name":"entrymode", "value":"switch"});--%>
        <%--jsonObj.push({"name":"sysId", "value":systemid});--%>
        <%--$.post('<%=basePath%>fsopr1/switch',--%>
        <%--jsonObj,--%>
        <%--function (data, status) {--%>
        <%--if (status != 'success') {--%>
        <%--alert('切换子系统操作失败，请重新尝试操作');--%>
        <%--return;--%>
        <%--}--%>

        <%--$('#r1ghost').attr('src', '<%=basePath%>fsopr1/login?Way=login&entrymode=switch&sysId=' + systemid);--%>
        <%--var iframe = $('#r1ghost')[0];--%>
        <%--if (iframe.attachEvent){--%>
        <%--iframe.attachEvent("onload", function(){--%>
        <%--window.top.location.href = '<%=basePath%>'+contextPath+'/portal/' + systemid;--%>
        <%--});--%>
        <%--} else {--%>
        <%--iframe.onload = function(){--%>
        <%--window.top.location.href = '<%=basePath%>'+contextPath+'/portal/' + systemid;--%>
        <%--};--%>
        <%--}--%>
        <%--});--%>
    }
</script>
<!-- 子系统切换 js 代码注入 by 柴瑞 2016-02-24 -->


<style type="text/css">
    body{
        min-width:780px !important;
        width: expression(document.body.clientWidth < 800 ? "785px" : "100%" );
    }
    .main{
        height:auto;
        width:100%;
        min-width:800px !important;
        width:expression(document.body.clientWidth < 800? "800px": "100%" );
    }
    #footFrame{
        min-width:800px !important;
        width:expression(document.body.clientWidth < 800? "800px": "100%" );
    }
    .personInfo-ul{
        float:left;
        background-color:#FFFFFF;
        border-right:1px solid #669FD2;
        border-bottom:1px solid #669FD2;
        height:100%;
        width:100%;
    }
    .personInfo-ul li{
        float:left;
        width:100%;
        color:#669FD2;
        line-height:20px;
        border-top:1px solid #669FD2;
        border-left:1px solid #669FD2;
    }
    .personInfo-ul span{
        float:left;
        color:#2870B2;
        width:80px;
        text-align:right;
        padding-right:10px;
        margin-right:5px;
        border-right:1px solid #669FD2;
    }
    .personInfo-ul .last-li{
        height:2000px;
        float:left;
        overflow:auto;
    }
    .remark{
        float:left;
        padding-right:10px;
        width:350 !important;
        width:80%;
        overflow:auto;
    }
    .x-panel-btns-ct{
        padding:0;
    }
    .toolbar .tool img {
        line-height: 22px;
        width:18px;
        height:17px;
        vertical-align:middle
    }
    .toolbar .tool a {
        cursor:pointer;
    }
    #loader-div{
        position:absolute;
        display:none;
        z-index:99999;
        padding:3px;
        background-color:#f4f4f4;
        border:1px solid #9FC7EB
    }
    .sysMenu .detail .curitem, .sysMenu .detail .item{
        overflow:hidden;
    }
</style>
</head>
<body onResize="rezise()" onUnload="closeBrowser(event)" >
<div id="main" class="main">
    <div id="header" class="frameheader" style="display:block;" onClick="showDownMenu(false)">
        <table border="0" width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td width="323">
                    <div id="logo" class="headerleft">
                        <img src="<%=com.icss.ro.framework.portal.util.PortalUtil.getCurrentLogoSrc()%>" id="logo_img">
                    </div>
                </td>
                <td>
                    <div id="operator" class="headerright">
                        <div id="toolbar" class="toolbar">
                            <div id="help" class="tool" onClick="showDownLetMenus(this)"><a><img src="<%=imgPath%>frame/help.gif">
                                <i18n:message key="portal.frame.toolbar.help"/></a></div>
                            <div id="tool" class="tool" onClick="showDownLetMenus(this)"><a><img src="<%=imgPath%>frame/toolset.gif">
                                <i18n:message key="portal.frame.toolbar.toolset"/></a></div>
                            <div id="tool_subsystem" onClick="switchSystem(true)" class="tool" style="display:none"><a><img src="<%=imgPath%>frame/switch.gif">
                                <i18n:message key="portal.frame.toolbar.subsystem"/></a></div>
                            <div id="pulish" class="tool" onClick="showWhoOnline(event)"><a><img src="<%=imgPath%>toolset/online-list.gif">
                                <i18n:message key="frame.toolset.online.list"/></a></div>
                            <div id="whoami" class="tool" >
                                <i18n:message key="portal.frame.toolbar.welcome"/>&nbsp;<%=userName%>&nbsp;<%=idType%>&nbsp;&nbsp;[<a href="javascript:doLogout('<c:out value='${path}'/>/logout')"><i18n:message key="portal.frame.toolbar.logout"/></a>]
                            </div>
                        </div>
                        <div id="channellist" class="channellist"></div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="mg-outer">
        <div class="mg-mask"></div>
        <div id="mg-left" class="scroller-left"></div>
        <div style="width:100%; position:relative">
            <div id="scroll-container" style=" width:90%;position:relative; float:left;">
                <div class="mg-inner" id="mg-scroller">
                    <div id="menugrouplist" class="menugrouplist" style="display:block"> </div>
                </div>
                <div style=" width:2%">
                    <div id="mg-right" class="scroller-right"></div>
                    <div id="mg-down" class="scroller-mg-down"></div>
                </div>
            </div>
            <div style="width:0%; position:relative; float:right;">
                <div id="hiddenheader" class="headericon"><img id="headerhidenicon" onClick="hidenHeader()" style="vertical-align:middle; cursor:pointer;" src="<%=skinpath%>/rone/images/frame/hide.gif" title="<i18n:message key='frame.hide.header.tooltip'/>"></div>
            </div>
        </div>
    </div>
    <div id="menu-scroller-outer">
        <div id="menu-left" class="scroller-menu-left"></div>
        <div class="menu-scroller-inner" id="menu-scroller">
            <div id="menulist" class="menulist">
            </div>
            <div id="welcomearea" class="welcome" style="color:#000066; position:absolute; top:0; width:90%; color:#8F5100; display:none;">
                <marquee scrollamount="1" behavior="alternate">
                    <i18n:message key="frame.welcome"><i18n:messageArg value="<%=appname%>"/><i18n:messageArg value="<%=request.getRemoteAddr()%>"/><i18n:messageArg value="<%=userName%>"/></i18n:message>
                </marquee>
            </div>
        </div>
        <div id="menu-right" class="scroller-menu-right"></div>
        <div id="menu-down" class="scroller-menu-down"></div>
    </div>
</div>
<div id="subsystemchoide" style="display:none; z-index:2; width:210px" class="sysMenu" onMouseOver="Config.canSwitchHidden=false;" onMouseOut="Config.canSwitchHidden=true">
    <a id="switchSystem-point" onBlur="if(Config.canSwitchHidden)switchSystem(false)" class="x-menu-focus" tabindex=-1 onClick="return -1"></a>
    <div class="systemTile">
        <div class="title"><i18n:message key="frame.switch.title"/></div>
        <img style="float:right;cursor:pointer" onClick="switchSystem(false)" src="<%=skinpath%>/rone/images/frame/sysClose.jpg" width="25" height="24" />
    </div>
    <div id="systemitems" class="detail">
    </div>
</div>
<div id="whereAmI" style="display:none; z-index:2; width:300px" class="r1msg">
    <div class="msgtitle" id="whereAmITitle">
        <div id="whereAmITitleTxt" class="title"><i18n:message key="frame.welcome"/></div>
        <img class="icon" onClick="r1message.display.close()" src="<%=skinpath%>/rone/images/frame/wclose.gif"/>
        <img id="whereamimg" class="icon" onClick="r1message.display.todisplay()" title="<i18n:message key="frame.message.icon"/>" src="<%=skinpath%>/rone/images/frame/minimize.gif"/>
    </div>
    <div id="whereAmIDetail" class="detail" style="padding:4px; display:block" title="<i18n:message key="frame.welcome"/>">
    </div>
</div>
<iframe name="footFrame" id="footFrame" frameborder="0" scrolling="no"
        src="<%=layoutpath%>/mainFrame.jsp" style="z-index:226; background:#FFFFFF;"></iframe>
<div id="loader-div" onClick="this.style.display='none'" style=""></div>
<div id="down-scoller"></div>
</body>
<script type="text/javascript" language="javascript">
    tabConfig.refreshOnActive = <%=tabRefresh%>;
    var masker=Ext.get("mg-outer");
    masker.mask("<i18n:message key='login.mask'/>");
</script>
<script type="text/javascript" src="<c:out value='${path}'/>/includes/common/i18n<c:out value='${lang}'/>.<%=jsCtrl%>"></script>
<script type="text/javascript" src="<c:out value='${path}'/>/includes/rone-ext/jsonFrame.<%=jsCtrl%>"></script>
<script type="text/javascript">
    <% String json = (String)request.getSession(true).getAttribute(LoginConstants.LOGINJSON); %>
    var ronePortalJson =<%=json%>;
    //菜单下拉
    function activeDownListMenu(){
        var mgid=CurrentMenu.mgid;
        var menugroup = getMenugroup(mgid);
        var menuList = getMenuOfGroup(menugroup);
        var menuArea = Ext.get("down-scoller");
        menuArea.dom.innerHTML="";
        for(var i=0; i< menuList.length;i++){
            var myfun="doShowDownMenuList('"+mgid+"','"+menuList[i].menuid+"')";
            var cls="menu";
            if(menuList[i].menuid==CurrentMenu.menuId){
                cls="cmenu";
            }
            var element = menuArea.createChild({tag:"div", id:"down_menu_"+menuList[i].menuid, cls:cls, onClick:myfun});
            element.insertHtml("afterBegin","<div class='menu-inner' style='font-size:"+tabConfig.fontSize+"' id='down_menu_inner_"+menuList[i].menuid+"'>"+menuList[i].name+"</div>"); 	//添加子div便于换肤 汤超 2008-6-18
            element.addClassOnOver("menu-over");//增加鼠标over样式，便于换 汤超 2008-6-18
            var menuEl = Ext.get("down_menu_inner_"+menuList[i].menuid);
            menuEl.addClassOnOver("menu-inner-over");//增加鼠标over样式，便于换 汤超 2008-6-18
        }
    }
    function activeMenu(mgid,mid,isHidden){
        var curList = Ext.get("menugrouplist").query(".cmenugroup");
        if(curList){
            for(var i=0; i<curList.length;i++){
                Ext.get(curList[i]).replaceClass("cmenugroup","menugroup");
            }
        }
        removeArea("menu");
        var el = Ext.get("welcomearea");
        if(el){
            el.remove();
        }
        document.getElementById("menu-scroller").scrollLeft=0;
        Ext.get("menugroup_"+mgid).replaceClass("menugroup","cmenugroup");
        var defaultMenu = null;
        var menugroup = getMenugroup(mgid);
        var menuList = getMenuOfGroup(menugroup);
        if(menuList == null || menuList.length ==0){
            hiddenMenus(true);
            return;
        }
        CurrentMenuInit(menugroup.id, menugroup.name);
        var menuArea = Ext.get("menulist");
        hiddenMenus(isHidden===true?true:false);
        var _width=Ext.get("menu-scroller").getWidth();
        for(var i=0; i< menuList.length;i++){
            if(i==0){
                defaultMenu = menuList[0];
            }
            var element = menuArea.createChild({tag:"div", id:"menu_"+menuList[i].menuid, cls:"menu", onClick:"showMainTab('"+mgid+"','"+menuList[i].menuid+"')"});
            element.insertHtml("afterBegin","<div class='menu-inner' style='font-size:"+tabConfig.fontSize+"' id='menu_inner_"+menuList[i].menuid+"'>"+menuList[i].name+"</div>");
            element.addClassOnOver("menu-over");
            var menuEl = Ext.get("menu_inner_"+menuList[i].menuid);
            menuEl.addClassOnOver("menu-inner-over");
            if(menuList[i].menuid==mid){
                CurrentMenuInit(menugroup.id, menugroup.name, menuList[i].menuid, menuList[i].id, menuList[i].name);
            }
        }
        menulast=Ext.get("menu_inner_"+menuList[menuList.length-1].menuid);
        if(mid){
            var temp = Ext.get("menu_"+mid);
            if(temp){
                temp.replaceClass("menu","cmenu");
                currentMenuid = "menu_"+mid;
            }
        }
        if((_width)<menulast.getRight()){
            if(Config.isSlide){
                document.getElementById("menu-right").style.display="block";
                document.getElementById("menu-right").style.visibility="visible";
                document.getElementById("menu-left").style.visibility="hidden";
                document.getElementById("menu-left").style.display="block";
            }
            if(Config.isDropDown){
                document.getElementById("menu-down").style.display="block";
                document.getElementById("menu-down").style.visibility="visible";
            }
        }else{
            document.getElementById("menu-left").style.display="none";
            document.getElementById("menu-right").style.display="none";
            document.getElementById("menu-down").style.display="none";
        }
        changeZindex(mgid);
        MenuAudit.doAudit(MG_TYPE);
    }
    var mglast;
    var appHomePage =null;
    function activeMenuGroup(appuuid,homepage,helpurl){
        Ext.get("mg-scroller").setWidth("100%");
        appHomePage = homepage;
        removeArea("menugroup");
        var app = getApplication(appuuid);
        var mgList = getMenugroupOfApp(app);
        var menugroup = Ext.get("menugrouplist");
        fmgArray=new Array();
        var _width=Ext.get("mg-scroller").getWidth();//菜单组容器的实际宽度
        var _lastRight=0;//显示出来的菜单组的最右边距离
        for(var i=0; i< mgList.length;i++){
            var openMG = "window.top.footFrame.left.setLeftByMG('"+mgList[i].leftshow+"','"+mgList[i].name+"','"+mgList[i].navurl+"');";
            var clickFun = "";
            var menus = getMenuOfGroup(mgList[i]);
            if(mgList[i].navurl!=null && mgList[i].navurl!=""){
                clickFun += openMG;
            }
            if(!(mgList[i].oaentry ==1 && menus.length==1) && mgList[i].src !=null && mgList[i].src !='' ){
                clickFun += "openMgTab('"+mgList[i].src+"','"+mgList[i].name+"','mg_"+mgList[i].id+"');";
            }
            if(menus.length==1 && mgList[i].oaentry ==1 ){
                clickFun += "showMainTab('"+mgList[i].id+"','"+menus[0].menuid+"',true);";
            }else{
                clickFun += "activeMenu('"+mgList[i].id+"')";
            }
            var child = {tag:"div", id:"menugroup_"+mgList[i].id,cls:"menugroup", onClick:clickFun};
            var element = menugroup.createChild(child);
            element.insertHtml("afterBegin","<div class='menugroup-inner' style='font-size:"+tabConfig.fontSize+"' id='menugroup_inner_"+mgList[i].id+"'>"+mgList[i].name+"</div>");	//添加子div便于换肤 汤超 2008-6-18
            element.addClassOnOver("menugroup-over");//增加鼠标over样式，便于换 汤超 2008-6-18
            Ext.get("menugroup_inner_"+mgList[i].id).addClassOnOver("menugroup-inner-over");//增加鼠标over样式，便于换 汤超 2008-6-18
            Ext.get("menugroup_"+mgList[i].id).applyStyles("z-index:"+(mgList.length-i)); //新加入，调整z轴方向的显示优先
            if(element.getRight()>Ext.get("mg-scroller").getRight()){
                //element.applyStyles("display:none");
            }else{
                _lastRight=element.getRight();
            }
        }
        if(_lastRight>500){//将下列的箭头和滚动箭头移动到最后一可显示的菜单处
            Ext.get("mg-down").setLeft(_lastRight+9);
            Ext.get("mg-right").setLeft(_lastRight);
            Ext.get("mg-scroller").setWidth(_lastRight);//隐藏下列和滚动箭头后面的菜单组
        }
        mglast=Ext.get("menugroup_inner_"+mgList[mgList.length-1].id);
        if((_width)<mglast.getRight()){
            if(Config.isSlide){
                document.getElementById("mg-right").style.display="block";
                document.getElementById("mg-right").style.visibility="visible";
                document.getElementById("mg-left").style.display="block";
                document.getElementById("mg-left").style.visibility="hidden";
            }
            if(Config.isDropDown){
                document.getElementById("mg-down").style.display="block";
            }
        }else{
            document.getElementById("mg-left").style.display="none";
            document.getElementById("mg-right").style.display="none";
        }
    };
    //菜单下拉
    function activeDownListMenu(){
        var mgid= CurrentMenu.mgid;
        var menugroup = getMenugroup(mgid);
        var menuList = getMenuOfGroup(menugroup);
        var menuArea = Ext.get("down-scoller");
        menuArea.dom.innerHTML="";
        var rr=Ext.get("menu-right");
        for(var i=0; i< menuList.length;i++){
            var m=Ext.get("menu_"+menuList[i].menuid);
            if(m.getRight()<rr.getX() && m.getRight()>0){
                continue;
            }
            var myfun="_openMenu('"+mgid+"','"+menuList[i].menuid+"')";
            var cls="menu";
            if(menuList[i].menuid==CurrentMenu.menuId){
                cls="cmenu";
            }
            var element = menuArea.createChild({tag:"div", id:"down_menu_"+menuList[i].menuid, cls:cls, onClick:myfun});
            element.insertHtml("afterBegin","<div class='menu-inner' style='font-size:"+tabConfig.fontSize+"' id='down_menu_inner_"+menuList[i].menuid+"'>"+menuList[i].name+"</div>"); 	//添加子div便于换肤 汤超 2008-6-18
            element.addClassOnOver("menu-over");//增加鼠标over样式，便于换 汤超 2008-6-18
            var menuEl = Ext.get("down_menu_inner_"+menuList[i].menuid);
            menuEl.addClassOnOver("menu-inner-over");//增加鼠标over样式，便于换 汤超 2008-6-18
        }
    }
    //菜单下拉
    function activeDownListMg(){
        var appuuid=currentAppid;
        var app = getApplication(appuuid);
        var mgList = getMenugroupOfApp(app);
        var menugroup = Ext.get("down-scoller");
        menugroup.dom.innerHTML="";
        var rr=Ext.get("mg-right");
        for(var i=0; i< mgList.length;i++){
            var m=Ext.get("menugroup_"+mgList[i].id);
            if(m.getRight()<=rr.getX() && m.getLeft()>=0){
                continue;
            }
            var fun="_openMg('"+mgList[i].id+"')";
            var element = menugroup.createChild({tag:"div", id:"down_menugroup_"+mgList[i].id, cls:"menugroup", onClick:fun});
            element.insertHtml("afterBegin","<div class='menugroup-inner' style='font-size:"+tabConfig.fontSize+"' id='down_menugroup_inner_"+mgList[i].id+"'>"+mgList[i].name+"</div>");	//添加子div便于换肤 汤超 2008-6-18
            element.addClassOnOver("menugroup-over");//增加鼠标over样式，便于换 汤超 2008-6-18
            Ext.get("down_menugroup_inner_"+mgList[i].id).addClassOnOver("menugroup-inner-over");//增加鼠标over样式，便于换 汤超 2008-6-18
        }
    }
    Config.isDropDown=true;//菜单过长时是否下拉方式显示
    Config.isSlide=true;//菜单过长时是否让其滑动，与isDropDown不能同时为false
    Config.dropDownWithSlide=true;//点击下拉时菜单组或菜单时，是否进行滑动，isDropDown为true是可用
    createSystem();
    scroller.run();
    isReady.topLoaded=true;
    getAccountRule();
</script>
</html>