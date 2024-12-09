package comY.servlet;

import comY.dao.view.userDao;
import comY.entity.Discuss;
import comY.entity.Song;
import comY.entity.User;
import comY.util.connectMysql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/user/index")
public class getUserServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        Boolean checkFlag  = request.getParameter("id") != null && !request.getParameter("id").isEmpty() && !request.getParameter("id").matches("\\d+");
        int id = checkFlag?-1:Integer.parseInt(request.getParameter("id"));
        try {
            List<User> users = connectMysql.queryToArrayList(userDao.getUserMsg(id), User.userBaseExtractor);
            List<Song> songs = connectMysql.queryToArrayList(userDao.getUserPublicSong(id), Song.userAllMessageExtractor);
            List<Discuss> discuss = connectMysql.queryToArrayList(userDao.getUserPublicDiscuss(id), Discuss.userAllMessageExtractor);
            System.out.println(discuss);
            if(users.isEmpty()){
                throw new SQLException("用户不存在");
            }
            request.setAttribute("songs",songs);
            request.setAttribute("user",users.getFirst());
            request.setAttribute("discusses",discuss);
            request.getRequestDispatcher("/user/index.jsp").forward(request, response);
        }catch (SQLException e){
            request.setAttribute("error", e.toString());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
