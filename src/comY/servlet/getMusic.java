package comY.servlet;

import comY.entity.Song;
import comY.util.connectMysql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import comY.dao.view.musicDao;

@WebServlet("/music/index")
public class getMusic extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if (request.getAttribute("search") == null){
                int nowPage = request.getParameter("currentPage") == null || request.getParameter("currentPage").isEmpty()?1:Integer.parseInt(request.getParameter("currentPage"));
                List<Song> songs = connectMysql.queryToArrayList(musicDao.getMusic(nowPage), Song.userAllMessageExtractor);
                ResultSet rs = musicDao.getMusicCount();
                while (rs.next()){
                    request.setAttribute("totalItems",rs.getInt("totalItems"));
                    request.setAttribute("totalPage",rs.getInt("totalPage"));
                }
                request.setAttribute("songs",songs);
                request.getRequestDispatcher("/music/index.jsp").forward(request,response);
            }
        } catch (SQLException e) {
            request.setAttribute("error",e);
            request.getRequestDispatcher("/error.jsp").forward(request,response);
        }
    }
}
