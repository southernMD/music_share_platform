package comY.servlet;

import comY.entity.User;
import comY.util.checkEmpty;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import comY.dao.commentLikeDao;
import comY.util.getAnchor;

@WebServlet("/api/comment")
public class commentLikeServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
       doPost(req, res);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            String discuss_id = req.getParameter("discuss_id");
            String type = req.getParameter("type");
            User user = (User) req.getSession().getAttribute("user");
            if (user == null) {
                res.sendRedirect(req.getContextPath()+"/login.jsp?way=login");
                return;
            }
            checkEmpty.emptyList(id, type);
           if(type.equals("1")){ commentLikeDao.like(Integer.parseInt(id), user.getId());}
           else if(type.equals("2")){commentLikeDao.unLike(Integer.parseInt(id), user.getId());}
            //#后参数
            String anchor = getAnchor.getAnchorHandler(req);
            res.sendRedirect(req.getContextPath()+"/discuss/detail.jsp?id="+discuss_id+anchor);
        } catch (Exception e) {
            req.setAttribute("error", e.toString());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }
}
