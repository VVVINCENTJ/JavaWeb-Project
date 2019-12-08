package ClientServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

import JDBC.DBConnector;
import domain.RegisterFormBean;
import domain.UserBean;

@WebServlet(name = "RegisterServlet",urlPatterns = "/RegisterServlet")
public class registerServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) 
	throws ServletException,IOException
	{
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException,IOException
	{
		System.out.println("in registerServlet now");
		request.setCharacterEncoding("utf-8");
		response.setHeader("Content-type", "text/html;charset=utf-8");  
		response.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String password=request.getParameter("password");
		String password2=request.getParameter("password2");
		String email=request.getParameter("email");
		String intro=request.getParameter("intro");
		
		if(name.equals("用户名")) name="";
		if(password.equals("密码")) password="";
		if(password2.equals("再次输入密码")) password2="";
		if(email.equals("邮箱地址")) email="";
		if(intro.equals("个人介绍"))	intro="";//用户没有输入个人介绍，设为空
		System.out.println(name+"  |  "+password+"   |   "+password2+"   |    "+email+"   |   "+intro);
		
		//检查用户输入格式以及两次密码是否正确,先不检查用户是否已存在
		RegisterFormBean rgtFormBean=new RegisterFormBean();
		rgtFormBean.setName(name);
		rgtFormBean.setPassword(password);
		rgtFormBean.setPassword2(password2);
		rgtFormBean.setEmail(email);
		rgtFormBean.setIntro(intro);
		if(!rgtFormBean.validate())
		{
			//输入不合规范执行以下
			request.setAttribute("rgtFormBean", rgtFormBean);
			request.getRequestDispatcher("register.jsp").forward(request,response);
			return;
		}
		//连接数据库，检查用户是否已经存在
		try 
		{
			DBConnector DBC=new DBConnector();
			boolean exist=DBC.userQuery(name);
			//用户已存在
			if(exist)
			{
				request.setAttribute("DBMessage", "用户名已存在");
				request.setAttribute("rgtFormBean", rgtFormBean);
				request.getRequestDispatcher("register.jsp").forward(request,response);
				DBC.releaseConnection();
				//return;
			}
			//注册成功
			else 
			{
				/*
				 * UserBean user=new UserBean(); user.setName(name); user.setPassword(password);
				 * user.setEmail(email); user.setIntro(intro);
				 */
				DBC.userInsert(name, password, email, intro);
				response.getWriter().print("注册成功，3秒钟后自动跳转");
				//request.getSession().setAttribute("user", user);
				response.setHeader("refresh", "3;url=login.jsp");
				DBC.releaseConnection();
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
	}

}
