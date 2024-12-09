<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="comY.entity.Song" %>
<%@ page import="java.util.List" %>
<%@ page import="comY.entity.User" %>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/public/favicon.ico" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/music.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
  <title>音乐</title>
</head>
<c:set var="searchSongs" value='<%=(List<Song>) request.getAttribute("searchSongs")%>'/>
<c:set var="search" value='<%=(String) request.getAttribute("search") == null ?"":request.getAttribute("search")%>'/>
<c:set var="user" value='<%=(User) request.getSession().getAttribute("user")%>'/>
<body>
  <div id="app">
    <jsp:include page="/layout/header.jsp">
      <jsp:param name="active" value="music"/>
    </jsp:include>
    <main>
      <div class="looking" flex flex-column>
        <div class="search">
          <div class="input-bg">
            <input type="text" placeholder="输入" id="search-input" value="${search}">
            <a id="search-a" href="${pageContext.request.contextPath}/api/search/songs" small>搜索</a>
          </div>
        </div>
        <c:if test="${search.trim().length()!=0}">
          <div class="search-val">
            搜索："${search}"
          </div>
        </c:if>
        <ul>
          <c:forEach items="${searchSongs == null?songs:searchSongs}" var="song">
            <li>
              <a href="${pageContext.request.contextPath}/music/detail?id=${song.id}">
                <img src="${song.song_img}" alt="">
                <div class="message">
                  <div class="title" strong big>${song.song_name}</div>
                  <div class="ar">${song.ar_name}</div>
                  <div class="lrc" small>${fn:escapeXml(song.lrc)}</div>
                  <div class="sign" small>
                      ${fn:escapeXml(song.song_des)}
                  </div>
                </div>
              </a>
            </li>
          </c:forEach>
        </ul>
        <div class="pagination_message" hidden>
          <div>${totalItems}</div>
          <div>${totalPage}</div>
          <div class="url">
            <c:if test="${search.trim().length()!=0}">/api/search/songs?search=${search}&</c:if>
            <c:if test="${search.trim().length()==0}">/music/index?</c:if>
          </div>
        </div>
        <c:if test="${search.trim().length()!=0 && searchSongs.size() == 0}">
          <div class="no-find">
            <div class="message" big strong>
              没有找到你所搜索的结果，或许你可以尝试自己去发布
            </div>
            <a href="${pageContext.request.contextPath}/user/index?id=${user == null ?0:user.id}" data-type="${user == null ?0:1}" strong blue>发布音乐</a>
          </div>
        </c:if>
        <div class="pagination" id="pagination">
          <a class="prev">上一页</a>
          <!-- 分页链接将在这里动态生成 -->
          <a class="next">下一页</a>
        </div>
      </div>
    </main>
    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/toTop.jsp"/>

  </div>
  <script type="module" src="${pageContext.request.contextPath}/js/main.js"></script>
  <script type="module" src="${pageContext.request.contextPath}/js/pagination.js"></script>
</body>
<script>
  const search_a = document.querySelector("#search-a");
  search_a.addEventListener("click",(e)=>{
    e.preventDefault();
    const search_input = document.querySelector("#search-input");
    if(search_input.value.trim().length === 0){
      window.location.href = location.host + "/music/index";
    }
    window.location.href = search_a.href + "?search=" + search_input.value;
  })
  const to = document.querySelector(".no-find a");
  to.addEventListener("click",(e)=>{
    e.preventDefault();
    if(+to.getAttribute("data-type") === 0){
      window.location.href = "/login.jsp?way=login";
    }else{
      window.location.href = to.href;
    }
  })
</script>
</html>