package ClientServlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;

import com.sun.xml.internal.bind.v2.runtime.Name;

import javax.servlet.annotation.WebServlet;

/*import java.util.ArrayList;
import java.util.List;*/
import java.util.HashMap;
import java.util.Map;

import domain.GameBean;
import domain.UserBean;
import JDBC.DBConnector;

@WebServlet(name = "AddToCartServlet",urlPatterns = "/AddToCartServlet")
public class addToCartServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) 
			throws HTTPException,IOException, ServletException
			{
				doPost(request, response);
			}
	public void doPost(HttpServletRequest request,HttpServletResponse response) 
			throws HTTPException,IOException, ServletException
			{
				String gamename=request.getParameter("game_name");
				//点击游戏详情页面的“加入购物车”后正常，其他方式跳转到Servlet的直接返回
				if(gamename==null)
				{
					String url=request.getContextPath()+"/games.jsp";
					response.sendRedirect(url);
					return;
				}
				System.out.println(gamename);
				
				//根据游戏名，查询DB，创建GameBean对象
				DBConnector DBC;
				GameBean gmBean=new GameBean(); //在try中声明定义会当成局部变量，要现在外面声明
				try {
					DBC = new DBConnector();
					gmBean=DBC.gameQuery(gamename);
				} catch (SQLException e) 
				{
					e.printStackTrace();
				}
				
				HttpSession session=request.getSession();
				UserBean user=(UserBean)session.getAttribute("user");
				String username=user.getName();
				Map<String, Integer> cart=(Map<String, Integer>)session.getAttribute("cart-"+username);   //游戏名字----数量
				if(cart==null)
				{
					cart=new HashMap<String, Integer>();
					System.out.println("没有购物车，那就创建一个呗");
				}
				if(gmBean.getInventory()>0)
				{
					//库存>0,可以加入购物车
					Integer count=cart.put(gamename,1);
					//之前已经将该类商品加进过购物车额。那就数量+1，否则就数量设为1
					if(count!=null)
					{	
						cart.put(gamename,count+1);
					}
					System.out.println(cart.get(gamename));
					
					session.setAttribute("cart-"+username, cart);
					request.setAttribute("addGamesMessage", gamename+"已加入购物车");
					request.getRequestDispatcher(gamename+".jsp").forward(request, response);
					return;
				}
				else
				{
					//库存不足，无法加入购物车
					session.setAttribute("cart", cart);
					request.setAttribute("addGamesMessage", "库存不足，无法加入购物车");
					request.getRequestDispatcher(gamename+".jsp").forward(request, response);
					return;
				}
			
		/*List<GameBean> cart=(List) session.getAttribute("cart");
		if(cart==null)
		{
			//用户第一次将商品加入购物车，创建一个cart并存入session
			cart=new ArrayList<GameBean>();
			session.setAttribute("cart", cart);
			System.out.println("没有购物车，那就创建一个呗");
		}
		if(gmBean.getInventory()>0)
		{
			///库存>0,可以加入购物车
			cart.add(gmBean);
			request.setAttribute("addGamesMessage", gamename+"已加入购物车");
			request.getRequestDispatcher(gamename+".jsp").forward(request, response);
			return;
		}
		else 
		{
			//库存不足，无法加入购物车
			request.setAttribute("addGamesMessage", "库存不足，无法加入购物车");
			request.getRequestDispatcher(gamename+".jsp").forward(request, response);
			return;
		}				*/	
				
			}
	

}
