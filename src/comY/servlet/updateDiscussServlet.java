package comY.servlet;

import comY.dao.updateDiscussDao;
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
@WebServlet("/api/update/discuss")
public class updateDiscussServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try{
            Integer publicer_id = req.getSession().getAttribute("user") == null ? null : ((User) (req.getSession().getAttribute("user"))).getId();
            if (publicer_id == null) {
                res.sendRedirect(req.getContextPath()+"/login.jsp?way=login");
                return;
            }
            String title = req.getParameter("title");
            String id = req.getParameter("id");
            String discuss_main = req.getParameter("discuss_main");
            checkEmpty.emptyListCanBeEmpty(title,id,discuss_main);
            checkEmpty.emptyList(id);
            Part part = req.getPart("discuss_img");
            String path = getServletContext().getRealPath("/");
            String discuss_img = getSaveFilePath.saveFile(part, path, "/public/images/image.jpg");
            updateDiscussDao.updateDiscuss(Integer.parseInt(id),title,discuss_img,discuss_main,publicer_id);
            res.sendRedirect(req.getContextPath()+"/user/index.jsp?id="+publicer_id);
        }catch (Exception e){
                System.out.println(e);
                req.setAttribute("error", e.toString());
                req.getRequestDispatcher("/error.jsp").forward(req, res);
            }
        }

}
