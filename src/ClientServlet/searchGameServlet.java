package ClientServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import JDBC.DBConnector;
import domain.GameBean;

@WebServlet(name = "SearchGameServlet",urlPatterns = "/SearchGameServlet")
public class searchGameServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				doPost(request, response);
			}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				try {
					String name=request.getParameter("searchname");
					System.out.println("搜索游戏："+name);
					DBConnector DBC=new DBConnector();
					GameBean checkBean=DBC.gameQuery(name);
					if(checkBean!=null)
					{
						response.sendRedirect(name+".jsp");
						return;
					}
					else {
						response.sendRedirect("404.jsp");
						return;
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
	
}
