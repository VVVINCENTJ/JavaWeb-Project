<%@ page import="domain.UserBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
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

<%
	//如果Session还在，那就自动登录
	UserBean user=(UserBean)request.getSession().getAttribute("user");
	if(user!=null)
	{
		System.out.println("user in Session");
		response.setHeader("refresh", "0.5;url=index.jsp");
	}
	else
	{
		System.out.println("no user in Session");
	}
	
%>

</head>
<body> 
<!--header-->	
<div class="header" >
	<div class="top-header" >		
		<div class="container">
		<div class="top-head" >	
			<ul class="header-in">
				<li ><a href="login.jsp" >  登录</a></li>
				<li><a href="register.jsp">   注册</a></li>
				<li ><a href="#" ></a></li>
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
				<h1><a href="index.jsp"><span> G</span>ames <span>C</span>enter</a></h1>

			</div>
		<div class="top-nav">		
			  <span class="menu"><img src="images/menu.png" alt=""> </span>
				
					<ul>
						<li class="active"><a class="color1" href="index.jsp"  >Home</a></li>
						<li><a class="color2" href="games.jsp"  >Games</a></li>
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
	<div class="contact_login">
			
			<div class="container">
				<h2>用户登录</h2>
			<div class="contact-form">
				
				<div class="col-md-8 contact-grid">
					<form class='login_form' action="" method="post"> 	
						<input type="text" value="用户名" name="name" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='用户名';}">
						<input type="text" value="密码" name="password" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='密码';}">

						<div class="send_login">
							<input type="submit" value="用户登录" formaction="LoginServlet">
							<input type="submit" value="管理员登录" formaction="AdminLoginServlet">
							<p><br>${lgFormBean.errors.name}${adminNameMessage}${DBMessage}</p>
							<p>${lgFormBean.errors.password}${adminPasswordMessage}</p>
						</div>
					</form>
				</div>
<!-- 				<div class="col-md-4 contact-in">

						<div class="address-more">
						<h4>邮箱地址</h4>
							<p>请输入正确格式的邮箱地址</p>
							<p>如:</p>0000
							<p>123456789@qq.com</p>
							<p>VINCENTJ@foxmail.com</p>
						</div>
						<div class="address-more">
						<h4>用户密码</h4>
							<p>注意：</p>
							<p>请务必保持</p>
							<p>输入的两次密码一致</p>
						</div>
					
				</div> -->
				<div class="clearfix"> </div>
			</div>
		</div>
<!-- 		<div class="map">
				<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d37494223.23909492!2d103!3d55!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x453c569a896724fb%3A0x1409fdf86611f613!2sRussia!5e0!3m2!1sen!2sin!4v1415776049771"></iframe>
		</div> -->
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