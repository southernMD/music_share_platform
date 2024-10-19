package comY.servlet;

import com.mysql.cj.MysqlConnection;
import comY.Config;
import comY.entity.Song;
import comY.util.connectMysql;
import comY.dao.searchSongDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

@WebServlet("/api/search/songs")
public class searchSongServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }
    @Override
    public  void  doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try{
            String search = req.getParameter("search");
            int nowPage = req.getParameter("nowPage") == null || req.getParameter("nowPage").isEmpty()?1:Integer.parseInt(req.getParameter("nowPage"));
            List<Song> searchSongs = searchSongDao.searchSong(search,nowPage);
            ResultSet rs = searchSongDao.getSearchSongCount(search);
            while (rs.next()){
                req.setAttribute("totalItems",rs.getObject("totalItems"));
                req.setAttribute("totalPage",rs.getObject("totalPage"));
            }
            req.setAttribute("searchSongs",searchSongs);
            req.setAttribute("search",search);
            req.getRequestDispatcher("/music/index.jsp").forward(req,res);
        }
        catch (Exception e){
            req.setAttribute("error",e);
            req.getRequestDispatcher("/error.jsp").forward(req,res);
        }
    }
}
