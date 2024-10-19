<%--
  Created by IntelliJ IDEA.
  User: southernMD
  Date: 2024/10/14
  Time: 下午2:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>
<html>
<head>
    <link rel="icon" type="image/svg+xml" href="/public/favicon.ico" />
    <title>错误</title>
</head>
<body>
    <c:if test="${pageContext.request.getAttribute('javax.servlet.error.status_code')==404}">
        你访问了一个不存在的页面
    </c:if>
    <p>${pageContext.request.getAttribute("error")}</p>
    <a href="/">回到首页</a>
    <a onclick="history.go(-1);" href="javascript:void(0);">返回</a>
</body>
</html>
