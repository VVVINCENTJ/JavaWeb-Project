<%@page import="com.sun.corba.se.impl.encoding.OSFCodeSetRegistry.Entry"%>
<%@ page import="domain.UserBean" %>
<%@ page import="domain.GameBean" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
			<%
				List<GameBean> browseHistory=(List<GameBean>)request.getSession().getAttribute("history-"+user.getName());
				List<Date> dateHistory=(List<Date>)request.getSession().getAttribute("DateHistory-"+user.getName());	
				int length=0;
		    	if(browseHistory==null)
		    		out.println("<h2>暂无浏览记录嗷亲</h2>");
		    		//System.out.println("浏览记录为空");
		    	else
		    	{
		    		if(browseHistory.size()!=dateHistory.size())
			    	{	
			    		System.out.println("数组长度不一致");
			    		out.println("<h2>数据异常</h2>");
			    	}
			    	else
			    	{
			    		length=browseHistory.size();
			    	}
		    		GameBean gmBean=null;
		    		Date date=null;
		    		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		    		out.println("<p>浏览记录</p>");
					out.println("<table class='table table-bordered'>"); //以下为table表头
					out.println("<thead>");
					out.println("<tr>");
					out.println("<th>Product</th>");
					out.println("<th>Description</th>");
					out.println("<th>Price</th>");
					out.println("<th>Time</th>");
					out.println("</tr>");
					out.println("</thead>");
					out.println("<tbody>");

			    	for(int i=0;i<length;i++)    //以下为table的表项
			    	{	
			    		gmBean=browseHistory.get(i);
			    		date=dateHistory.get(i);
			    		//System.out.println(i+" : "+gmBean.getName());
						//开始根据每一条浏览记录增加<tr>
						out.println("<tr>");
            			out.println("<td> <img src='"+gmBean.getImgurl()+"' alt='' width='120'></td>");
            			out.println("<td width='600'><br>"+gmBean.getDescription()+"</td>");
            			out.println("<td><br><br>$"+gmBean.getPrice()+"</td>");
            			out.println("<td><br><br>"+df.format(date)+"</td>");
            			out.println("</tr>");
			    	}
			    	out.println("</tbody>");
			    	out.println("</table>");
		    	}
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








