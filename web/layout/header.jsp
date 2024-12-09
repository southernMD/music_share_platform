<%@ page import="comY.entity.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="active" value='${pageContext.request.getParameter("active")}' />
<%
    User user = (User) pageContext.getSession().getAttribute("user");
%>
<c:set var="user" value="<%= user %>"/>


<header>
    <div class="header-box">
        <a href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/public/images/logo.png" alt="" draggable="false">
        </a>
        <ul>
            <li
            <c:if test='${active == "index"}'>
                class="active"
            </c:if>
            >
                <a href="${pageContext.request.contextPath}/">首页</a>
            </li>
            <li
                <c:if test='${active == "music"}'>
                    class="active"
                </c:if>
            >
                <a href="${pageContext.request.contextPath}/music/index">音乐</a>
            </li>
            <li
                <c:if test='${active == "discuss"}'>
                    class="active"
                </c:if>
            >
                <a href="${pageContext.request.contextPath}/api/discuss/list?currentPage=1">讨论</a>
            </li>
        </ul>

        <div class="user">
            <div class="login"
                 <c:if test='${user!=null}'>
                     hidden
                 </c:if>
            >
                <a href="${pageContext.request.contextPath}/login.jsp?way=login">登录</a>
                <p>/</p>
                <a href="${pageContext.request.contextPath}/login.jsp?way=register">注册</a>
            </div>
            <div class="logined"
                <c:if test='${user==null}'>
                    hidden
                </c:if>
            >
                <img src="${user.avatar}" alt="">
                <div class="user-name">
                    <a href="${pageContext.request.contextPath}/user/index?id=${user.id}">${user.username}</a>
                </div>
                <div class="login-out">
                    <a href="${pageContext.request.contextPath}/api/quit">退出</a>
                </div>
            </div>
        </div>
    </div>
</header>
