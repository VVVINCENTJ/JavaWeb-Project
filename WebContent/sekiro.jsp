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
    <title>只狼:影逝二度</title>
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
	   	String name="sekiro";
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
                <img class="img-responsive sin-on" src="images/sin4.jpg" alt="" />
                
                <div class="blog-top">
                    <div class="blog-left">
                        <b><% out.println(day); %></b>
                        <span><% out.println(monStr); %></span>
                    </div>
                    <div class="blog-right">
                        <b>$<%out.println(price); %></b>
                    </div>
                    <div class="top-blog">
                        <a class="fast" href="#">发行日期:2019年3月22日</a>
                        <p>开发商:<a href="#"> FromSoftware </a> | 发行商:<a href="#">Activision (Excluding Japan and Asia), FromSoftware (Japan), 
                        方块游戏 (Asia)</a></p>
                        <p class="sed">在《Sekiro: Shadows Die Twice》中你是“独臂之狼”，一个名誉不再、伤痕累累的忍者，一个从死亡边缘捡回一命的战士。你效忠守护继承古老血统的年轻皇子，与危险的苇名一族以及众多凶恶之徒为敌。年轻的皇子被抓走后，为挽回荣誉，你将不畏死亡，踏上危机四伏的征程。探索生死冲突不断的16世纪后期，感受残酷的日本战国时代，在黑暗、扭曲的世界，与威胁生命的敌人对峙。活用义手装备各种致命武器，大显忍者身手，在血腥对抗中潜行、上下穿梭，与敌人正面激烈交锋。</p>
                        <p>复仇雪耻。夺回荣誉。巧妙杀敌。<br></p>
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
                				<c:param name="game_name" value="sekiro"></c:param>
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