package comY.servlet;


import comY.dao.sendDiscussDao;
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
@WebServlet("/api/send/discuss")
public class sendDiscussServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String title = req.getParameter("title");
            String txt = req.getParameter("txt");
            Integer user_id = req.getSession().getAttribute("user") == null ? null : ((User) (req.getSession().getAttribute("user"))).getId();
            if(user_id == null){
                res.sendRedirect(req.getContextPath()+"/login.jsp?way=login");
                return;
            }
            checkEmpty.emptyList(title,txt);
            Part part = req.getPart("topics_img");
            String path = getServletContext().getRealPath("/");
            String img_url = getSaveFilePath.saveFile(part, path,"/public/images/image.jpg");
            sendDiscussDao.sendDiscuss(title,txt,user_id,img_url);
            res.sendRedirect(req.getContextPath()+"/user/index.jsp?id="+user_id);
        } catch (Exception e) {
            req.setAttribute("error", e.toString());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }



    }
}
