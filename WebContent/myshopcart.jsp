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
<title>我的购物车</title>
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
			<table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Description</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                	<%
                		String cartname="cart-"+user.getName();
                		Map<String, Integer> cart=(Map<String, Integer>)session.getAttribute(cartname);   
                		out.println("<p color='blue'>购物车</p>");
                		if(cart!=null)
                		{	
                			double total=0;
                			DBConnector DBC=null;
                			for(Map.Entry<String,Integer> entry: cart.entrySet())//遍历购物车
	                		{
	                			String name=entry.getKey();
	                			Integer count=entry.getValue();
	                			DBC=new DBConnector();
	                			GameBean gameBean=DBC.gameQuery(name);
	                			if(gameBean!=null)//数据库中可以找到相关游戏的信息
	                			{
	                				total+=gameBean.getPrice()*count;
		                			out.println("<tr>");
		                			out.println("<td> <img src='"+gameBean.getImgurl()+"' alt='' width='120'></td>");
		                			out.println("<td width='600'><br>"+gameBean.getDescription()+"</td>");
		                			out.println("<td>");
		                			out.println("<div class='input-append'><br><br>");
		                			out.println("<input class='span1' style='max-width:34px' placeholder='"+count+"' id='appendedInputButtons' size='16' type='text' disabled='disabled'>");
		                			out.println("<button class='btn' type='button'><b>-</b></button>");
		                			out.println("<button class='btn' type='button'><b>+</b></button>");
		                			out.println("<button class='btn btn-danger' type='button'><b>X</b></button> ");
		                			out.println("</div>");
		                			out.println("</td>");
		                			out.println("<td><br><br>$"+gameBean.getPrice()+"</td>");
		                			out.println("<td><br><br>$"+gameBean.getPrice()*count+"</td>");
		                			out.println("</tr>");
	                			}
	                			else
	                			{
	                				System.out.println("无法找到游戏:"+name+"的相关信息,一定是临时工删库跑路了。");
	                			}
	     						
	                		}
                			out.println("<tr>");
                			out.println("<td colspan='4' style='text-align:right'><strong>TOTAL=</strong></td>");
                			out.println("<td class='label-important' style='display:block;color:white;background-color:red'> <strong>$"+total+"</strong></td>");
                			out.println("</tr>");
                			if(DBC!=null)
                				DBC.releaseConnection();
                			
                		}
                	%>

                </tbody>
            </table>
            <script>
            	function waiting()
            	{
            		alert("温馨小提示:\n完成支付需要几秒钟，请耐心等待哦\n请点击确定以继续！");
            	}
            </script>
			<div class="div_paybutton">
                <a href="PayServlet" class='paybutton' onclick=waiting()>付款</a>           
             </div>
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








