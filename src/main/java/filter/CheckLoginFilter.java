package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 登录过滤
 */
@WebFilter("/CheckLoginFilter")
public class CheckLoginFilter implements Filter {

	private FilterConfig config;

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest myRequest = (HttpServletRequest) request;
		HttpServletResponse myResponse = (HttpServletResponse) response;
		HttpSession session = myRequest.getSession();
		String flag = (String) session.getAttribute("username");

		String path = myRequest.getRequestURI();

		String noLoginPath = config.getInitParameter("noLoginPath");
		if (noLoginPath != null) {
			String[] arr = noLoginPath.split(";");
			for (int i = 0; i < arr.length; i++) {
				if (arr[i] == null || "".equals(arr[i]))
					continue;
				if (path.indexOf(arr[i]) > -1) {
					chain.doFilter(myRequest, myResponse);
					return;
				}
			}
		}


		if (flag == null) {
			myResponse.sendRedirect("loginAndRegister.jsp");
		} else {
			chain.doFilter(myRequest, myResponse);
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
		config = fConfig;
	}

}
