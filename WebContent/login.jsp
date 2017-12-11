<%@page import="com.finalItem.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>登陆账号</title>
		<link rel="stylesheet" href="style/layout.css" type="text/css">
		<style type="text/css">
			a {
				text-decoration: none;
			}
			
			#header {
				background-color: rgb(160, 160, 160);
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
		<jsp:include page="footer.jsp" flush="true" />
	</body>

</html>