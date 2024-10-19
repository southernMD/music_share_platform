package comY.servlet;

import comY.dao.sendCommentDao;
import comY.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/send/discuss/comment")
public class sendCommentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req,res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try{
            Integer user_Id = req.getSession().getAttribute("user") == null ? null : ((User) (req.getSession().getAttribute("user"))).getId();
            String textarea = req.getParameter("textarea");
            if(textarea.isEmpty()){
                throw new Exception("评论内容不能为空");
            }
            int discuss_id = Integer.parseInt(req.getParameter("discuss_id"));
            if (user_Id == null) {
                res.sendRedirect(req.getContextPath()+"/login.jsp?way=login");
                return;
            }
            if(sendCommentDao.sendComment(discuss_id, user_Id,textarea)!=1)throw new Exception("评论失败");
            res.sendRedirect(req.getContextPath()+"/discuss/detail.jsp?id="+discuss_id);
        }
        catch (Exception e){
            req.setAttribute("error", e.toString());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }

    }
}
