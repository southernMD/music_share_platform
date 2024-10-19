<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="comY.util.connectMysql" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="comY.Config" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="comY.model.ShowDiscuss" %>
<%@ page import="java.util.List" %>
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
    <title>讨论</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/public/favicon.ico" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/discuss.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">
</head>

<%
    try {
        Connection conn = connectMysql.getConnection();
        String sql = "SELECT count(*) as totalItems,ceil(count(*)/?) as currentPage from discuss";
        PreparedStatement ptmt =  conn.prepareStatement(sql);
        ptmt.setInt(1, Integer.parseInt(Config.PageSize.getValue()));
        ResultSet rs = ptmt.executeQuery();
        while (rs.next()){
            request.setAttribute("totalItems",rs.getInt("totalItems"));
            request.setAttribute("currentPage",rs.getInt("currentPage"));
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }

%>


<c:set var="discussList" value='<%=(List<ShowDiscuss>)request.getAttribute("discussList")%>'/>


<body>
<div id="app">
    <jsp:include page="/template/header.jsp">
        <jsp:param name="active" value="discuss"/>
    </jsp:include>
    <main>
        <ul>
        <c:forEach items="${discussList}" var="discuss">
            <li flex flex-column>
                <div class="top" flex flex-row>
                    <img src="${discuss.publicer_avatar}" alt="">
                    <div flex flex-column class="message">
                        <a href="${pageContext.request.contextPath}/user/index.jsp?id=${discuss.publicer_id}">${discuss.publicer_name}</a>
                        <p small class="time">${discuss.discuss_time}</p>
                    </div>
                </div>
                <div class="middle">
                    <img src="${discuss.discuss_img}" alt="">
                    <h1 strong big>
                        ${discuss.title}
                    </h1>
                    <h2 small>
                        ${discuss.discuss_main}
                    </h2>
                    <a blue href="${pageContext.request.contextPath}/discuss/detail.jsp?id=${discuss.id}" small>阅读更多</a>
                </div>
                <div class="bottom" flex flex-column>
                    <div class="options" flex small>
                        <a class='${discuss.isLike == 1?'active':''}'
                           href="${pageContext.request.contextPath}/api/discuss/op?id=${discuss.id}&type=${discuss.isLike != 1?1:3}&path=/api/discuss/list">点赞&nbsp;${discuss.like_number}</a>
                        <a class='${discuss.isDislike == 1?'active':''}'
                           href="${pageContext.request.contextPath}/api/discuss/op?id=${discuss.id}&type=${discuss.isDislike != 1?2:4}&path=/api/discuss/list">点踩&nbsp;${discuss.dislike_number}</a>
                        <a >评论&nbsp;${discuss.comment_number}</a>
                    </div>
                </div>
            </li>
        </c:forEach>
        </ul>
        <div class="pagination_message" hidden>
            <div>${totalItems}</div>
            <div>${currentPage}</div>
            <div class="url">/api/discuss/list?</div>
        </div>
        <div style="padding-bottom: 1em;" class="pagination" id="pagination">
            <a class="prev">上一页</a>
            <!-- 分页链接将在这里动态生成 -->
            <a class="next">下一页</a>
        </div>
    </main>
    <jsp:include page="/template/footer.jsp"/>
    <jsp:include page="/template/toTop.jsp"/>

</div>
<script>
    //页面加载完成的时候
    window.addEventListener("DOMContentLoaded",()=>{
        const like_btns = document.querySelectorAll("main .bottom .options >:first-child");
        const dislike_btns = document.querySelectorAll("main .bottom .options >:nth-child(2)");
        dislike_btns.forEach(a=>{
            a.addEventListener("click",(e)=>{
                console.log(window.location.search.split("?")[1])
                e.preventDefault()
                window.location.href = a.href + `&`+ window.location.search.split("?")[1];
            })
        })
        like_btns.forEach(a=>{
            console.log(window.location.search.split("?")[1])
            a.addEventListener("click",(e)=>{
                e.preventDefault()
                window.location.href = a.href + `&`+ window.location.search.split("?")[1];
            })
        })
    })

</script>
<script type="module" src="${pageContext.request.contextPath}/js/main.js" async></script>
<script type="module" src="${pageContext.request.contextPath}/js/pagination.js"></script>
</body>

</html>
