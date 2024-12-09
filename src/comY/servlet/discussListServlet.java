package comY.servlet;

import comY.entity.User;
import comY.model.ShowDiscuss;
import comY.util.connectMysql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.PropertyEditorManager;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/api/discuss/list")
public class discussListServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String sql = """
                SELECT
                    discuss.*,
                    u.avatar AS publicer_avatar,
                    u.user_name AS publicer_name,
                    COALESCE(dl.like_count, 0) AS like_number,
                    COALESCE(dd.dislike_count, 0) AS dislike_number,
                    COALESCE(dc.comment_count,0) AS comment_number,
                    EXISTS (SELECT 1 FROM discuss_like WHERE discuss_id = discuss.id AND user_id = ?) AS isLike,
                    EXISTS (SELECT 1 FROM discuss_dislike WHERE discuss_id = discuss.id AND user_id = ?) AS isDislike
                FROM
                    discuss
                LEFT JOIN
                    user AS u ON discuss.publicer_id = u.id
                LEFT JOIN
                    (SELECT discuss_id,COUNT(*) AS like_count FROM discuss_like GROUP BY discuss_id) dl ON dl.discuss_id = discuss.id
                LEFT JOIN
                    (SELECT discuss_id,COUNT(*) AS dislike_count FROM discuss_dislike GROUP BY discuss_id) dd ON dd.discuss_id = discuss.id
                LEFT JOIN
                    (SELECT discuss_id,COUNT(*) AS comment_count FROM comment GROUP BY discuss_id) dc on dc.discuss_id = discuss.id
                ORDER BY
                    discuss.id
                LIMIT ?,5""";
        try {
            User user = (User) req.getSession().getAttribute("user");
            int user_id = user == null ?-1:user.getId();
            int currentPage = Integer.parseInt(req.getParameter("currentPage") == null ||req.getParameter("currentPage").isEmpty()?"1":req.getParameter("currentPage"));
            Connection connection = connectMysql.getConnection();
            PreparedStatement ptmt = connection.prepareStatement(sql);
            ptmt.setInt(1,user_id);
            ptmt.setInt(2,user_id);
            ptmt.setInt(3,(currentPage - 1)*5);
            ResultSet rs = ptmt.executeQuery();
            List<ShowDiscuss> discussList = connectMysql.queryToArrayList(rs, ShowDiscuss.userAllMessageExtractor);
            req.setAttribute("discussList",discussList);
            req.getRequestDispatcher("/discuss/index.jsp").forward(req,res);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
