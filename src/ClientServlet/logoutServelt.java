package ClientServlet;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "LogoutServlet",urlPatterns = "/LogoutServlet")
public class logoutServelt extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				doPost(request, response);
			}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				// 将Session对象中的User对象移除
				request.getSession().removeAttribute("user");
				response.sendRedirect("login.jsp");
			}

}
