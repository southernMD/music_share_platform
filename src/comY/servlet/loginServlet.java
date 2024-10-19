package comY.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import comY.dao.loginDao;
import comY.entity.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/api/login")
public class loginServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //转发请求
        //拿到在form内的 menth=post 元素
        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            if(username == null || password == null){
                req.setAttribute("error", "请求错误:用户名或密码为空");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
            }
            User sessionUserMessage = loginDao.login(username, password);
            HttpSession session = req.getSession();
            if (session != null && session.getAttribute("username") != null) {
                // 用户已登录
                res.sendRedirect("/");
            } else {
                // 用户未登录
                req.getSession().setAttribute("user",sessionUserMessage);
                //过期时间设置为2天
                req.getSession().setMaxInactiveInterval(60 * 60 * 24 * 2);
                res.sendRedirect("/");
            }
        } catch (SQLException e) {
            req.setAttribute("error", "请求错误:" + e.toString());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }

    }

}
