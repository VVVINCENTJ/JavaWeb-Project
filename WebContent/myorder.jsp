<%@page import="java.sql.Timestamp"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="com.sun.corba.se.impl.encoding.OSFCodeSetRegistry.Entry"%>
<%@ page import="domain.UserBean" %>
<%@ page import="domain.GameBean" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="JDBC.DBConnector" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>我的订单</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery.min.js"></script>
<!-- Custom Theme files -->
<!--theme-style-->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />	
<!--//theme-style-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!--fonts-->
<link href='http://fonts.useso.com/css?family=Montserrat+Alternates:400,700' rel='stylesheet' type='text/css'>
<link href='http://fonts.useso.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
<!--//fonts-->
</head>
<body> 
<!--header-->	
<div class="header" >
	<div class="top-header" >		
		<div class="container">
		<div class="top-head" >	
			<ul class="header-in">
				<li><a href="#" > 欢迎会员:<span class="highlight">
                        <%
                        	UserBean user=(UserBean)request.getSession().getAttribute("user");
                        	if(user==null)
                        		response.setHeader("Refresh","1;url=login.jsp");
                        	else
                        		out.println(user.getName());
                        %></span>
                        </a></li>
                        <li><a href="LogoutServlet"> 注销</a></li>
                        <li><a href="myshopcart.jsp"> 购物车</a></li>
                        <li><a href="myorder.jsp">我的订单</a></li>
                        <li><a href="mybrowsehistory.jsp">浏览记录</a></li>
			</ul>
			
				<div class="search">
					<form action="SearchGameServlet">
                            <input type="text" name="searchname" value="搜索游戏......" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = '搜索游戏......';}">
                            <input type="submit" value="">
                    </form>
				</div>
			
				<div class="clearfix"> </div>
		</div>
		</div>
	</div>
		<!---->
	
		<div class="header-top">
		<div class="container">
		<div class="head-top">
			<div class="logo">
			<h1><a href="index.jsp"><span> G</span>ames <span>C</span>enter</a></h1>

			</div>
		<div class="top-nav">		
			  <span class="menu"><img src="images/menu.png" alt=""> </span>
				
					<ul>
						<li class="active"><a class="color1" href="index.jsp"  >主页</a></li>
						<li><a class="color2" href="games.jsp"  >游戏</a></li>

						<div class="clearfix"> </div>
					</ul>

					<!--script-->
				<script>
					$("span.menu").click(function(){
						$(".top-nav ul").slideToggle(500, function(){
						});
					});
			</script>

				</div>
				
				<div class="clearfix"> </div>
		</div>
		</div>
	</div>
</div>
<!--banner-->

<!--content-->
	<div class="four">
		<div class="container">	
			<%
				String name=user.getName();
				DBConnector DBC=new DBConnector();
				ResultSet rs=(ResultSet)DBC.getMyOrderInformation(name);
				int current_id=0;//当前订单号
				while(rs.next())
				{
					int order_id=rs.getInt("order_id");
					Timestamp time=rs.getTimestamp("order_time");
					String imgurl=rs.getString("imgurl");
					String description=rs.getString("description");
					int num=rs.getInt("num");
					double price=rs.getDouble("price");
					//System.out.println(order_id+" "+time+" "+imgurl+" "+description+" "+num+" "+price);
					
					if(order_id>current_id)//另外一个订单号的订单记录，先把上个订单的尾部标签补全</tbody> </table> </div> <br>            
					{
						if(current_id==0) //第一个订单的生成，无需补全上个订单的尾部标签,直接开始新订单div、table的生成
						{
							out.println("<div>");
							out.println("<p><span class='orderId'>订单号:"+order_id+ "</span><span class='orderTime'>"+time+"</span></p>");
							out.println("<table class='table table-bordered'>");
							out.println("<thead>");
							out.println("<tr>");
							out.println("<th>Product</th>");
							out.println("<th>Description</th>");
							out.println("<th>Quantity</th>");
							out.println("<th>Price</th>");
							out.println("<th>Total</th>");
							out.println("</tr>");
							out.println("</thead>");
							out.println("<tbody>");   
							//开始根据每一条orders表记录增加<tr>
							out.println("<tr>");
                			out.println("<td> <img src='"+imgurl+"' alt='' width='120'></td>");
                			out.println("<td width='600'><br>"+description+"</td>");
                			out.println("<td><br><br>"+num+"</td>");
                			out.println("<td><br><br>$"+price+"</td>");
                			out.println("<td><br><br>$"+price*num+"</td>");
                			out.println("</tr>");
						}
						else //不是第一个订单，而且与当前订单号不同，是新的订单，要写补全上个订单的尾部标签
						{
							//补全上个订单的尾部标签
							out.println("</tbody>");
							out.println("</table>");
							out.println("</div>");
							out.println("<br>");
							//生成当前新订单的div、table
							out.println("<div>");
							out.println("<p><span class='orderId'>订单号:"+order_id+ "</span><span class='orderTime'>"+time+"</span></p>");
							out.println("<table class='table table-bordered'>");
							out.println("<thead>");
							out.println("<tr>");
							out.println("<th>Product</th>");
							out.println("<th>Description</th>");
							out.println("<th>Quantity</th>");
							out.println("<th>Price</th>");
							out.println("<th>Total</th>");
							out.println("</tr>");
							out.println("</thead>");
							out.println("<tbody>");   
							//开始根据每一条orders表记录增加<tr>
							out.println("<tr>");
                			out.println("<td> <img src='"+imgurl+"' alt='' width='120'></td>");
                			out.println("<td width='600'><br>"+description+"</td>");
                			out.println("<td><br><br>"+num+"</td>");
                			out.println("<td><br><br>$"+price+"</td>");
                			out.println("<td><br><br>$"+price*num+"</td>");
                			out.println("</tr>");
						}
						//将当前订单号更改
						current_id=order_id;
					}
					else if(order_id==current_id) //order_id=current_id,那就继续在<table>的<tbody>中加<tr>
					{
						out.println("<tr>");
            			out.println("<td> <img src='"+imgurl+"' alt='' width='120'></td>");
            			out.println("<td width='600'><br>"+description+"</td>");
            			out.println("<td><br><br>"+num+"</td>");
            			out.println("<td><br><br>$"+price+"</td>");
            			out.println("<td><br><br>$"+price*num+"</td>");
            			out.println("</tr>");
					}	
					else// order_id<current_id
					{
						//错误信息，不做处理，正常来说是不会出现这种情况的
					}
				}
				//最后手动补全最后一个订单的尾部标签，忘了+1
				out.println("</tbody>");
				out.println("</table>");
				out.println("</div>");
				out.println("<br>");
				DBC.releaseConnection();
				//System.out.println(" JSP Page完成 ");
			%>
			
            
		</div>
	</div>
	
	<!---->
    <div class="footer">
        <div class="footer-middle">
            <div class="container">
                <div class="footer-middle-in">
                    <h6>About us</h6>
                    <p>VincentJ from SCUT</p>
                </div>
                <div class="footer-middle-in">
                    <h6>Information</h6>
                    <ul>
                        <li><a href="#">(ಡωಡ) (ಡωಡ)</a></li>
                        <li><a href="#">(ಡωಡ) (ಡωಡ)</a></li>
                        <li><a href="#">(ಡωಡ) (ಡωಡ)</a></li>
                        <li><a href="#">(ಡωಡ) (ಡωಡ)</a></li>
                    </ul>
                </div>
                <div class="footer-middle-in">
                    <h6>Customer Service</h6>
                    <ul>
                        <li><a href="#">(ಡωಡ)(ಡωಡ)(ಡωಡ)</a></li>
                        <li><a href="#">(ಡωಡ)(ಡωಡ)(ಡωಡ)</a></li>
                        <li><a href="#">(ಡωಡ)(ಡωಡ)(ಡωಡ)</a></li>
                    </ul>
                </div>
                <div class="footer-middle-in">
                    <h6>My Account</h6>
                    <ul>
                        <li><a href="#">(ಡωಡ) (ಡωಡ)</a></li>
                        <li><a href="#">(ಡωಡ) (ಡωಡ)</a></li>
                        <li><a href="#">(ಡωಡ) (ಡωಡ)</a></li>
                    </ul>
                </div>
                <div class="footer-middle-in">
                    <h6>Extras</h6>
                    <ul>
                        <li><a href="#">(ಡωಡ)</a></li>
                        <li><a href="#">(ಡωಡ)</a></li>
                    </ul>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
    </div>

</body>
</html>








