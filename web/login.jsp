<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setDateHeader("Expires", -1);
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/svg+xml" href="/public/favicon.ico" />
    <title>登录-注册</title>
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/css/login2.css">
    <link rel="stylesheet" href="/css/button.css">
</head>

<body>
<div class="container">
    <div class="container_form">
        <nav class="mask" id="mask"></nav>
        <!-- 去登录 -->
        <div class="left left-login goLogin maskState-right">
            <button id="goLogin" class="ripple reg-left-button">已有账号，点击登录</button>
        </div>
        <!-- 登录 -->
        <div class="left Login maskState-left">
            <H2 class="title">欢迎登录</H2>
            <form action="/api/login" method="post">
                <input name="username" placeholder="用户名"></input>
                <input type="password" name="password" placeholder="密码"></input>
                <button class="reg-right-button ripple" type="submit">登录</button>
            </form>
        </div>
        <!-- 去注册 -->
        <div class="right goReg maskState-left">
            <button id="goReg" class="reg-right-button ripple">还没有账号，点击注册</button>
        </div>
        <!-- 注册 -->
        <div class="right Reg maskState-right">
            <H2 class="title">注册</H2>
            <form action="/api/reg" method="post">
                <input name="username"  placeholder="请输入6-12位账号"></input>
                <input name="password1" type="password" placeholder="请输入密码" ></input>
                <input name="password2" type="password" placeholder="确认密码" ></input>
                <button type="submit" class="reg-right-button ripple">注册</button>
            </form>
        </div>
    </div>
</div>
<script src="/js/login.js"></script>
</body>

</html>