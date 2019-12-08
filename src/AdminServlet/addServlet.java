package AdminServlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.management.Descriptor;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import JDBC.DBConnector;
import domain.GameBean;

@WebServlet(name = "AddServlet",urlPatterns = "/AddServlet")
public class addServlet extends HttpServlet{
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
				
				System.out.println("in add-servlet");
				try {
					Map<String, String> errors = new HashMap<String, String>(); //记录错误信息
					String gamename=request.getParameter("gamename");
					String price=request.getParameter("price");
					String inventory=request.getParameter("inventory");
					String imgurl=request.getParameter("imgurl");
					String description=request.getParameter("description");
					
					boolean valid=true;
					Double priceDouble=-1.0;   //initialize
					Integer inventoryInteger=-1; //initialize
					DBConnector DBC=new DBConnector();
					if(gamename.equals("游戏名(必须)"))
					{
						valid=false;
						errors.put("gamename", "请输入游戏名");
					}
					else 
					{
						//检查游戏名是否已经存在
						GameBean gameexist=DBC.gameQuery(gamename);
						if(gameexist!=null)
						{
							valid=false;
							errors.put("exist", "相关的游戏已存在");
						}
					}
					if(price.equals("价格(必须)"))
					{
						valid=false;
						errors.put("price","请输入价格");
					}
					else 
					{
						priceDouble=Double.valueOf(price);
					}
					if(inventory.equals("库存量(必须)"))
					{
						valid=false;
						errors.put("inventory", "请输入库存量");
					}
					else 
					{
						inventoryInteger=Integer.valueOf(inventory);
					}
					if(imgurl.equals("图片的路径(非必须)"))
						imgurl="";
					if(description.equals("游戏描述(非必须)"))
						description="";
					
					if(!valid)//三个必须中有的没填就返回
					{
						request.setAttribute("errors", errors);
						request.getRequestDispatcher("addproduct.jsp").forward(request, response);
						return;
					}
					GameBean gameBean=new GameBean();
					gameBean.setName(gamename);
					gameBean.setPrice(priceDouble);
					gameBean.setInventory(inventoryInteger);
					gameBean.setImgurl(imgurl);
					gameBean.setDescription(description);
					gameBean.setSales(0);
					gameBean.setViews(0);
					
					
					boolean check=DBC.insertGames(gameBean);
					if(check)
					{
						response.getWriter().println("新增游戏成功");
						response.setHeader("refresh", "3;url=productmanagement.jsp");
						DBC.releaseConnection();
						return;
					}
					else 
					{
						response.getWriter().println("出错啦，插入数据失败");
						response.setHeader("refresh", "3;url=addproduct.jsp");
						DBC.releaseConnection();
						return;
					}
							
				} 
				catch (Exception e) {
					response.getWriter().println("出错啦，请确保“价格”以及“库存量”值输入类型是正确的！");
					response.setHeader("refresh", "3;url=addproduct.jsp");
					e.printStackTrace();
				}
			}
}
