<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="domain.AdminBean" %>
<!DOCTYPE html>
<html>
<head>
<title>新增商品</title>
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
	<div class="contact">
		<div class="container">		
			<h2>游戏商品添加</h2>
			<div class="contact-form">
				
				<div class="col-md-8 contact-grid">
					<form action="AddServlet" method="post">	
						<input type="text" value="游戏名(必须)"  name="gamename" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='游戏名(必须)';}">
						<input type="text" value="价格(必须)" name="price" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='价格(必须)';}">
						<input type="text" value="库存量(必须)" name="inventory" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='库存量(必须)';}">
						<input type="text" value="图片的路径(非必须)" name="imgurl" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='图片的路径(非必须)';}">
						
						<textarea cols="77" rows="6" value=" " name="description" onfocus="this.value='';" onblur="if (this.value == '') {this.value = '游戏描述(非必须)';}">游戏描述(非必须)</textarea>
						<div class="send">
							<input type="submit" value="提交" >
						</div>
					</form>
				</div>
				<div class="col-md-4 contact-in">

						<div class="address-more">
						<h4>游戏名</h4>
							<p>注意：</p>
							<p>游戏名不可与已有的游戏的名字冲突</p>	
							<p></p>
							<p></p>
						</div>
						<div class="address-more">
						<h4>价格与库存量</h4>
							<p>注意：</p>
							<p>价格（请输入阿拉伯数字，可有小数）</p>
							<p>库存（请输入一个阿拉伯数字，整数）</p>
						</div>
						<div class="address-more">
                            <h4>状态</h4>
                            <p class="highlight">${errors.gamename}${errors.exist}</p>
                            <p class="highlight">${errors.price}</p>
                            <p class="highlight">${errors.inventory}</p>
                            <p class="highlight"></p>
                        </div>
					
				</div>
				<div class="clearfix"> </div>
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