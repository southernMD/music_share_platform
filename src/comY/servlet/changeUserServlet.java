package comY.servlet;

import comY.dao.changeUserDao;
import comY.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.List;


@MultipartConfig
@WebServlet("/api/change/user")
public class changeUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String username = req.getParameter("username");
            String description = req.getParameter("description");
            int id =  Integer.parseInt(req.getParameter("id"));
            changeUserDao.checkUser(username,id);
            String avatar ="";
            Part part = req.getPart("avatar");
            String path = getServletContext().getRealPath("/");
            avatar = changeUserDao.saveFile(part, path,id);
            User user = changeUserDao.changeUser(id, username, description, avatar).getFirst();
            req.getSession().setAttribute("user", user);
            System.out.println(avatar);
            req.getRequestDispatcher("/user/index").forward(req, res);
        }catch (Exception e){
            req.setAttribute("error", e.toString());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }
}
