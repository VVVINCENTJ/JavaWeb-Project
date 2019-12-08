package JDBC;

import java.sql.*;
import domain.GameBean;

public class DBConnector {
	private Statement stmt = null;
	private ResultSet rs = null;
	private Connection conn = null;
	private PreparedStatement  preStmt=null;
	
	public  DBConnector() throws SQLException {
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			//通过DriverManager获取数据库连接
			String url = "jdbc:mysql://localhost:3306/games_center?useUnicode=true&characterEncoding=utf8";
			String username = "root";
			String password = "0771";
			conn = DriverManager.getConnection (url, username, password);
			if(conn==null)
				System.out.println("数据库连接失败");
			stmt = conn.createStatement();
		} catch (ClassNotFoundException e) 
		{
			e.printStackTrace();
		}		
	}
	
	//检查用户是否已经存在
	public boolean userQuery(String name) throws SQLException
	{
		String sql="select * from users where username='"+name+"'";
		rs=stmt.executeQuery(sql);//true表示sql语句有查询结果
		 if (!rs.next()) 
		 {
			    //rs为空时执行的内容...
			  //用户不存在
			  return false;
		}
		 else 
		{
			    //rs不为空时执行的内容...
				 rs.previous();
				 //用户存在
				 return true;
		}
	}
	//管理员登录
	public int adminLogin(String name,String password) throws SQLException
	{
		String sql="select * from admins where name='"+name+"'";
		rs=stmt.executeQuery(sql);//true表示sql语句有查询结果
		 if (!rs.next()) 
		 {
			  //管理员不存在
			  return -1;
		}
		 else 
		{
			//管理员存在,比较密码
			 String pass=rs.getString("password");
			 if(password.equals(pass))
				 return 1;             //密码正确 登录成功
			 else 
				return 0;	           //密码错误
		}
	}
	
	//用户登录
	public int userLogin(String name,String password) throws SQLException
	{
		String sql="select * from users where username='"+name+"'";
		rs=stmt.executeQuery(sql);//true表示sql语句有查询结果
		 if (!rs.next()) 
		 {
			  //用户不存在
			  return -1;
		}
		 else 
		{
			//用户存在,比较密码
			 String pass=rs.getString("password");
			 if(password.equals(pass))
				 return 1;             //密码正确 登录成功
			 else 
				return 0;	           //密码错误
		}
	}
	
	//向users表插入用户信息
	public boolean userInsert(String name,String password,String email,String intro) throws SQLException
	{
		String sql="insert into users(username,password,email,intro) values(?,?,?,?)";
		preStmt=conn.prepareStatement(sql);
		preStmt.setString(1, name);
		preStmt.setString(2, password);
		preStmt.setString(3, email);
		preStmt.setString(4, intro);
		int res=preStmt.executeUpdate();
		if(res==1)
			return true;
		else 
			return false;
		
	}
	//用户登陆成功后，从DB中获取邮箱地址
	public String getEmailFromDB(String name) throws SQLException
	{
		String sql="select email from users where username=?";
		preStmt=conn.prepareStatement(sql);
		preStmt.setString(1, name);
		rs=preStmt.executeQuery();
		if (!rs.next()) 
		 {
			  //用户不存在
			 return "";
		}
		 else 
		{
			//用户存在,比较密码
			String em=rs.getString("email");
			//System.out.println(em);
			return em;
		}
	}
	//根据game-name查询数据库返回GameBean对象
	public GameBean gameQuery(String name) throws SQLException
	{
		String sql="select * from games where name=?";
		preStmt=conn.prepareStatement(sql);
		preStmt.setString(1, name);
		rs=preStmt.executeQuery();
		if (!rs.next()) 
		 {
			  //结果不存在
			 return null;
		}
		 else 
		{
			//结果存在
			int id=rs.getInt("id");
			double price=rs.getDouble("price");
			int inventory=rs.getInt("inventory");
			String description=rs.getString("description");
			String imgurl=rs.getString("imgurl");
			int sales=rs.getInt("sales");
			int views=rs.getInt("views");
			
			GameBean gmBean=new GameBean();
			gmBean.setId(id);
			gmBean.setName(name);
			gmBean.setPrice(price);
			gmBean.setInventory(inventory);
			gmBean.setSales(sales);
			gmBean.setViews(views);
			gmBean.setDescription(description);
			gmBean.setImgurl(imgurl);
			return gmBean;
		}
		
	}
	//根据传入的GameBean对象更新DB中相应的记录(除了id之外都可以改)
	public boolean gameUpdate(GameBean gmBean) throws SQLException
	{
		int id=gmBean.getId();
		String name=gmBean.getName();
		double price=gmBean.getPrice();
		int inventory=gmBean.getInventory();
		String description=gmBean.getDescription();
		String imgurl=gmBean.getImgurl();
		int sales=gmBean.getSales();
		int views=gmBean.getViews();
		
		String sql="update `games` set name=?,price=?,inventory=?,description=?,imgurl=?,sales=?,views=? where id=?";
		preStmt=conn.prepareStatement(sql);
		preStmt.setString(1, name);
		preStmt.setDouble(2, price);
		preStmt.setInt(3, inventory);
		preStmt.setString(4, description);
		preStmt.setString(5, imgurl);
		preStmt.setInt(6, sales);
		preStmt.setInt(7, views);
		preStmt.setInt(8, id);
		int effectrows=preStmt.executeUpdate();
		if(effectrows==1)
		{
			return true;
		}
		else 
		{
			return false;
		}
	}
	//insert新增一行games表记录
	public boolean insertGames(GameBean gameBean) throws SQLException
	{	
		String sqlString="insert into games(name,price,inventory,imgurl,description,sales,views) values(?,?,?,?,?,?,?)";
		preStmt=conn.prepareStatement(sqlString);
		preStmt.setString(1, gameBean.getName());
		preStmt.setDouble(2, gameBean.getPrice());
		preStmt.setInt(3, gameBean.getInventory());
		preStmt.setString(4, gameBean.getImgurl());
		preStmt.setString(5, gameBean.getDescription());
		preStmt.setInt(6, gameBean.getSales());
		preStmt.setInt(7, gameBean.getViews());
		int res=preStmt.executeUpdate();
		if(res==1)
			return true;
		else
			return false;
		
	}
	//更改DB中games的浏览量views
	public boolean gamesUpdateViews(GameBean gmBean) throws SQLException
	{
		int id=gmBean.getId();
		int views=gmBean.getViews();
		
		String sql="update `games` set views=? where id=?";
		preStmt=conn.prepareStatement(sql);
		preStmt.setInt(1, views);
		preStmt.setInt(2, id);
		int effectrows=preStmt.executeUpdate();
		if(effectrows==1)
			return true;
		else {
			return false;
		}
		
	}

	/*//更改DB中games的销售量sales
	public boolean gamesUpdateSales(GameBean gmBean) throws SQLException
	{
		int id=gmBean.getId();
		int sales=gmBean.getSales();
		
		String sql="update `games` set sales=? where id=?";
		preStmt=conn.prepareStatement(sql);
		preStmt.setInt(1, sales);
		preStmt.setInt(2, id);
		int effectrows=preStmt.executeUpdate();
		if(effectrows==1)
			return true;
		else {
			return false;
		}
	}*/
	//获取当前最大的order_id
	public int getMaxOrderId() throws SQLException
	{
		String sql="select * from ordertime order by order_id DESC";
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		if(rs.next())
		{
		  int id1=rs.getInt("order_id");
		  return id1;
		}
	 	else {
		  return 0;
	 	}
	}
	//插入新的订单号到ordertime表中
	public boolean insertOrderTime(int order_id) throws SQLException
	{
		String sql="insert into ordertime(order_id) values(?)";
		preStmt=conn.prepareStatement(sql);
		preStmt.setInt(1, order_id);
		int res=preStmt.executeUpdate();
		if(res==1)
			return true;
		else {
			return false;
		}
	}
	//将一条订单信息插入orders表中
	public boolean insertOrders(int order_id,String username,int game_id,int num) throws SQLException
	{
		String sql="insert into orders values(?,?,?,?)";
		preStmt=conn.prepareStatement(sql);
		preStmt.setInt(1, order_id);
		preStmt.setString(2, username);
		preStmt.setInt(3, game_id);
		preStmt.setInt(4, num);
		int res=preStmt.executeUpdate();
		if(res==1)
			return true;
		else
			return false;
		
	}
	//根据用户名获得形成'我的订单'页面所需的信息Resultset
	public ResultSet getMyOrderInformation(String name) throws SQLException
	{
		String sql="select orders.order_id,ordertime.order_time,games.imgurl,games.description,orders.num,games.price from orders,ordertime,games " + 
				"where orders.order_id=ordertime.order_id and games.id=orders.game_id and orders.username=?";
		preStmt=conn.prepareStatement(sql);
		preStmt.setString(1, name);
		rs=preStmt.executeQuery();
		return rs;
		
	}
	//获得games表的信息的Resultset，用于销售情况的页面生成
	public ResultSet getGamesInformation()throws SQLException
	{
		String sql="select * from games";
		preStmt=conn.prepareStatement(sql);
		rs=preStmt.executeQuery();
		return rs;
	}
	//根据游戏名字从数据库中删除
	public boolean deleteGames(String name) throws SQLException
	{
		String sql="delete from games where name=?";
		preStmt=conn.prepareStatement(sql);
		preStmt.setString(1, name);
		int res=preStmt.executeUpdate();
		if(res==1)
			return true;
		else 
			return false;
	}
	//释放连接
	public void releaseConnection()
	{
		if(rs!=null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			rs = null;
		}
		if(stmt!=null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			stmt = null;
		}
		if(conn!=null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			conn = null;
		}
	}
		
	

}
