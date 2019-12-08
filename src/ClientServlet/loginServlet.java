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

@WebServlet(name = "LoginServlet",urlPatterns = "/LoginServlet")
public class loginServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) 
	throws ServletException,IOException
	{
		this.doPost(request, response);
	}
			
	public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException,IOException
	{
		System.out.println("in loginServlet now");
		request.setCharacterEncoding("utf-8");
		response.setHeader("Content-type", "text/html;charset=utf-8");  
		response.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String password=request.getParameter("password");
		if(name.equals("用户名")) name="";
		if(password.equals("密码")) password="";
		//System.out.println(name+"   |   "+password);
		//检查用户是否有输入
		LoginFormBean lgFormBean=new LoginFormBean();
		lgFormBean.setName(name);
		lgFormBean.setPassword(password);
		//System.out.println(lgFormBean.validate());
		if(!lgFormBean.validate())
		{
			//没有输入用户名或密码
			request.setAttribute("lgFormBean", lgFormBean);
			request.getRequestDispatcher("login.jsp").forward(request, response);
			return;
		}
		
		UserBean user=new UserBean();
		user.setName(name);
		user.setPassword(password);
		user.setEmail("");
		user.setIntro("");
		
		try 
		{
			DBConnector DBC=new DBConnector();
			int results=DBC.userLogin(name, password);
			if(results==1)   //登录成功
			{
				String email=DBC.getEmailFromDB(user.getName());
				if(email.equals(""))
					System.out.println("this user doesn't have an email address");
				user.setEmail(email);
				
				HttpSession session=request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("cartname", "cart-"+user.getName());
				
				// 创建Cookie存放Session的标识号
				Cookie cookie = new Cookie("JSESSIONID", session.getId());
				cookie.setMaxAge(60 * 30);
				cookie.setPath("/");
				response.addCookie(cookie);
				System.out.println(session.getId());
				
				response.getWriter().println("登陆成功，1秒后跳转");
				response.setHeader("refresh", "1;url=index.jsp");
				DBC.releaseConnection();
				return;
			}
			else if (results==-1) 
			{
				request.setAttribute("DBMessage", "用户不存在");
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
