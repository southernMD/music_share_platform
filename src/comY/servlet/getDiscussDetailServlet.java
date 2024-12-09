package comY.servlet;

import comY.entity.User;
import comY.model.ShowComment;
import comY.model.ShowDiscuss;
import comY.util.connectMysql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import static comY.dao.view.discussDetailDao.getShowDiscusses;
import static comY.dao.view.discussDetailDao.getShowDiscussesComment;

@WebServlet("/discuss/detail")
public class getDiscussDetailServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            boolean checkFlag = request.getParameter("id") != null && !request.getParameter("id").isEmpty() && request.getParameter("id").matches("^\\d+$");
            int id = !checkFlag ? -1 : Integer.parseInt(request.getParameter("id"));
            User user = (User) request.getSession().getAttribute("user");
            int user_id = user == null ? -1 : user.getId();
            List<ShowDiscuss> showDiscusses = connectMysql.queryToArrayList(getShowDiscusses(user_id,id), ShowDiscuss.userAllMessageExtractor);
            List<ShowComment> showComments = connectMysql.queryToArrayList(getShowDiscussesComment(user_id,id), ShowComment.userAllMessageExtractor);
            if (showDiscusses.isEmpty()) {
                throw new SQLException("你访问的对象不存在");
            }
            request.setAttribute("showDiscuss", showDiscusses.getFirst());
            request.setAttribute("showComments", showComments);
            request.getRequestDispatcher("/discuss/detail.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", e.toString());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }


}
