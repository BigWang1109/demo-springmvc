<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%--<meta charset="UTF-8">--%>
<!--Declare page as mobile friendly -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0"/>
<!-- Declare page as iDevice WebApp friendly -->
<meta name="apple-mobile-web-app-capable" content="yes"/>
<!-- iDevice WebApp Splash Screen, Regular Icon, iPhone, iPad, iPod Retina Icons -->
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=path%>/includes/images/splash/splash-icon.png">
<!-- iPhone 3, 3Gs -->
<link rel="apple-touch-startup-image" href="<%=path%>/includes/images/splash/splash-screen.png" 			media="screen and (max-device-width: 320px)" />
<!-- iPhone 4 -->
<link rel="apple-touch-startup-image" href="<%=path%>/includes/images/splash/splash-screen_402x.png" 		media="(max-device-width: 480px) and (-webkit-min-device-pixel-ratio: 2)" />
<!-- iPhone 5 -->
<link rel="apple-touch-startup-image" sizes="640x1096" href="images/splash/splash-screen_403x.png" />
<jsp:include flush="true" page="/view/common/resource.jsp"></jsp:include>
<!-- Page Title -->
<title>OceanWide</title>

</head>
<body>

<div id="preloader">
    <div id="status">
        <p class="center-text">
            Loading the content...
            <em>Loading depends on your connection speed!</em>
        </p>
    </div>
</div>

<div class="content">

    <div class="landing-logo">
        <%--<img class="replace-2x" src="<%=path%>/includes/images/logo.png" alt="img" width="100"></div>--%>
        <img class="replace-2x" src="<%=path%>/includes/images/logo.jpg" alt="img"  width="100"></div>
</div>

<div class="welcome-text">
    <h3>Welcome to OceanWide</h3>
    <%--<p>Flat, simple, intuitive!</p>--%>
    <p></p>
</div>

<div class="navigation-icons">
    <a href="http://www.fhkg.com" class="nav-icon icon-red home-nav"></a>
    <a href="<%=path%>/sm/enter" class="nav-icon icon-blue about-nav"></a>
    <a href="<%=path%>/mb/messList" class="nav-icon icon-magenta blog-nav"></a>
    <a href="#" class="nav-icon icon-dblue folio-nav"></a>
    <a href="#" class="nav-icon icon-green video-nav"></a>
    <a href="#" class="nav-icon icon-yellow mail-nav"></a>
</div>

<div class="small-navigation-icons">
    <a href="#" class="small-nav-icon facebook-nav"></a>
    <a href="#" class="small-nav-icon phone-nav"></a>
    <a href="#" class="small-nav-icon twitter-nav"></a>
    <div class="clear"></div>
</div>

<p class="landing-copyright copyright">COPYRIGHT 2016. ALL RIGHTS RESERVED</p>

</div>
</body>
</html>





























