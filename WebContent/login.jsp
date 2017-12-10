<%@page import="com.finalItem.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>登陆账号</title>
		<style type="text/css">
			a {
				text-decoration: none;
			}
			
			#header {
				background-color: rgb(160, 160, 160);
			}
			
			#subheader {
				width: 630px;
				height: 200px;
				margin: auto;
				background-image: url("pic/register_background.jpg");
				background-size: cover;
			}
			
			#subheader #title {
				position: relative;
				top: 100px;
				left: 290px;
				color: rgb(100, 100, 100);
				font-family: "楷体";
				font-size: 2.2em;
				font_weight: bold;
			}
			
			#subheader #choice {
				position: relative;
				color: black;
				font-family: "宋体";
				top: 120px;
				left: 350px;
				font-size: 1.5em;
				font_weight: bold;
			}
			
			#registerChoice {
				display: inline-block;
				width: 100px;
			}
			
			#loadChoice {
				display: inline-block;
				width: 100px;
			}
			
			#contents {
				width: 600px;
				margin: 30px auto;
			}
			
			#form {
				width: 350px;
				margin: 10px auto;
			}
			
			.formItem {
				margin: 20px auto;
			}
			
			#username {
				border: solid 2px #ccc;
				border-radius: 10px;
				width: 350px;
				height: 40px;
				background: url(用户.png) no-repeat 0 center, url(竖线.png) no-repeat 15px 3px;
				background-size: 30px 30px, 10% 100%;
			}
			
			#password {
				border: solid 2px #ccc;
				border-radius: 10px;
				width: 350px;
				height: 40px;
				background: url(密码.png) no-repeat 0 center, url(竖线.png) no-repeat 15px 3px;
				background-size: 30px 30px, 10% 100%;
			}
			
			#username input,
			#password input {
				border: none;
				background: none;
				height: 40px;
				width: 100%;
				text-indent: 40px;
				font-size: 1.1em;
			}
			
			#autoLoad {
				margin: 0 auto 20px;
				float: left;
			}
			
			#forgetPassw {
				float: right;
				font-size: 0.8em;
				margin: 0 auto 20px;
			}
			
			#loadButton input {
				clear: both;
				display: block;
				margin: 30px auto;
				width: 250px;
				height: 35px;
				font-size: 1.5em;
			}
			
			#footer {
				margin: auto 8%;
			}
			
			#subfooter1 {
				width: 600px;
				margin: auto;
			}
			
			#subfooter1 li {
				float: left;
				margin: 30px 5px 5px 5px;
				line-height: 30px;
				vertical-align: middle;
				list-style-type: none;
			}
			
			#subfooter2 {
				text-align: center;
				clear: both;
			}
		</style>
	</head>

	<body>
		<%
		String msg = "";
		String user_account = "";
		String user_password = "";
		String autoLogin = "";
		Cookie[] cookies = request.getCookies();
		if (cookies.length > 0) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("user_account")) {
					user_account = cookie.getValue();
				}
				if (cookie.getName().equals("user_password")) {
					user_password = cookie.getValue();
				}
				if(cookie.getName().equals("autoLogin")){
					autoLogin = "checked";
				}
			}
		}
		request.setCharacterEncoding("utf-8");
		if (request.getMethod().equalsIgnoreCase("post")) {
			user_account = request.getParameter("user_account");
			user_password = request.getParameter("user_password");
			UserService userService = new UserService();
			msg = userService.login(request, response);
		}
	%>
		<div id="header">
			<div id="subheader">
				<div id="title">王者荣耀之仓鼠论坛</div>
				<div id="choice">
					<a href="register.jsp" id='registerChoice'>注册</a>
					<a href="login.jsp" id='loadChoice'>登录</a>
				</div>
			</div>
		</div>
		<div id="contents">
			<div id="form">
				<form action="login.jsp" method="post">
					<div class="formItem" id="username">
						<input name="user_account" value="<%=user_account%>" type="text" maxlength=60 placeholder="请输入账号">
					</div>
					<div class="formItem" id="password">
						<input name="user_password" value="<%=user_password%>" type="password" maxlength=60 placeholder="请输入密码">
					</div>
					<div class="formItem" id="autoLoad">
						<input name="autoLogin" type="checkbox" <%=autoLogin%>>
						<span style="font-size: 0.8em; vertical-align: top;">下次自动登录</span>
					</div>
					<div id="forgetPassw">
						<a href="#">忘记密码？</a>
					</div>
					<div class="formItem" id="loadButton">
						<input name="load" type="submit" value="登录">
					</div>
					<div style="text-align: center;">
						<%=msg%>
					</div>
				</form>
			</div>
		</div>
		<div id="footer">
			<div id="subfooter1">
				<ul>
					<li>
						<a href="#">关于论坛</a>
					</li>
					<li><span>|</span></li>
					<li>
						<a href="#">广告服务</a>
					</li>
					<li><span>|</span></li>
					<li>
						<a href="#">论坛客服</a>
					</li>
					<li><span>|</span></li>
					<li>
						<a href="#">隐私和版权</a>
					</li>
					<li><span>|</span></li>
					<li>
						<a href="#">联系我们</a>
					</li>
					<li><span>|</span></li>
					<li>
						<a href="#">举报投诉</a>
					</li>
				</ul>
			</div>
			<p id="subfooter2">&copy; 2017/12/9 王者荣耀之仓鼠论坛</p>
		</div>
	</body>

</html>