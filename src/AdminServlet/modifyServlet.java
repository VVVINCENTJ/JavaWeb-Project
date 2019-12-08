package AdminServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import JDBC.DBConnector;
import domain.GameBean;

@WebServlet(name = "ModifyServlet",urlPatterns = "/ModifyServlet")
public class modifyServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				doPost(request, response);
			}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException
			{
				request.setCharacterEncoding("utf-8");
				response.setHeader("Content-type", "text/html;charset=utf-8");  
				response.setCharacterEncoding("utf-8");
				try 
				{
					System.out.println("in modify Servlet");
					String gamename=(String)request.getParameter("gamename");
					String price=(String)request.getParameter("price");
					if(price.equals("价格(请输入阿拉伯数字，可有小数)")) 
						price="-1";
					String inventory=(String)request.getParameter("inventory");
					if(inventory.equals("库存（请输入一个整数）")) 
						inventory="-1";
					String imgurl=(String)request.getParameter("imgurl");
					String description=(String)request.getParameter("description");
					System.out.println(gamename+"  |  "+price+"  |  "+inventory+"  |  "+imgurl+"  |  "+description);
				
				
					DBConnector DBC=new DBConnector();
					GameBean gameBean=DBC.gameQuery(gamename);
					Double priceDouble=Double.valueOf(price);  //先将String转为Double
					Integer inventoryInteger=Integer.valueOf(inventory);//先将String转为Integer
					
					if(priceDouble!=-1)  //用户有输入新的price
						gameBean.setPrice(priceDouble);
					if(inventoryInteger!=-1)//用户有输入新的inventory
						gameBean.setInventory(inventoryInteger);
					if(!imgurl.equals("图片的路径"))//用户有输入新的imgurl
						gameBean.setImgurl(imgurl);
					if(!description.equals("商品描述"))//用户有输入新的description
						gameBean.setDescription(description);
					
					
					boolean check=DBC.gameUpdate(gameBean);
					if(check)
					{	
						//System.out.println("修改成功");
						response.getWriter().println("修改成功");
						response.setHeader("refresh", "3;url=productmanagement.jsp");
					
					}
					else 
					{
						response.getWriter().println("数据库更新数据出错");
						response.setHeader("refresh", "3;url=productmanagement.jsp");
					}					
				} 
				catch (Exception e) 
				{
					response.getWriter().println("出错啦，请确保“价格”以及“库存量”值输入类型是正确的！");
					response.setHeader("refresh", "3;url=productmanagement.jsp");
					e.printStackTrace();
					
				}

			}
}
