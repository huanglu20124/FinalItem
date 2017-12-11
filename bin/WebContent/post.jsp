<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>  
<%@ page import="org.apache.commons.fileupload.*"%>  
<%@ page import="org.apache.commons.fileupload.disk.*"%>  
<%@ page import="org.apache.commons.fileupload.servlet.*"%> 
<% 
	if(request.getParameter("exit") != null) {
		response.sendRedirect("addpost.jsp");
	}
%>
<%
	String title = ""; 
    String content = ""; 
	String[] hamster = new String[]{"","","",""};
	title = request.getParameter("title");
	content = request.getParameter("content");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>小柒的帖子</title>
	<style type="text/css">
				html {
                height:100%;
                width: 100%;
                margin: 0;
                padding: 0;
                font-family: Microsoft YaHei, Consolas;
                background-color: #F4F4F4;
        }
        body {
        	width: 1050px;
        	height: 1050px;
        	margin: 0 auto;
        	background-color:#FFFFFF;
        }
        #title {
			padding: 20px 70px;
			text-align: left;
			height: 20px;
			font-style: bold; 
			font-size:  22px;
			/*background-color: gray;*/
		}
		#post_detail {
			height: 600px;
			padding: 10px 70px 0px 70px;
			/*background-color: gray;*/
		}
		#artical {
			width:900px;
			overflow: auto;
			height: 600px;
			padding: 4px;
			background-color: lightpink;
			word-wrap: break-word;
			word-break: normal;
		}
		#hamsterimg {
			float: left;
			width: 350px;
			height: 250px;
			background-color: lightpink;
		}
		#post_footer {
			height: 80px;
		    padding: 10px 70px;
		    background-color: #5896D5;
		}
		#user {
			float: left;
			height: 80px;
			width: 600px;
			background-color: #7250F0;
		}
		#diggit {
			float: right;
			width: 300px;
		}
		#oppose, #recommend {
			float: right;
			height: 80px;
			width: 100px;
			margin-left: 10px;
			background-color: #7250F0;
		}
		#opposenum, #recommendnum {
			display: block;
		    width: 70px;
		    height: 30px;
		    text-align: center;
		    padding-top: 4px;
		    margin: 0px 10px 7px 10px;
		    border: solid 1px;
		}
		.userimage {
			vertical-align: top;
			width: 70px;
			height: 70px;
			background-image:url(pic/me.png)
		}
		.minimage {
			width: 30px;
			height: 35px;
			margin-right: 7px;
			vertical-align: middle;
		}
		#opposenum +p, #recommendnum +p, #user p {
			margin: 0px 10px;
		}

	</style>
</head>
<body>
		<div id="header"></div>
	<div id="wrapper">
		<div id="title" style="border-bottom: solid 1px #9B9B9B;">
			<a id="artitle" style="font-weight: bold;"><%=title%></a>
		</div>

		<div id="post_detail">	
			<div id="artical">
				<img id="hamsterimg" name="hamsterimg" hspace="5"><%=content%>
			</div>
		</div>

		<div id="post_footer">
			<div id="user">
				<p>
					<img class="userimage" >Seven
				</p>
			</div>
			<div id="diggit">
				<div id="oppose">	
					<p id="opposenum" >45</p>
					<p>
					<img class="minimage">反对
					</p>	
				</div>
				<div id="recommend">
					<p id="recommendnum" >45</p>
					<p>
					<img class="minimage" >推荐
					</p>
				</div>
				
			</div>
		</div>
	
	</div>
	<div id="footer"></div>
</body>
</html>