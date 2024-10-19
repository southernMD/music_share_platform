package comY.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class RedirectFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String currentPage = httpRequest.getParameter("currentPage") == null || httpRequest.getParameter("currentPage").isEmpty()?"1":httpRequest.getParameter("currentPage");
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/api/discuss/list?currentPage="+currentPage);
    }
}
