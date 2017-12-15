<%@page import="com.finalItem.util.Const"%>
<%@page import="com.finalItem.service.RatService"%>
<%@page import="com.finalItem.domain.Rat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   Rat rat = new RatService().getOneRatById(request,response);
%>
<html>
	<head>
		<meta charset="utf-8">
		<title><%=rat.getRat_name()%></title>
		<style type="text/css">
			body {background-color: rgb(244, 244, 244); font-family: "微软雅黑";}
			a {text-decoration: none; color: blue;}
			#main {
				width: 1000px; 
				overflow: hidden;
				padding: 50px 30px;
				background-color: white;
				margin: 30px auto;
			}
			.introduction {
				overflow: hidden;
			}
			.word {
				width: 90%; 
				display: inline-block;
				font-size: 1.2em;
				text-indent: 2em;
				padding: 0 10px;
				line-height: 1.5em;
			}
			.word h1 {text-indent: 0;}
			.introduction .word {width: 70%;}
			.image {
				width: 20%;
				overflow: hidden;
				display: inline-block;
				//vertical-align: top;
				position:fixed;
				//background-color: red;
				margin: 10px 30px 30px 30px;
			}
			.image img {width: 100%;}
			
			.outline {
				//background-color: white;
				overflow: hidden;
			}
			.outline ul{
				width: 70%;
				border-bottom: 2px dotted gray;
				padding: 3px 0;
				overflow: hidden;
				list-style: none;
			}
			.outline li{
				float: left;
				font-size: 1em;
				margin: 0 5px;
			}
			.outline .attrName {width: 18%; color: gray; font-weight: bold;}
			.outline .attrValue {width: 28%;}
			
			.catalog {
				width: 60%; 
				height: 130px;
				display: inline-block;
				overflow: hidden;
				border-top: 1px rgb(221, 221, 221) solid;
				border-bottom: 1px rgb(221, 221, 221) solid;
				margin-top: 30px;
			}
			.catalog .col1 {
				width: 18%;
				height: 100%;
				background-color: rgb(251, 251, 251);
				font-size: 2em;
				float: left;
				display: inline-block;
				margin: auto 0px auto 0;
				border-right: 2px rgb(235, 235, 235) solid;
			}
			.catalog ol{
				list-style-type: decimal;
				color: blue;
				float: left;
				width: 65%;
				height: 100%;
				margin-top: 0;
			}
			.catalog .col2 {
				width: 45%;
				height: 100%;
				float: left;
				font-size: 1.2em;
				display: inline-block;
				padding: 5px 0;
				border-right: 2px rgb(235, 235, 235) solid;
			}
			.catalog .col3 {
				width: 45%;
				height: 100%;
				float: left;
				font-size: 1.2em;
				display: inline-block;
				margin-left: 35px;
				padding: 5px 0;
			}
			.detail {
				width: 73%; 
				overflow: hidden; 
			}
			.detailContents { margin: 30px 0;}
			.detailContents .title {
				width: 100%;
				border-left: 8px blue solid;
				padding: 0 10px;
				font-size: 1.4em;
				font-weight: bold;
			}
			.detailContents .title hr
			{
				width: 80%;
				color:gray;
				vertical-align:middle; 
				display:inline-block;
			}
			.otherLink {
				width: 20%;
				overflow:hidden;
				display: inline-block;
				position: fixed;
				bottom: 20px;
				margin-left: 150px;;
				
			}
			.otherLink p {
				font-weight: bold; 
				font-size: 1.2em;
				border-top: 2px rgb(222,222,222) solid;
				border-bottom: 2px rgb(222,222,222) solid;
			}
			.otherLink ul {
				width: 100%; 
				overflow: hidden;
				color: blue;
				border-bottom: 2px rgb(222,222,222) solid;
				padding-left: 20px;
			}
			.otherLink .row {
				display: inline-block; 
			}
			.otherLink li {
				
				margin-right: 40px;
				letter-spacing: 3px;
				font-size: 1em;
			}
		</style>
	</head>
	<body>
		<div id="main">
			
			<div class="introduction">
				<div class="word">
					<h1><%=rat.getRat_name()%></h1>
					<p><%=rat.getRat_description()%></p>
				</div>
				<div class="image">
					<img src="<%=Const.FILE_IP + rat.getRat_head()%>">
				</div>
			</div>
			
			<div class="outline">
				<ul>
					<li class="attrName">中文学名</li>
					<li class="attrValue"><%=rat.getRat_name()%></li>
					<li class="attrName">科</li>
					<li class="attrValue">仓鼠科</li>
				</ul>
				<ul>
					<li class="attrName">英文名</li>
					<li class="attrValue">Syrian Hamster、Golden Hamster</li>
					<li class="attrName">亚    科</li>
					<li class="attrValue">仓鼠亚科</li>
				</ul>
				<ul>
					<li class="attrName">别    称</li>
					<li class="attrValue">珍珠熊、黄金地鼠、金仓鼠、金毛鼠、金丝仓鼠</li>
					<li class="attrName">族</li>
					<li class="attrValue">仓鼠</li>
				</ul>
				<ul>
					<li class="attrName">界</li>
					<li class="attrValue">动物界</li>
					<li class="attrName">属</li>
					<li class="attrValue">中仓鼠属</li>
				</ul>
				<ul>
					<li class="attrName">门</li>
					<li class="attrValue">脊索动物门</li>
					<li class="attrName">种</li>
					<li class="attrValue">仓鼠</li>
				</ul>
				<ul>
					<li class="attrName">亚    门</li>
					<li class="attrValue">脊椎动物亚门</li>
					<li class="attrName">分布区域</li>
					<li class="attrValue">原产于叙利亚、黎巴嫩、以色列</li>
				</ul>
				<ul>
					<li class="attrName">纲</li>
					<li class="attrValue">哺乳纲</li>
					<li class="attrName">性    情</li>
					<li class="attrValue">较温顺 </li>
				</ul>
				<ul>
					<li class="attrName">亚    纲</li>
					<li class="attrValue">真兽亚纲</li>
					<li class="attrName">寿    命</li>
					<li class="attrValue">2-3年</li>
				</ul>
				<ul>
					<li class="attrName">目</li>
					<li class="attrValue">啮齿目</li>
					<li class="attrName">类</li>
					<li class="attrValue">啮齿类</li>
				</ul>
				<ul>
					<li class="attrName">亚    目</li>
					<li class="attrValue">鼠形亚目</li>
					<li class="attrName">天    敌</li>
					<li class="attrValue">蛇、鹰等</li>
				</ul>
			</div>
			<div class="catalog">
				<div class="col1">目录</div>
				<ol>
					<div class="col2">
						<li><a href="#waixing">外形特征</a></li>
						<li><a href="#shenghuo">生活习性</a></li>
						<li><a href="#fenbu">分布范围</a></li>
						<li><a href="#pinzhong">常见品种</a></li>
					</div>
					<div class="col3">
						<li><a href="#shengzhang">生长繁殖</a></li>
						<li><a href="#zhongqun">种群现状</a></li>
						<li><a href="#rengong">人工饲养</a></li>
					</div>
				</ol>
			</div>
			<div class="otherLink">
				<p>其他仓鼠</p>
				<ul>
					<div class="row">
						<li><a href="rat.jsp?rat_id=1">三线</a></li>
						<li><a href="rat.jsp?rat_id=2">银狐</a></li>
					</div>
					<div class="row">
						<li><a  href="rat.jsp?rat_id=3">布丁</a></li>
						<li><a  href="rat.jsp?rat_id=4">紫仓</a></li>
					</div>
					<div class="row">
						<li><a href="rat.jsp?rat_id=5">老公公</a></li>
						<li><a  href="rat.jsp?rat_id=6">老婆婆</a></li>
					</div>
					<div class="row">
						<li><a href="rat.jsp?rat_id=7">金丝熊</a></li>
						<li><a href="rat.jsp?rat_id=8">虎纹熊</a></li>
					</div>
					<div class="row">
						<li><a href="rat.jsp?rat_id=9">白熊</a></li>
						<li><a href="rat.jsp?rat_id=10">黑熊</a></li>
					</div>			
				</ul>
			</div>
			<div class="detail">
				<div id="waixing" class="detailContents">
					<div class="title">外形特征 <hr/></div>
					<div class="contents">
						<p class="word">雌性<%=rat.getRat_name()%>体长12cm-18cm，重90g-150g，雄性10cm-15cm，重60g-110g；尾长1.53cm。<%=rat.getRat_name()%>最原始（自然界中）的颜色是金棕色的背毛和灰白色的腹部，之后经多年人工培育，已经有40多种不同的颜色，以黄色体毛者（奶油色）最常见。体毛有短毛，长毛，缎毛，曲卷的波浪毛之分。</p>
					</div>
				</div>
				<div id="shenghuo" class="detailContents">
					<div class="title">生活习性 <hr/></div>
					<div class="contents">
						<p class="word">主食以各种杂草种子和粮食为主，偶尔猎食昆虫,有储存食物的习性，家养仓鼠不冬眠，但防止伪冬眠，它们会储存食物过冬。人工饲养情况下可喂鼠粮、水果干、适量的蔬菜。喂养时一般喂食<%=rat.getRat_name()%>专用的鼠粮，在以鼠粮为主的时候，也要注意喂一些面包虫和小鱼干。<%=rat.getRat_name()%>有把食物贮存在颊囊里的习性。</p>
					</div>
				</div>				
				<div id="fenbu" class="detailContents">
					<div class="title">分布范围 <hr/></div>
					<div class="contents">
						<p class="word">野生<%=rat.getRat_name()%>原产于叙利亚、黎巴嫩、以色列，栖息于戈壁、沙漠、草原、半荒漠、山坡和高山草甸等。于1938年引入美国后才正式成为宠物。</p>
					</div>
				</div>		
				<div id="pinzhong" class="detailContents">
					<div class="title">常见品种 <hr/></div>
					<div class="contents">
						<p class="word"><%=rat.getRat_name()%>在国外经过多年的培育已衍生出众多不同的毛色、斑纹、毛型和毛质，各种基础基因的叠加创造了造型各异的<%=rat.getRat_name()%>花色，在命名一种花色的时候最正确的叫法都是说出所有它的外部特征，如右图所示则称为短毛白腰奶油色（俗称黄白金丝熊）。</p>
					</div>
				</div>		
				<div id="shengzhang" class="detailContents">
					<div class="title">生长繁殖 <hr/></div>
					<div class="contents">
						<p class="word"><%=rat.getRat_name()%>大约在出生两个月后，<%=rat.getRat_name()%>发育成熟，一般来说，<%=rat.getRat_name()%>一窝产子三到七只。十月份过后，<%=rat.getRat_name()%>的繁殖达到高峰期，一窝能生九只左右。隔两星期左右，又能再生一窝。生下的小<%=rat.getRat_name()%>成活率在90%以上。</p>
					</div>
				</div>		
				<div id="zhongqun" class="detailContents">
					<div class="title">种群现状 <hr/></div>
					<div class="contents">
						<p class="word">野生<%=rat.getRat_name()%>的数量不明，但因<%=rat.getRat_name()%>性格温顺，受人喜爱，1938年引入美国后正式成为宠物分类。二十世纪九十年代正式引入中国成为受欢迎的宠物，2003年被国家林业部门列为驯养繁殖技术成熟、可以进行商业利用的动物。但市场上出现了许多用做实验用的小白鼠或是其他小鼠冒充<%=rat.getRat_name()%>的事件。<%=rat.getRat_name()%>这身上可能会携带大量病菌，饲养时候的防疫问题令人担心。</p>
					</div>
				</div>		
				<div id="rengong" class="detailContents">
					<div class="title">人工饲养 <hr/></div>
					<div class="contents">
						<p class="word"><%=rat.getRat_name()%>生活的最适宜温度20-28℃，避免阳光直射或直接被大风吹到，但要注意通风透气。不要离电视，音响，电脑太近，<%=rat.getRat_name()%>可以听到人类听不到的声音，应避免辐射和嘈杂。夏季最好不开空调，因为开关空调会使屋内温差过大，<%=rat.getRat_name()%>对温度很敏感，容易感冒。多铺木屑等垫材，为仓鼠配置木制或草制小屋用于保暖。或多给一些棉花让仓鼠自己做窝。脱脂棉就可以，最好用天然棉。</p>
					</div>
				</div>						
			</div>
		</div>
	</body>
</html>