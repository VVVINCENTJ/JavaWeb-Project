package ClientServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminLogoutServlet",urlPatterns = "/AdminLogoutServlet")
public class adminLogoutServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				doPost(request, response);
			}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				// 将Session对象中的admin对象移除
				System.out.println("in admin-logoutServlet");
				request.getSession().removeAttribute("admin");
				response.sendRedirect("login.jsp");
			}
}
