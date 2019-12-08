package ClientServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;

import JDBC.DBConnector;
import domain.RegisterFormBean;
import domain.UserBean;
import domain.LoginFormBean;
import domain.AdminBean;

@WebServlet(name = "AdminLoginServlet",urlPatterns = "/AdminLoginServlet")
public class adminLoginServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) 
	throws ServletException,IOException
	{
		this.doPost(request, response);
	}
			
	public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException,IOException
	{
		System.out.println("in admin-loginServlet now");
		request.setCharacterEncoding("utf-8");
		response.setHeader("Content-type", "text/html;charset=utf-8");  
		response.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String password=request.getParameter("password");
		if(name.equals("用户名")) name="";
		if(password.equals("密码")) password="";
		//System.out.println(name+"   |   "+password);
		//检查是否有输入
		if(name=="")
		{
			request.setAttribute("adminNameMessage", "请输入管理员账号");
			request.getRequestDispatcher("login.jsp").forward(request, response);
			return;
		}
		if(password=="")
		{
			request.setAttribute("adminPasswordMessage", "请输入管理员密码");
			request.getRequestDispatcher("login.jsp").forward(request, response);
			return;
		}
		try 
		{
			DBConnector DBC=new DBConnector();
			int results=DBC.adminLogin(name, password);
			if(results==1)   //登录成功
			{				
				AdminBean admin=new AdminBean();
				admin.setName(name);
				admin.setPassword(password);
				HttpSession session=request.getSession();
				session.setAttribute("admin", admin);
				
				// 创建Cookie存放Session的标识号
				Cookie cookie = new Cookie("JSESSIONID", session.getId());
				cookie.setMaxAge(60 * 30);
				cookie.setPath("/");
				response.addCookie(cookie);
				System.out.println(session.getId());
				
				response.getWriter().println("登陆成功，1秒后跳转");
				response.setHeader("refresh", "1;url=adminindex.jsp");
				DBC.releaseConnection();
				return;
			}
			else if (results==-1) 
			{
				request.setAttribute("DBMessage", "管理员账号不存在");
				request.getRequestDispatcher("login.jsp").forward(request, response);
				return;
			}
			else 
			{
				request.setAttribute("DBMessage", "密码错误");
				request.getRequestDispatcher("login.jsp").forward(request, response);
				return;
			}
				
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		
	}

}
