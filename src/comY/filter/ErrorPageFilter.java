package comY.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ErrorPageFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) req;
        HttpServletResponse httpRes = (HttpServletResponse) res;

        if (!isForwardOrRedirect(httpReq)) {
            // 如果不是转发或重定向，则重定向到首页
            httpRes.sendRedirect(httpReq.getContextPath() + "/index.jsp");
            return;
        }
        chain.doFilter(req, res);
    }
    private boolean isForwardOrRedirect(HttpServletRequest request) {
        // 检查请求是否来自转发或重定向
        String requestUri = request.getRequestURI();
        String contextPath = request.getContextPath();

        // 检查是否是/error.jsp
        if ("/error.jsp".equals(requestUri.substring(contextPath.length()))) {
            if (request.getAttribute(RequestDispatcher.FORWARD_REQUEST_URI) != null) {
                return true;
            }
            if (request.getAttribute(RequestDispatcher.INCLUDE_REQUEST_URI) != null) {
                return true;
            }
            return false;
        }

        // 不是/error.jsp
        return true;
    }
}
