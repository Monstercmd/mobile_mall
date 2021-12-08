package filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AccessControlAllowFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpServletRequest=(HttpServletRequest)request;
        HttpServletResponse httpServletResponse=(HttpServletResponse) response;
        httpServletResponse.setHeader("Access-Control-Allow-Origin","http://localhost:8081");
       httpServletResponse.setHeader("Access-Control-Allow-Credentials","true");
        //支持post请求
        httpServletResponse.setHeader("P3P","CP=CAO PSA OUR");
        if("OPTIONS".equalsIgnoreCase(httpServletRequest.getMethod())) {
            httpServletResponse.setHeader("Access-Control-Allow-Headers", "Content-Type,Origin,Accept");
            httpServletResponse.setHeader("Access-Control-Allow-Methods", "POST,GET,HEAD,PUT,DELETE,TRACE,OPTIONS");
            httpServletResponse.setHeader("Access-Control-Max-Age","18000");
        }
        chain.doFilter(request,response);
    }

    @Override
    public void destroy() {

    }
}
