<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="comY.entity.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="comY.util.connectMysql" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="comY.entity.Song" %>
<%@ page import="java.util.List" %>
<%@ page import="comY.entity.Discuss" %>
<c:set var="active" value='${pageContext.request.getParameter("active")}' />
<%
    User login_user = (User) pageContext.getSession().getAttribute("user");
    Boolean checkFlag  = request.getParameter("id") != null && !request.getParameter("id").isEmpty() && !request.getParameter("id").matches("\\d+");
    int id = checkFlag?-1:Integer.parseInt(request.getParameter("id"));
    try {
        Connection conn = connectMysql.getConnection();
        String sql = "SELECT id,user_name,avatar,des from user where id = ?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1, id);
        ResultSet rs =  ptmt.executeQuery();
        List<User> users = connectMysql.queryToArrayList(rs, User.userBaseExtractor);
        if(users.isEmpty()){
            throw new SQLException("用户不存在");
        }
        request.setAttribute("user",users.getFirst());
    }catch (SQLException e){
        request.setAttribute("error", e.toString());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
<%
    try {
        Connection conn = connectMysql.getConnection();
        String sql = "SELECT * from songs where user_id = ?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1, ((User) request.getAttribute("user")).getId());
        ResultSet rs =  ptmt.executeQuery();
        List<Song> songs = connectMysql.queryToArrayList(rs, Song.userAllMessageExtractor);
        request.setAttribute("songs",songs);
    } catch (SQLException e) {
        request.setAttribute("error", e.toString());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
<%
try {
    Connection conn = connectMysql.getConnection();
    String sql = "SELECT * from discuss where publicer_id = ?";
    PreparedStatement ptmt = conn.prepareStatement(sql);
    ptmt.setInt(1, ((User) request.getAttribute("user")).getId());
    ResultSet rs =  ptmt.executeQuery();
    List<Discuss> discusses = connectMysql.queryToArrayList(rs, Discuss.userAllMessageExtractor);
    request.setAttribute("discusses",discusses);

}catch (SQLException e) {
    request.setAttribute("error", e.toString());
    request.getRequestDispatcher("/error.jsp").forward(request, response);
}
%>
<c:set var="user" value='<%= (User) request.getAttribute("user") %>'/>
<c:set var="login_user" value="<%= login_user %>"/>

<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/public/favicon.ico" />
    <!-- <link rel="stylesheet" href="/css/app.css"> -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">

</head>

<body>
    <div id="app">
        <jsp:include page="/template/header.jsp"/>
        <main>
            <section class="profile">
                <form action="${pageContext.request.contextPath}/api/change/user" method="post"  enctype="multipart/form-data">
                    <input name="id" hidden value="${user.id}">
                    <div class="avatar">
                        <img id="user-img" src="${user.avatar}" alt="用户头像">
                    </div>
                    <div class="img-input">
                        <input id="user-img-input" name="avatar" type="file"  hidden>
                        <button id="user-img-button" hidden>更换图片</button>
                    </div>
                    <div class="info">
                        <h1 class="username" id="name">${user.username}</h1>
                        <input id="input-user-name" hidden big name="username" type="text" value="${user.username}">
                        <p class="bio" id="des" >${user.des}</p>
                        <input id="input-user-des" hidden name="description" type="text" value="${user.des}">
                    </div>
                    <c:if test="${login_user != null && login_user.id == user.id}">
                        <div class="options">
                            <button id="edit-btn">编辑</button>
                            <button id="cancel-btn" hidden>取消</button>
                            <button id="save-btn" hidden type="submit">保存</button>
                        </div>
                    </c:if>
                </form>
            </section>
            <section class="published-music">
                <h2>已发布的音乐</h2>
                <ul id="published-music-ul">
                    <c:forEach items="${songs}" var="song">
                        <li>
                            <form action="${pageContext.request.contextPath}/api/update/songs?id=${song.id}" method="post" enctype="multipart/form-data">
                                <div class="music-item">
                                    <input type="file" name="song_img" hidden value="${song.song_img}"/>
                                    <img class="song_img" src="${song.song_img}" alt="音乐封面"/>
                                    <div class="music-details">
                                        <h3>${song.song_name}</h3>
                                        <input placeholder="歌名" hidden name="song_name" type="text" value="${song.song_name}">
                                        <p>${song.ar_name}</p>
                                        <input placeholder="歌手" hidden name="ar_name" type="text" value="${song.ar_name}">
                                        <p class="song_url">${song.song_url}</p>
                                        <input placeholder="音乐地址" hidden name="song_url" type="text" value="${song.song_url}">
                                    </div>
                                    <div class="lrc">
                                        <textarea hidden name="lrc"  cols="20" rows="10">
                                            ${song.lrc}
                                    </textarea>
                                        <div class="txt" small>
                                            ${song.lrc}
                                        </div>
                                    </div>
                                    <div class="des">
                                        <textarea hidden name="song_des" cols="20" rows="10" onload="">${song.song_des}</textarea>
                                        <div class="txt" small>
                                            ${song.song_des}
                                        </div>
                                    </div>
                                    <c:if test="${login_user != null && login_user.id == user.id}">
                                        <div class="options">
                                            <button class="li-edit-btn">编辑</button>
                                            <button class="li-cancel-btn" type="reset" hidden>取消</button>
                                            <button  hidden type="submit">保存</button>
                                        </div>
                                    </c:if>
                                </div>
                            </form>
                        </li>
                    </c:forEach>
                    <c:if test="${login_user != null && login_user.id == user.id}">
                        <li>
                            <form action="${pageContext.request.contextPath}/api/send/music" method="post" enctype="multipart/form-data">
                                <div class="music-item">
                                    <div class="song_img song_img_div" >+</div>
                                    <div class="music-item" hidden>
                                        <input type="file" name="song_img" hidden>
                                        <img class="song_img song_add_img" style="cursor: pointer;" src="${pageContext.request.contextPath}/public/images/image.jpg" alt="音乐封面">
                                        <div class="music-details" style="width: 150px">
                                            <input placeholder="歌名"  name="song_name" type="text" value="">
                                            <input placeholder="歌手"  name="ar_name" type="text" value="">
                                            <input placeholder="音乐地址"  name="song_url" type="text" value="">
                                        </div>
                                        <div class="lrc">
                                            <textarea name="song_lrc" placeholder="歌词"  id="" cols="20" rows="10"></textarea>
                                        </div>
                                        <div class="des">
                                            <textarea name="song_des" placeholder="描述"  id="" cols="20" rows="10"></textarea>
                                        </div>
                                        <div class="options">
                                            <button class="li-cancel-btn cancel-add-button" type="reset">取消</button>
                                            <button id="save-btn" type="submit">保存</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </li>
                    </c:if>
                </ul>
            </section>
            <section class="topics">
                <h2>已发布的话题</h2>
                <ul id="topics-ul">
                    <c:forEach items="${discusses}" var="discuss">
                        <li>
                            <form action="${pageContext.request.contextPath}/api/update/discuss?id=${discuss.id}"  method="post" enctype="multipart/form-data">
                                <div class="topic-item">
                                    <input name="discuss_img" type="file" hidden>
                                    <img class="topics_img" src="${discuss.discuss_img}" alt="话题图片">
                                    <div class="topic-details">
                                        <h3>${discuss.title}</h3>
                                        <input name="title" type="text" hidden value="${discuss.title}">
                                        <p>${discuss.discuss_time}</p>
                                        <p class="discuss-main">${discuss.discuss_main}</p>
                                        <textarea name="discuss_main"  cols="20" rows="8" hidden>${discuss.discuss_main}</textarea>
                                    </div>
                                    <c:if test="${login_user != null && login_user.id == user.id}">
                                        <div class="options">
                                            <button class="li-edit-btn">编辑</button>
                                            <button class="li-cancel-btn" hidden type="reset">取消</button>
                                            <button hidden type="submit">保存</button>
                                        </div>
                                    </c:if>
                                </div>

                            </form>
                        </li>
                    </c:forEach>
                    <c:if test="${login_user != null && login_user.id == user.id}">
                        <li>
                        <form action="${pageContext.request.contextPath}/api/send/discuss"  method="post" enctype="multipart/form-data">
                            <div class="topic-item">
                                <div class="topics_img topic_img_div" >+</div>
                                <div class="topic-item" hidden>
                                    <input name="topics_img" type="file" hidden>
                                    <img class="topics_img topics_add_img"  style="cursor: pointer;"  src="${pageContext.request.contextPath}/public/images/image.jpg" alt="话题图片">
                                    <div class="topic-details topic-details-add ">
                                        <input name="title" type="text" placeholder="话题标题" >
                                        <textarea placeholder="话题内容" name="txt"   cols="20" rows="8" ></textarea>
                                    </div>
                                    <div class="options">
                                        <button class="li-cancel-btn cancel-add-topic-button" type="reset">取消</button>
                                        <button  type="submit">保存</button>
                                    </div>
                                </div>
                            </div>

                        </form>
                    </li>
                    </c:if>

                </ul>
            </section>
        </main>
        <jsp:include page="/template/footer.jsp" />
        <jsp:include page="/template/toTop.jsp"/>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js" type="module"></script>
    <script src="${pageContext.request.contextPath}/js/uesr.js" type="module"></script>
</body>

</html>