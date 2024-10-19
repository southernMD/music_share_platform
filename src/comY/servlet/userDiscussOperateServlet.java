package comY.servlet;

import comY.dao.userDiscussOperateDao;
import comY.entity.User;
import comY.util.getAnchor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebServlet("/api/discuss/op")
public class userDiscussOperateServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req,res);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try{
            String operate = req.getParameter("type");
            int id = Integer.parseInt(req.getParameter("id"));
            Integer user_id = req.getSession().getAttribute("user") == null ? null : ((User) (req.getSession().getAttribute("user"))).getId();
            if (user_id == null) {
                res.sendRedirect(req.getContextPath()+"/login.jsp?way=login");
                return;
            }
            if (operate.equals("1")) {
                userDiscussOperateDao.like(user_id,id );
            } else if (operate.equals("2")) {
                userDiscussOperateDao.dislike( user_id, id);
            }else if(operate.equals("3")){
                userDiscussOperateDao.del_like(user_id,id );
            }else if(operate.equals("4")){
                userDiscussOperateDao.del_dislike(user_id,id );
            }
            //访问前地址
            String path = req.getParameter("path");
            String currentPage = req.getParameter("currentPage");
            System.out.println();
            res.sendRedirect(path + "?id=" + id +"&currentPage=" + ((currentPage==null||currentPage.isEmpty())?1:currentPage));
        }catch (Exception e){
            req.setAttribute("error", e.toString());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }
}
