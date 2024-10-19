<%@ page import="java.sql.ResultSet" %>
<%@ page import="comY.entity.Song" %>
<%@ page import="comY.util.connectMysql" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="comY.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = connectMysql.getConnection();
        String sql = "SELECT * from songs where id = ?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1,id);
        ResultSet rs =  ptmt.executeQuery();
        List<Song> songs = connectMysql.queryToArrayList(rs, Song.userAllMessageExtractor);
        request.setAttribute("song",songs.getFirst());
    } catch (SQLException e) {
        request.setAttribute("error", e.toString());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
<%
    try {
        Song song = (Song) request.getAttribute("song");
        int id = song.getUser_id();
        Connection conn = connectMysql.getConnection();
        String sql = "SELECT id,user_name,avatar,des from user where id = ?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1,id);
        ResultSet rs =  ptmt.executeQuery();
        List<User> users = connectMysql.queryToArrayList(rs, User.userBaseExtractor);
        System.out.println(users);
        request.setAttribute("publisher",users.getFirst());
    } catch (SQLException e) {
        request.setAttribute("error", e.toString());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/svg+xml" href="/public/favicon.ico" />
    <title>音乐-${song.song_name}</title>
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/css/index.css">
    <style>
        /* styles.css */
        main{
            height: auto;
        }
        .music-detail {
            display: flex;
            gap: 20px;
            padding: 2em;
        }
        .publisher{
            width: calc(100% - 2em);
            height: 300px;
            padding: 2em;
        }
        .info >a{
            padding-left: 1em;
            height: 15px;
        }
        .publisher >.message{
            min-height: 250px;
            height: auto;
            padding: 1em;
            width: calc(100% - 4em);
        }
        .publisher-description{
            text-indent: 2em;
            line-height: 20px;
        }
        .publisher-info{
            display: flex;
            align-items: center;
        }
        .publisher-info >img{
            border-radius: 2em;
            margin-right: 10px;
            width: 50px;
            height: 50px;
            object-fit: cover;
        }
        .cover{
            width: 30%;
        }
        .cover .cover-bg {
            width: 100%;
            padding-top: 100%;
            overflow: hidden;
            position: relative;
        }

        .cover .cover-bg img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .music-message{
            width: calc(100% - 2em - 30% - 150px);
        }
        .info {
            flex: 2;
            display: flex;
            align-items: center;
            height: 100px;
        }

        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
            height: 50px;
            overflow: hidden;
        }

        .artist,
        .album {
            margin-bottom: 10px;
            height: 32px;
        }

        .lyrics h2{
            font-size: 18px;
            margin-bottom: 10px;
        }

        .lyrics pre {
            white-space: pre-wrap;
            font-family: monospace;
            padding: 10px;
            background: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            height: 350px;
            overflow: scroll;
            line-height: 20px;
        }


    </style>
</head>
<body>
    <div id="app">
        <jsp:include page="/template/header.jsp">
            <jsp:param name="active" value="music"/>
        </jsp:include>
        <main>
            <div class="music-detail">
                <div class="cover">
                    <div class="cover-bg">
                        <img src="${song.song_img}" alt="专辑封面">
                    </div>
                </div>
                <div class="music-message">
                    <div class="info">
                        <div class="left">
                            <h1 class="title">${song.song_name}</h1>
                            <div class="artist">${song.ar_name}</div>
                        </div>
                        <div class="right">
                            <audio src="${song.song_url}" controls></audio>
                        </div>
                        <a target="_blank" href="${song.song_url}" small style="width: 70px">下载</a>
                    </div>
                    <div class="lyrics">
                        <h2>歌词</h2>
                        <pre>${song.lrc}</pre>
                    </div>
                </div>
            </div>
            <!-- 发布者 -->
            <div class="publisher">
                <div class="" big>发布者简述</div>
                <div class="message">
                    <div class="publisher-info">
                        <img src="${publisher.avatar}" alt="发布者头像">
                        <a href="/user/index.jsp?id=${publisher.id}" class="publisher-name">${publisher.username}</a>
                    </div>
                    <div class="publisher-description">
                       ${song.song_des}
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="/template/footer.jsp" />
        <jsp:include page="/template/toTop.jsp"/>
    </div>
    <script type="module" src="/js/main.js"></script>
</body>

</html>