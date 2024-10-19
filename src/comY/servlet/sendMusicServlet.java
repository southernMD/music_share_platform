package comY.servlet;

import comY.dao.changeUserDao;
import comY.dao.sendMusicDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import comY.entity.User;
import comY.util.checkEmpty;
import comY.util.getSaveFilePath;

@MultipartConfig
@WebServlet("/api/send/music")
public class sendMusicServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String song_name = req.getParameter("song_name");
            String ar_name = req.getParameter("ar_name");
            String song_url = req.getParameter("song_url");
            String song_lrc = req.getParameter("song_lrc");
            String song_des = req.getParameter("song_des");
            Integer user_id = req.getSession().getAttribute("user") == null ? null : ((User) (req.getSession().getAttribute("user"))).getId();
            if(user_id == null){
                res.sendRedirect("/login.jsp?way=login");
                return;
            }
            checkEmpty.emptyList(song_name,ar_name,song_url,song_lrc,song_des);
            String img_url = "";
            Part part = req.getPart("song_img");
            String path = getServletContext().getRealPath("/");
            img_url = getSaveFilePath.saveFile(part, path,"/public/images/image.jpg");
            sendMusicDao.sendMusic(song_name,ar_name,song_url,song_lrc,song_des,img_url,user_id);
            res.sendRedirect("/user/index.jsp?id="+user_id);
        }catch (Exception e){
            System.out.println(e);
            req.setAttribute("error", e.toString());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }

    }
}
