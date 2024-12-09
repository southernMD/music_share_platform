package comY.servlet;

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

import comY.dao.view.musicDetailDao;

@WebServlet("/music/detail")
public class getMusicDetail extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            List<Song> songs = connectMysql.queryToArrayList(musicDetailDao.getMusicDetail(id), Song.userAllMessageExtractor);
            List<User> users = connectMysql.queryToArrayList(musicDetailDao.getMusicPublicDetail(songs.getFirst().getUser_id()), User.userBaseExtractor);
            request.setAttribute("publisher",users.getFirst());
            request.setAttribute("song",songs.getFirst());
            request.getRequestDispatcher("/music/detail.jsp").forward(request,response);
        } catch (SQLException e) {
            request.setAttribute("error", e.toString());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
