package ClientServlet;
import java.awt.print.Printable;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;

import org.eclipse.jdt.internal.compiler.ast.ThrowStatement;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import domain.GameBean;
import domain.UserBean;
import JDBC.DBConnector;

@WebServlet(name = "PayServlet",urlPatterns = "/PayServlet")
public class payServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) 
			throws HTTPException,IOException, ServletException
			{
				doPost(request, response);
			}
	public void doPost(HttpServletRequest request,HttpServletResponse response) 
			throws HTTPException,IOException, ServletException
			{
				HttpSession session=request.getSession();
				UserBean user=(UserBean)session.getAttribute("user");
				String cartname="cart-"+user.getName();
				System.out.println(cartname);
				Map<String, Integer> cart=(Map<String, Integer>)session.getAttribute(cartname);
				if(cart==null || cart.isEmpty()) //购物车为空或没有用户车
				{
					response.setHeader("Content-type", "text/html;charset=utf-8");  
					response.setCharacterEncoding("utf-8");
					response.getWriter().println("购物车为空,无法完成支付");
					response.setHeader("refresh", "1;url=games.jsp");
					System.out.println("购物车为空,无法完成支付");
					return;
				}
				else //购物车不为空
				{
					DBConnector DBC=null;
        			GameBean gameBean=null;
        			int current_order_id=0;
        			try {
						DBC=new DBConnector();
						current_order_id=DBC.getMaxOrderId()+1;  //订单号从1开始，逐渐加1
						boolean checkInsert=DBC.insertOrderTime(current_order_id);
						if(checkInsert)
							System.out.println("Insert into OrderTime succeed");
						else {
							System.out.print("Insert into OrderTime fail");
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					//开始处理购买订单
					Iterator<Map.Entry<String, Integer>> it=cart.entrySet().iterator();
					while(it.hasNext())
					{
						Map.Entry<String, Integer> entry=it.next();
						
						String name=entry.getKey();
            			Integer count=entry.getValue();	
            			try 
            			{
							gameBean=DBC.gameQuery(name);
						} 
            			catch (Exception e) 
            			{
							e.printStackTrace();
						}
            			if(gameBean==null)
            			{
            				System.out.println(name+"：该商品不存在，已跳过");
            			}
            			else 
            			{
            				int inventory=gameBean.getInventory();
            				int sales=gameBean.getSales();
            				if(inventory>=count)
            				{
            					//库存量足，可以购买
            					gameBean.setInventory(inventory-count);
            					gameBean.setSales(sales+count);
            					//更新数据库games表
            					boolean checkupdate=false;
            					try {
            						checkupdate=DBC.gameUpdate(gameBean);
								} catch (Exception e) {
									e.printStackTrace();
								}
            					if(checkupdate)
            						System.out.println(name+" || update games succeed");
            					else {
            						System.out.println(name+" || update games fail");
								}
            					//更新数据库orders表
            					try {
            						checkupdate= DBC.insertOrders(current_order_id, user.getName(), gameBean.getId(), count);
            						if(checkupdate)
            							System.out.println("insert orders succeed");
            						else
            							System.out.println("insert orders fail");
								} catch (Exception e) {
									e.printStackTrace();
								}
            					//从cart中移除
            					it.remove();
            					System.out.println(name+"被移出购物车啦!");
            				}
            				else 
            				{
            					//库存不足，无法购买，跳过该游戏的购买，仍保留在cart中
            					request.setAttribute("PayMessage", "因部分商品库存不足，已跳过相关商品的购买");
            					System.out.println("因部分商品库存不足，已跳过相关商品的购买");
						
							}
						}
					}
        			
					//↑map 遍历完成
					//订单处理完后，用新的cart覆盖session中旧的cart
					session.setAttribute("cart", cart);
					//记得释放连接
					DBC.releaseConnection();
			/*response.setHeader("Content-type", "text/html;charset=utf-8");  
			response.setCharacterEncoding("utf-8");
			response.getWriter().println("支付中，请等待");
			request.getRequestDispatcher("SendMailServlet").forward(request, response);*/
					request.getRequestDispatcher("SendMailServlet").forward(request, response);
				}
				
				
			}

	
	
	
	
	
	
	
	
	
}
