package comY.servlet;

import comY.dao.loginDao;
import comY.dao.regDao;
import comY.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/api/reg")
public class regServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
       doPost(req, res);
    }
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password1 = req.getParameter("password1");
        String password2 = req.getParameter("password2");
        if(username == null || password1 == null || password2 == null){
            req.setAttribute("error", "请求错误:用户名或密码为空");
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }else{
            if(!password1.equals(password2)){
                req.setAttribute("error", "请求错误:两次密码不一致");
                req.getRequestDispatcher("/error.jsp").forward(req, res);
            }else{
                try {
                    User sessionUserMessage = regDao.Reg(username,password1);
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
                    req.setAttribute("error", e.toString());
                    req.getRequestDispatcher("/error.jsp").forward(req, res);
                }
            }
        }
    }
}
