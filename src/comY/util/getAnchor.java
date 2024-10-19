package comY.util;

import javax.servlet.http.HttpServletRequest;

public class getAnchor {
    public static String getAnchorHandler(HttpServletRequest request) {
        String requestURL = request.getRequestURL().toString();
        String queryString = request.getQueryString();
        String fullURL = requestURL + (queryString != null ? "?" + queryString : "");
        String anchor = "";
        int hashIndex = fullURL.indexOf('#');
        if (hashIndex != -1) {
            anchor = fullURL.substring(hashIndex + 1);
        }

        // 返回锚点
        return anchor;
    }
}
