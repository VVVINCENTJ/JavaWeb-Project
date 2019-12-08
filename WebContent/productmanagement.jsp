<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="domain.AdminBean" %>
<%@ page import="JDBC.DBConnector" %>
<!DOCTYPE html>
<html>
<head>
<title>商品管理</title>
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
				<li><a href="#" > 欢迎管理员:<span class="highlight">
                        <%
                        	AdminBean admin=(AdminBean)request.getSession().getAttribute("admin");
                        	if(admin==null)
                        		response.setHeader("Refresh","1;url=login.jsp");
                        	else
                        		out.println(admin.getName());
                        %></span>
                        </a></li>
                        <li><a href="AdminLogoutServlet"> 注销</a></li>
                        <li><a href="#"> </a></li>
                        <li><a href="#"></a></li>
                        <li><a href="#"></a></li>
			</ul>
			
				<!-- <div class="search">
					<form>
						<input type="text" value="搜索游戏......" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '搜索游戏......';}" >
						<input type="submit" value="" >
					</form>
				</div> -->
			
				<div class="clearfix"> </div>
		</div>
		</div>
	</div>
		<!---->
	
		<div class="header-top">
		<div class="container">
		<div class="head-top">
			<div class="logo">
			<h1><a href="adminindex.jsp"><span> G</span>ames <span>C</span>enter 后台管理</a></h1>

			</div>
		<div class="top-nav">		
			  <span class="menu"><img src="images/menu.png" alt=""> </span>
				
					<ul>
						<li class="active"><a class="color1" href="adminindex.jsp"  >Home</a></li>
						<li><a class="color2" href="salesreport.jsp">sales</a></li>
						<li><a class="color3" href="productmanagement.jsp"  >product-management</a></li>

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
		<p>商品目录</p>	
			<table class="table table-bordered">
                <thead>
                    <tr>    	
                        <th class="center">游戏名称</th>
                        <th class="center">简介</th>
                        <th class="center">价格</th>
                        <th class="center">浏览量</th>
                        <th class="center">库存量</th>
                        <th class="center">销售量</th> 
                        <th class="center">操作</th>
                    </tr>
                </thead>
                <tbody>
                	<%
                		DBConnector DBC=new DBConnector();
                		ResultSet rs=DBC.getGamesInformation();
                		while(rs.next())
                		{
                			String name=rs.getString("name");
                			String imgurl=rs.getString("imgurl");
                			String description=rs.getString("description");
                			double price=rs.getDouble("price");
                			int views=rs.getInt("views");
                			int inventory=rs.getInt("Inventory");
                			int sales=rs.getInt("sales");
                			out.println("<tr>");
                			out.println("<td> <img src='"+imgurl+"' alt='' width='100'><p class='table-font'>"+name+"</p></td>");
                			out.println("<td width='600'><br>"+description+"</td>");
                			out.println("<td><br><br>"+price+"</td>");
                			out.println("<td><br><br>"+views+"</td>");
                			out.println("<td><br><br>"+inventory+"</td>");
                			out.println("<td><br><br>"+sales+"</td>");
                			out.println("<td><br><a href='DeleteServlet?gamename="+name+"' class='deletebutton'>Delete</a><br><br><a href='modifyproduct.jsp?gamename="+name+"' class='modifybutton'>Modify</a></td>");
                			out.println("</tr>");
                		}
                		DBC.releaseConnection();
                	%>

                </tbody>
            </table>
            <a href="addproduct.jsp" class="addbutton">Add</a>
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