<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.UserBean" %>
<%@ page import="JDBC.DBConnector" %>
<%@ page import="domain.GameBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <title>赛博朋克2077</title>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Custom Theme files -->
    <!--theme-style-->
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
    <!--//theme-style-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="application/x-javascript">
    addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);

    function hideURLbar() { window.scrollTo(0, 1); }
    </script>
    <!--fonts-->
    <link href='http://fonts.useso.com/css?family=Montserrat+Alternates:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.useso.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
    <!--//fonts-->

     <% 
    	Date date=new Date();
    	int month=date.getMonth();
    	int day=date.getDate();
    	String[] monArray={"January","February","March","April","May","June","July","August","September","October","November","December"};
    	String  monStr=monArray[month];
    %>
     <%
	   	DBConnector DBC=new DBConnector();
	   	String name="cyberpunk2077";
	   	GameBean gmBean=DBC.gameQuery(name);
	   	int views=gmBean.getViews()+1;        //浏览量+1
	   	gmBean.setViews(views);               //更改浏览量并更新数据库
	   	boolean check=DBC.gamesUpdateViews(gmBean);
		int inventory=gmBean.getInventory();
		int sales=gmBean.getSales();
		double price=gmBean.getPrice();
		DBC.releaseConnection();               //要记得释放连接
		System.out.println(date);
    %>

</head>

<body>
    <!--header-->
    <div class="header">
        <div class="top-header">
            <div class="container">
                <div class="top-head">
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
                        <%
	                        List<GameBean> browseHistory=(List<GameBean>)request.getSession().getAttribute("history-"+user.getName());
	                     	List<Date> dateHistory=(List<Date>)request.getSession().getAttribute("DateHistory-"+user.getName());
					    	if(browseHistory==null)
					    		browseHistory=new ArrayList<GameBean>();
	                     	if(dateHistory==null)
	                     		dateHistory=new ArrayList<Date>();
	                     	
					    	browseHistory.add(gmBean);
					    	dateHistory.add(date);
					    	//浏览的游戏名和时间放入session
					    	request.getSession().setAttribute("history-"+user.getName(), browseHistory);
					    	request.getSession().setAttribute("DateHistory-"+user.getName(), dateHistory);
					    	
					    %>
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
                            <li class="active"><a class="color1" href="index.jsp">主页</a></li>
                            <li><a class="color2" href="games.jsp">游戏</a></li>
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
    <!--content-->
    <div class="container">
        <div class="single">
            <div class="blog-to">
                <img class="img-responsive sin-on" src="images/sin6.jpg" alt="" />
                
                <div class="blog-top">
                    <div class="blog-left">
                        <b><% out.println(day); %></b>
                        <span><% out.println(monStr); %></span>
                    </div>
                    <div class="blog-right">
                        <b>$<%out.println(price); %></b>
                    </div>
                    <div class="top-blog">
                        <a class="fast" href="#">发行日期:2020年4月16日</a>
                        <p>开发商:<a href="#">CD PROJEKT RED </a> | 发行商:<a href="#">CD PROJEKT RED</a></p>
                        <p class="sed">故事发生在夜之城，权力更迭和身体改造是这里不变的主题。扮演一名野心勃勃的雇佣兵：V，追寻一种独一无二的植入体——获得永生的关键。自定义角色义体、技能和玩法，探索包罗万象的城市。您做出的选择也将会对剧情和周遭世界产生影响。毒品、暴力、贫穷和专政并没有在2077年消失，几十年过去了，人们仍然保留着那份贪婪、狭隘和懦弱。但是不断困扰人类的并不只有来自过去的幽灵，还有来自当代的新问题。“惊魂”们的表现越来越狂暴：大街上充满了瘾君子们——他们为一种刚刚出现的娱乐项目所沉迷：“脑舞”。脑舞十分廉价，却可以让人体验到其他人的生活和他们的情绪，尤其是当其他人的生活比自己的更加丰富多彩时，这种刺激是无与伦比的。</p>
                        <p>化身装备机械强化义体的城市雇佣兵，成为一名赛博朋克，在夜之城的街头谱写属于您的传奇。进入夜之城的庞大开放世界。在这里，视觉效果、复杂程度和游戏深度都将得到全新的定义。接下有生以来最危险的任务，追寻能够带来永生的原型植入体。<br></p>
                        <div class="col-md-6 md-in">
                            <p>最低配置:</p>
                            <ul class="grid-part">
                                <li><a href="#"><i class="sign"> </i>操作系统: Windows 10 64 Bit, Windows 8.1 64 Bit, Windows 8 64 Bit, Windows 7 64 Bit Service Pack 1</a></li>
                                <li><a href="#"><i class="sign"> </i>处理器: Intel Core 2 Quad CPU Q6600 @ 2.40GHz (4 CPUs) </a></li>
                                <li><a href="#"><i class="sign"> </i>内存: 4 GB RAM</a></li>
                                <li><a href="#"><i class="sign"> </i>显卡: NVIDIA 9800 GT 1GB </a></li>
                                <li><a href="#"><i class="sign"> </i>存储空间: 需要 72 GB 可用空间</a></li>
                            </ul>
                        </div>
                        <div class="col-md-6 md-in">
                            <p>推荐配置:</p>
                            <ul class="grid-part">
                                <li><a href="#"><i class="sign"> </i>操作系统: Windows 10 64 Bit, Windows 8.1 64 Bit, Windows 8 64 Bit, Windows 7 64 Bit Service Pack 1</a></li>
                                <li><a href="#"><i class="sign"> </i>处理器: Intel Core i5 3470 @ 3.2GHz (4 CPUs) / AMD X8 FX-8350 @ 4GHz (8 CPUs)</a></li>
                                <li><a href="#"><i class="sign"> </i>内存: 8 GB RAM</a></li>
                                <li><a href="#"><i class="sign"> </i>显卡: NVIDIA GTX 660 2GB / AMD HD 7870 2GB</a></li>
                                <li><a href="#"><i class="sign"> </i>存储空间: 需要 72 GB 可用空间</a></li>
                            </ul>
                        </div>
                        <div class="game_detail">
		                	<ul class="gdetail">
		                        <li><a href="#" class='color1'>浏览量：<%out.println(views);%></a></li>
		                        <li><a href="#" class='color2'>销售量：<%out.println(sales);%></a></li>
		                        <li><a href="#" class='color3'>库存量：<%out.println(inventory);%></a></li>
		                    </ul>
                		</div>
                		<div class="div_shortcart">    
	                    	<c:url var="myurl" value="AddToCartServlet">
                				<c:param name="game_name" value="cyberpunk2077"></c:param>
                			</c:url>    
	                    	<a href=<c:out value="${myurl}"/> class='shopcart'>加入购物车</a>
	                    	<p class="highlight"><br>${addGamesMessage}</p>
                		</div>
                        <div class="clearfix"> </div>
                    </div>


                    <div class="clearfix"> </div>
                </div>
            </div>
           <!--  评论展示 -->
<!--             <div class="single-middle">
                <h3>3 Comments</h3>
                <div class="media">
                    <div class="media-left">
                        <a href="#">
                            <img class="media-object" src="images/co.png" alt="">
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading"><a href="#">Richard Spark</a></h4>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                            Duis aute irure dolor in reprehenderit .</p>
                    </div>
                </div>
                <div class="media in-media">
                    <div class="media-left">
                        <a href="#">
                            <img class="media-object" src="images/co.png" alt="">
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading"><a href="#">Joseph Goh</a></h4>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                            Duis aute irure dolor in reprehenderit .</p>
                    </div>
                </div>
                <div class="media">
                    <div class="media-left">
                        <a href="#">
                            <img class="media-object" src="images/co.png" alt="">
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading"><a href="#">Melinda Dee</a></h4>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                            Duis aute irure dolor in reprehenderit .</p>
                    </div>
                </div>
            </div> -->
            <!---->
            <!-- 添加评论 -->
<!--             <div class="single-bottom">
                <h3>Leave A Comment</h3>
                <form>
                    <div class="col-md-4 comment">
                        <input type="text" value="Name" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='Name';}">
                    </div>
                    <div class="col-md-4 comment">
                        <input type="text" value="Email" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='Email';}">
                    </div>
                    <div class="col-md-4 comment">
                        <input type="text" value="Subject" onfocus="this.value='';" onblur="if (this.value == '') {this.value ='Subject';}">
                    </div>
                    <div class="clearfix"> </div>
                    <textarea cols="77" rows="6" value=" " onfocus="this.value='';" onblur="if (this.value == '') {this.value = 'Message';}">Message</textarea>
                    <input type="submit" value="Send">
                </form>
            </div> -->
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