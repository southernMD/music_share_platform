<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="comY.util.connectMysql" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="comY.entity.Song" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="comY.model.ShowDiscuss" %>
<%@ page import="comY.entity.User" %>
<%@ page import="comY.model.ShowComment" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%
    try {
        Boolean checkFlag  = request.getParameter("id") != null && !request.getParameter("id").isEmpty() && request.getParameter("id").matches("^\\d+$");
        int id = !checkFlag?-1:Integer.parseInt(request.getParameter("id"));
        User user = (User) request.getSession().getAttribute("user") ;
        int user_id = user == null?-1:user.getId();
        Connection conn = connectMysql.getConnection();
        String sql = "SELECT\n" +
                "    discuss.*,\n" +
                "    u.avatar AS publicer_avatar,\n" +
                "    u.user_name AS publicer_name,\n" +
                "    COALESCE(dl.like_count, 0) AS like_number,\n" +
                "    COALESCE(dd.dislike_count, 0) AS dislike_number,\n" +
                "    COALESCE(dc.comment_count,0) AS comment_number,\n" +
                "    EXISTS (SELECT 1 FROM discuss_like WHERE discuss_id = discuss.id AND user_id = ?) AS isLike,\n" +
                "    EXISTS (SELECT 1 FROM discuss_dislike WHERE discuss_id = discuss.id AND user_id = ?) AS isDislike\n" +
                "FROM\n" +
                "    discuss\n" +
                "LEFT JOIN\n" +
                "    user AS u ON discuss.publicer_id = u.id\n" +
                "LEFT JOIN\n" +
                "    (SELECT discuss_id,COUNT(*) AS like_count FROM discuss_like GROUP BY discuss_id) dl ON dl.discuss_id = discuss.id\n" +
                "LEFT JOIN\n" +
                "    (SELECT discuss_id,COUNT(*) AS dislike_count FROM discuss_dislike GROUP BY discuss_id) dd ON dd.discuss_id = discuss.id\n" +
                "LEFT JOIN\n" +
                "    (SELECT discuss_id,COUNT(*) AS comment_count FROM comment GROUP BY discuss_id) dc on dc.discuss_id = discuss.id\n" +
                "WHERE\n" +
                "    discuss.id = ?;";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1,user_id);
        ptmt.setInt(2,user_id);
        ptmt.setInt(3,id);
        ResultSet rs =  ptmt.executeQuery();
        List<ShowDiscuss> showDiscusses = connectMysql.queryToArrayList(rs, ShowDiscuss.userAllMessageExtractor);
        if(showDiscusses.isEmpty()){
            throw new SQLException("你访问的对象不存在");
        }
        request.setAttribute("showDiscuss",showDiscusses.getFirst());
    } catch (SQLException e) {
        request.setAttribute("error", e.toString());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
<%
    try{
        Boolean checkFlag  = request.getParameter("id") != null && !request.getParameter("id").isEmpty() && request.getParameter("id").matches("^\\d+$");
        int id = !checkFlag?-1:Integer.parseInt(request.getParameter("id"));
        User user = (User) request.getSession().getAttribute("user") ;
        int user_id = user == null?-1:user.getId();
        Connection conn = connectMysql.getConnection();
        String sql ="SELECT comment.*,\n" +
                "        COALESCE(cl.comment_like_number, 0) AS comment_like_number,\n" +
                "        EXISTS (SELECT 1 FROM comment_like WHERE comment_like.comment_id = comment.id AND user_id = ?) AS isLike,\n" +
                "        user.avatar,user.user_name\n" +
                "       from comment\n" +
                "LEFT JOIN\n" +
                "    (SELECT comment_id,COUNT(*) AS comment_like_number FROM comment_like GROUP BY comment_id) cl on comment.id = cl.comment_id\n" +
                "LEFT JOIN\n" +
                "    (SELECT id,user_name,avatar from user) user on user.id = comment.user_id\n" +
                "where discuss_id = ?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1,user_id);
        ptmt.setInt(2,id);
        ResultSet rs =  ptmt.executeQuery();
        List<ShowComment> showComments = connectMysql.queryToArrayList(rs, ShowComment.userAllMessageExtractor);
        request.setAttribute("showComments",showComments);
    }catch (Exception e){
        request.setAttribute("error", e.toString());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>讨论-${showDiscuss.title}</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/public/favicon.ico" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/discuss_detail.css">
</head>

<body>
    <div id="app">
        <jsp:include page="/template/header.jsp">
            <jsp:param name="active" value="discuss"/>
        </jsp:include>
        <main flex flex-column>
            <div class="detail">
                <div class="author" flex>
                    <img src="${showDiscuss.publicer_avatar}" alt="">
                    <div class="message">
                        <div class="title">${showDiscuss.publicer_name}</div>
                        <div class="time" small>${showDiscuss.discuss_time}</div>
                    </div>
                </div>
                <div class="title" strong big>${showDiscuss.title}</div>
                <div class="bg-img">
                    <img src="${showDiscuss.discuss_img}" alt="">
                </div>
                <div class="txt">
                    ${showDiscuss.discuss_main}
                </div>
                <div class="bottom">
                    <div class="options" small>
                        <a class='${showDiscuss.isLike == 1?'active':''}'
                           href="${pageContext.request.contextPath}/api/discuss/op?id=${showDiscuss.id}&type=${showDiscuss.isLike != 1?1:3}&path=<%=request.getRequestURI()%>">点赞&nbsp;${showDiscuss.like_number}</a>
                        <a class='${showDiscuss.isDislike == 1?'active':''}'
                           href="${pageContext.request.contextPath}/api/discuss/op?id=${showDiscuss.id}&type=${showDiscuss.isDislike != 1?2:4}&path=<%=request.getRequestURI()%>">点踩&nbsp;${showDiscuss.dislike_number}</a>
                        <a >评论&nbsp;${showDiscuss.comment_number}</a>
                    </div>
                </div>
            </div>
            <div class="writer-comment">
                <form action="${pageContext.request.contextPath}/send/discuss/comment" method="post">
                    <div class="title" big>写评论</div>
                    <input name="discuss_id" value="${showDiscuss.id}" hidden>
                    <textarea name="textarea" id="" cols="30" rows="10" placeholder="请输入评论内容"></textarea>
                    <button type="submit">发送</button>
                </form>
            </div>
            <div class="comment">
                <div class="title" big>评论(${showDiscuss.comment_number})</div>
                <ul class="comment-box">
                    <c:forEach var="comment" items="${showComments}" varStatus="status">
                    <li class="comment-item" id="c_${status.index}">
                        <div class="top" flex flex-row>
                            <img src="${comment.avatar}" alt=""></img>
                            <div flex flex-column class="message">
                                <a href="${pageContext.request.contextPath}/user/index.jsp?id=${comment.user_id}">${comment.user_name}</a>
                            </div>
                            <div class="time" small style="margin-left: 5px;">${comment.comment_time}</div>
                        </div>
                        <div class="middle">
                            <div class="txt">
                                ${comment.message}
                            </div>
                            <div class="like" small>
                                <a
                                    class='${comment.isLike == 1?'active':''}'
                                    href="${pageContext.request.contextPath}/api/comment?id=${comment.id}&type=${comment.isLike==1?2:1}&discuss_id=${showDiscuss.id}#c_${status.index}">点赞(${comment.comment_like_number})</a>
                            </div>
                        </div>
                    </li>
                    </c:forEach>
                </ul>
                <div class="no-comment" big strong ${showDiscuss.comment_number == 0?'':'hidden'}>
                    还没有评论
                </div>
            </div>
        </main>
        <jsp:include page="/template/footer.jsp"/>
        <jsp:include page="/template/toTop.jsp"/>
    </div>
    <script type="module" src="${pageContext.request.contextPath}/js/main.js" async></script>
</body>

</html>