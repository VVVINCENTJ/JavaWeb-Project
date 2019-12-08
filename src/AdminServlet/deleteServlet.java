package AdminServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import JDBC.DBConnector;

@WebServlet(name = "DeleteServlet",urlPatterns = "/DeleteServlet")
public class deleteServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				doPost(request, response);
			}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				try 
				{
					System.out.println("in delete-Servlet");
					String gamename=(String)request.getParameter("gamename");
					System.out.println(gamename);
					DBConnector DBC=new DBConnector();
					boolean check=DBC.deleteGames(gamename);
					if(check)
					{
						response.setHeader("Content-type", "text/html;charset=utf-8");  
						response.setCharacterEncoding("utf-8");
						response.getWriter().println(gamename+"删除成功");
						response.setHeader("refresh", "3;url=productmanagement.jsp");
					}
					else 
					{
						response.setHeader("Content-type", "text/html;charset=utf-8");  
						response.setCharacterEncoding("utf-8");
						response.getWriter().println("数据库异常！"+gamename+"删除失败");
						response.setHeader("refresh", "3;url=productmanagement.jsp");
					}
				} 
				catch (Exception e) 
				{
					e.printStackTrace();
				}
				
				
				
			}

}
