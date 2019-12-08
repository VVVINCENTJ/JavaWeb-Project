<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="domain.UserBean" %>
<!DOCTYPE html>
<html>

<head>
    <title>Home</title>
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
    <script src="js/modernizr.custom.js"></script>
    <link rel="stylesheet" type="text/css" href="css/component.css" />
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
                        %>
                        </span>
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
                            <li class="active"><a class="color1" href="index.jsp">主页</a></li>
                            <li><a class="color2" href="games.jsp">游戏</a></li>
                            <div class="clearfix"> </div>
                        </ul>
                        <!--script-->
                        <script>
                        $("span.menu").click(function() {
                            $(".top-nav ul").slideToggle(500, function() {});
                        });
                        </script>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>
    </div>
    <!--banner-->
    <div class="banner">
        <div class="container">
            <div class="wmuSlider example1">
                <div class="wmuSliderWrapper">
                    <article style="position: absolute; width: 100%; opacity: 0;">
                        <div class="banner-wrap">
                            <div class="banner-top">
                                <img src="images/12.jpg" class="img-responsive" alt="">
                            </div>
                            <div class="banner-top banner-bottom">
                                <img src="images/11.jpg" class="img-responsive" alt="">
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                    </article>
                    <article style="position: absolute; width: 100%; opacity: 0;">
                        <div class="banner-wrap">
                            <div class="banner-top">
                                <img src="images/14.jpg" class="img-responsive" alt="">
                            </div>
                            <div class="banner-top banner-bottom">
                                <img src="images/13.jpg" class="img-responsive" alt="">
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                    </article>
                    <article style="position: absolute; width: 100%; opacity: 0;">
                        <div class="banner-wrap">
                            <div class="banner-top">
                                <img src="images/18.jpg" class="img-responsive" alt="">
                            </div>
                            <div class="banner-top banner-bottom">
                                <img src="images/17.jpg" class="img-responsive" alt="">
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                    </article>
                </div>
                <ul class="wmuSliderPagination">
                    <li><a href="#" class="">0</a></li>
                    <li><a href="#" class="">1</a></li>
                    <li><a href="#" class="wmuActive">2</a></li>
                </ul>
            </div>
            <!---->
            <script src="js/jquery.wmuSlider.js"></script>
            <script>
            $('.example1').wmuSlider({
                pagination: true,
                nav: false,
            });
            </script>
        </div>
    </div>
    <!--content-->
    <div class="content">
        <div class="container">
            <div class="content-top">
                <h2 class="new">New Games</h2>
                <div class="wrap">
                    <div class="main">
                        <ul id="og-grid" class="og-grid">
                            <li>
                                <a href="deathstranding.jsp" data-largesrc="images/1.jpg" data-title="死亡搁浅" data-description="故事发生在一个未来世界，那时人工智能已经普及，人类掌握了体外合成婴儿的技术，利用该技术的延伸，人类可通过“婴儿感知”看到一些平行空间中的事物(有科学论点认为婴儿感知度强于常人，能看到常人无法看到的亚空间物质)，当这一技术成熟后，由于人类无休止的进行空间实验探索，导致触犯了另一空间的生存法则，该空间内的高级生物发动了“空间入侵”，在人类空间内发动了一次奇异的大爆炸…">
                                    <img class="img-responsive" src="images/thumbs/1.jpg" alt="img01" />
                                </a>
                            </li>
                            <li>
                                <a href="bloodborne.jsp" data-largesrc="images/2.jpg" data-title="血源诅咒" data-description="人烟罕至的山区古都“亚南”，是个被诅咒的城市，自古流传着怪兽瘟疫的奇特地方性疾病。如同病症之名，患上此病症的患者如同病名般将会成为丧失心智的野兽。然而，宛如被诅咒般的古城中，同时也相传有可以医治病根的医疗技术，多数此病症的患者长途跋涉至亚南，寻求解救的方法。">
                                    <img class="img-responsive" src="images/thumbs/2.jpg" alt="img02" />
                                </a>
                            </li>
                            <li>
                                <a href="darksoul3.jsp" data-largesrc="images/3.jpg" data-title="黑暗之魂3" data-description="当火渐熄，世界趋于毁灭，您将再踏上面临更多磨难、大量敌人与难关的旅途。玩家将沉浸在史诗氛围的世界之中，感受更快速的游玩节奏与棘手的战斗强度带来的黑暗气息。不论新手或是老玩家，都将因著名的游戏体验、实境般的游戏画面为之着迷。如今仅剩余火尚存……作好准备，再次拥抱黑暗！">
                                    <img class="img-responsive" src="images/thumbs/3.jpg" alt="img03" />
                                </a>
                            </li>
                            <li>
                                <a href="sekiro.jsp" data-largesrc="images/4.jpg" data-title="只狼:影逝二度" data-description="探索生死冲突不断的16世纪后期，感受残酷的日本战国时代，在黑暗、扭曲的世界，与威胁生命的敌人对峙。活用义手装备各种致命武器，大显忍者身手，在血腥对抗中潜行、上下穿梭，与敌人正面激烈交锋。复仇雪耻。夺回荣誉。巧妙杀敌。">
                                    <img class="img-responsive" src="images/thumbs/4.jpg" alt="img01" />
                                </a>
                            </li>
                            <li>
                                <a href="witcher3.jsp" data-largesrc="images/5.jpg" data-title="巫师3:狂猎" data-description="你将扮演一名训练有素，收钱办事的怪物杀手，探索道德沦丧的开放式奇幻世界，接下最为重要的一笔委托，追寻预言之子，和一心想要控制这个世界的残暴统治者、野外的精怪，乃至于来自来世的威胁斗智斗勇。做出超越善恶的选择，直面影响深远的后果。">
                                    <img class="img-responsive" src="images/thumbs/5.jpg" alt="img01" />
                                </a>
                            </li>
                            <li>
                                <a href="cyberpunk2077.jsp" data-largesrc="images/6.jpg" data-title="赛博朋克2077" data-description="故事发生在夜之城，权力更迭和身体改造是这里不变的主题。扮演一名野心勃勃的雇佣兵：V，追寻一种独一无二的植入体——获得永生的关键。自定义角色义体、技能和玩法，探索包罗万象的城市。您做出的选择也将会对剧情和周遭世界产生影响。">
                                    <img class="img-responsive" src="images/thumbs/6.jpg" alt="img02" />
                                </a>
                            </li>
                            <div class="clearfix"> </div>
                        </ul>
                    </div>
                </div>
            </div>
            <script src="js/grid.js"></script>
            <script>
            $(function() {
                Grid.init();
            });
            </script>
        </div>
        <!----->
        <div class="col-mn"></div>
        <!-- <div class="col-mn2"></div> -->
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