package comY.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import static comY.dao.view.discussDao.getDiscuss;

@WebServlet("/discuss/index")
public class getDiscussServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try {
            ResultSet rs = getDiscuss();
            while (rs.next()){
                request.setAttribute("totalItems",rs.getInt("totalItems"));
                request.setAttribute("currentPage",rs.getInt("currentPage"));
            }
            request.getRequestDispatcher("/discuss/index.jsp").forward(request,response);
        } catch (SQLException e) {
            request.setAttribute("error",e.toString());
            request.getRequestDispatcher("/error.jsp").forward(request,response);
        }
    }
}
