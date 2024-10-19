package comY.servlet;

import comY.dao.updateSongDetailDao;
import comY.entity.User;
import comY.util.checkEmpty;
import comY.util.getSaveFilePath;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;

@MultipartConfig
@WebServlet("/api/update/songs")
public class updateSongDetail extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Integer id = Integer.parseInt(req.getParameter("id"));
            String song_name = req.getParameter("song_name");
            String ar_name = req.getParameter("ar_name");
            String song_url = req.getParameter("song_url");
            String song_lrc = req.getParameter("lrc");
            String song_des = req.getParameter("song_des");
            String img_url = "";
            Integer user_id = req.getSession().getAttribute("user") == null ? null : ((User) (req.getSession().getAttribute("user"))).getId();
            checkEmpty.emptyListCanBeEmpty(String.valueOf(id), song_name, ar_name, song_url, song_lrc, song_des);
            checkEmpty.emptyList(String.valueOf(id));
            Part part = req.getPart("song_img");
            String path = getServletContext().getRealPath("/");
            img_url = getSaveFilePath.saveFile(part, path, "/public/images/image.jpg");
            updateSongDetailDao.updateSongDetail(id, song_name, ar_name, song_url, song_lrc, song_des, img_url,user_id);
            res.sendRedirect("/user/index.jsp?id="+user_id);
        } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
}
