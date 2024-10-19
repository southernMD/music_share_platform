package comY.filter;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class TemplateFilter implements Filter {


    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) req;
        HttpServletResponse httpResponse = (HttpServletResponse) res;

        String requestURI = httpRequest.getRequestURI();
        System.out.print(requestURI);
        if (requestURI.startsWith("/template/")) {
            httpResponse.sendRedirect("/");
            return;
        }

        // 继续处理其他请求
        chain.doFilter(req, res);
    }
}
