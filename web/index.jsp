<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="comY.util.connectMysql" %>
<%@ page import="java.util.List" %>
<%@ page import="comY.entity.Song" %>
<%@ page import="comY.entity.Discuss" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="comY.model.ShowDiscuss" %>
<%@ page import="comY.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: southernMD
  Date: 2024/10/5
  Time: 下午8:10
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setDateHeader("Expires", -1);
%>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" type="image/svg+xml" href="/public/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/css/index.css">
    <title>首页</title>
</head>

<%
    try {
        Connection conn = connectMysql.getConnection();
        String sql = "SELECT * FROM songs ORDER BY RAND() LIMIT 8";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ResultSet rs = ptmt.executeQuery();
        List<Song> Songs = connectMysql.queryToArrayList(rs, Song.userAllMessageExtractor);
        request.setAttribute("RandSongs", Songs);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>

<%
    try{
        Connection conn = connectMysql.getConnection();
        String sql = "SELECT * FROM songs ORDER BY public_time DESC limit 10";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ResultSet rs = ptmt.executeQuery();
        List<Song> Songs = connectMysql.queryToArrayList(rs, Song.userAllMessageExtractor);
        request.setAttribute("orderSongs", Songs);
    }catch (SQLException e){
        throw new RuntimeException(e);
    }

%>

<%
    try{
        Connection conn = connectMysql.getConnection();
        User user = (User) request.getSession().getAttribute("user") ;
        int user_id = user == null?-1:user.getId();
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
                "ORDER BY\n" +
                "    RAND()\n" +
                "LIMIT 5;";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1,user_id);
        ptmt.setInt(2,user_id);
        ResultSet rs = ptmt.executeQuery();
        List<ShowDiscuss> showDiscusses = connectMysql.queryToArrayList(rs, ShowDiscuss.userAllMessageExtractor);
        request.setAttribute("showDiscusses", showDiscusses);
    }catch (SQLException e){
        throw new RuntimeException(e);
    }

%>


<body>
<div id="app">

    <jsp:include page="/template/header.jsp">
        <jsp:param name="active" value="index"/>
    </jsp:include>
    <main>
        <div class="looking">
            <div class="left">
                <div class="top">
                    <div class="change">
                        <a href="/" class="change-by-change">换一换</a>
                    </div>
                    <ul>
                        <c:forEach items="${RandSongs}" var="song">
                            <li data-id="${song.id}">
                                <div class="message-box"></div>
                                <img draggable="false" src="${song.song_img}" alt="">
                                <div class="name" small>${song.song_name}&nbsp;--&nbsp;${song.ar_name}</div>
                                <div class="lrc" hidden>${fn:escapeXml(song.lrc)}</div>
                                <div class="des" hidden>${fn:escapeXml(song.song_des)}</div>
                            </li>
                        </c:forEach>
                    </ul>
                    <div id="scale_message" class="message" hidden>
                        <div class="title" strong big></div>
                        <div class="ar"></div>
                        <div class="lrc" small></div>
                        <div class="sign" small>
                        </div>
                    </div>
                </div>
                <!-- 随便听听 -->
                <div class="bottom">
                    <ul>
                        <c:forEach items="${showDiscusses}" var="showDiscuss" >
                            <li flex flex-column>
                                <div class="top" flex flex-row>
                                    <img src="${showDiscuss.publicer_avatar}" alt="">
                                    <div flex flex-column class="message">
                                        <a href="/user/index.jsp?id=${showDiscuss.publicer_id}">${showDiscuss.publicer_name}</a>
                                        <p small class="time">${showDiscuss.discuss_time}</p>
                                    </div>
                                </div>
                                <div class="middle">
                                    <img src="${showDiscuss.discuss_img}" alt="">
                                    <h1 strong big>
                                        ${showDiscuss.title}
                                    </h1>
                                    <h2 small>
                                        ${showDiscuss.discuss_main}
                                    </h2>
                                    <a blue href="/discuss/detail.jsp?id=${showDiscuss.id}" small>阅读更多</a>
                                </div>
                                <div class="bottom" flex flex-column>
                                    <div class="options" flex small>
                                        <a class='${showDiscuss.isLike == 1?'active':''}'
                                           href="/api/discuss/op?id=${showDiscuss.id}&type=${showDiscuss.isLike != 1?1:3}&path=<%=request.getRequestURI()%>">点赞&nbsp;${showDiscuss.like_number}</a>
                                        <a class='${showDiscuss.isDislike == 1?'active':''}'
                                           href="/api/discuss/op?id=${showDiscuss.id}&type=${showDiscuss.isDislike != 1?2:4}&path=<%=request.getRequestURI()%>">点踩&nbsp;${showDiscuss.dislike_number}</a>
                                        <a >评论&nbsp;${showDiscuss.comment_number}</a>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>

                    </ul>
                    <!-- 最近话题 -->
                </div>
            </div>
            <div class="right">
                <div class="top">
                    <div class="title" strong>最新发布</div>
                    <ol>
                        <c:forEach items="${orderSongs}" var="song" varStatus="status">
                            <li>
                                <div class="index" small>${status.index+1}</div>
                                <a href="/music/detail.jsp?id=${song.id}">${song.ar_name} - ${song.song_name}</a>
                            </li>
                        </c:forEach>
                    </ol>
                    <!-- 最新发布 -->
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="/template/footer.jsp" />
    <jsp:include page="/template/toTop.jsp"/>
</div>
    <script type="module" src="./js/main.js"></script>
</body>
</html>
