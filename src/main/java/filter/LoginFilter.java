package filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(value = {"/*"})
public class LoginFilter extends HttpFilter{

	@Override
	protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		String urlString = request.getRequestURL().toString();
		
		// 放行條件
		if(urlString.endsWith("login.jsp") 
				|| urlString.endsWith("login")
				|| urlString.endsWith("Register")
				|| urlString.endsWith("Register.jsp")
				|| urlString.endsWith("test.jsp")
				|| urlString.indexOf("/images")>=0 
				|| urlString.indexOf("/css")>=0 
				|| urlString.endsWith(".js") ) {
			chain.doFilter(request, response);
			return;
		}
		
		// 檢查是否登入
		HttpSession session = request.getSession();
		boolean isLogin = session.getAttribute("isLogin") == null 
				? false: (boolean)session.getAttribute("isLogin");
		if(!isLogin) {
			response.sendRedirect("/Calendar/login.jsp");
			return;
		}
		
		chain.doFilter(request, response);
	}
}
