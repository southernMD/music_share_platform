<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>讨论-${showDiscuss.title}</title>
    <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/public/favicon.ico" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/discuss_detail.css">
</head>
<c:set var="showDiscuss" value='${requestScope.showDiscuss}' />
<c:set var="showComments" value="${requestScope.showComments}" />
<body>
    <div id="app">
        <jsp:include page="/layout/header.jsp">
            <jsp:param name="active" value="discuss"/>
        </jsp:include>
        <main flex flex-column>
            <div class="detail">
                <div class="author" flex>
                    <img src="${showDiscuss.publicer_avatar}" alt="">
                    <div class="message">
                        <a class="title" href="${pageContext.request.contextPath}/user/index?id=${showDiscuss.publicer_id}">${showDiscuss.publicer_name}</a>
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
                           href="${pageContext.request.contextPath}/api/discuss/op?id=${showDiscuss.id}&type=${showDiscuss.isLike != 1?1:3}&path=<%=request.getContextPath()+request.getRequestURI()%>">点赞&nbsp;${showDiscuss.like_number}</a>
                        <a class='${showDiscuss.isDislike == 1?'active':''}'
                           href="${pageContext.request.contextPath}/api/discuss/op?id=${showDiscuss.id}&type=${showDiscuss.isDislike != 1?2:4}&path=<%=request.getContextPath()+request.getRequestURI()%>">点踩&nbsp;${showDiscuss.dislike_number}</a>
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
                                <a href="${pageContext.request.contextPath}/user/index?id=${comment.user_id}">${comment.user_name}</a>
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
        <jsp:include page="/layout/footer.jsp"/>
        <jsp:include page="/layout/toTop.jsp"/>
    </div>
    <script type="module" src="${pageContext.request.contextPath}/js/main.js" async></script>
</body>

</html>