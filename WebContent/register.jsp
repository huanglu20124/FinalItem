<%@page import="com.finalItem.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>注册账号</title>
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
				background-image: url("images/register_background.jpg");
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
				width: 420px;
				margin: 10px auto;
			}
			
			.formItem {
				margin: 15px auto;
			}
			
			.input {
				width: 250px;
				height: 30px;
				border-radius: 10px;
			}
			
			.inputName {
				font-size: 1.5em;
			}
			
			#registerButton {
				display: block;
				margin: 30px auto;
				width: 250px;
				height: 50px;
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
	    String user_account ="";
	    String user_password = "";
	    String telephone = "";
	    String email = "";
	    String[]problem = new String[]{"","","",""};
	    String answer = "";
		request.setCharacterEncoding("utf-8");
		if (request.getMethod().equalsIgnoreCase("post")) {
			msg = new UserService().register(request, response);
			user_account = request.getParameter("user_account");
			user_password = request.getParameter("user_password");
			telephone = request.getParameter("telephone");
			email = request.getParameter("email");
			answer = request.getParameter("user_answer");
			switch(request.getParameter("user_problem")){
			    case "你最喜爱的老师名字叫什么？":
			    	problem[0] = "selected";
			    	break;
			    case "你毕业的高中名字是？":
			    	problem[1] = "selected";
			    	break;
			    case "你最喜欢的一种颜色是？":
			    	problem[2] = "selected";
			    	break;
			    case "你最喜欢的仓鼠种类是？":
			    	problem[3] = "selected";
			    	break;
			}
		}
	%>
		<div id="header">
			<div id="subheader">
				<div id="title">王者荣耀之仓鼠论坛</div>
				<div id="choice">
					<a href="register.jsp" id='registerChoice'>注册</a>
					<a href="login.jsp" id='loadChoice'>登陆</a>
				</div>
			</div>
		</div>
		<div id="contents">
			<div id="form">
				<form action="register.jsp" method="post">
					<div class="formItem">
						<label for="username"><span class="inputName">登陆账号：</span></label>
						<input name="user_account" value="<%=user_account%>" type="text" maxlength=60 placeholder="请输入登录账号" class='input'>
					</div>
					<div class="formItem">
						<label for="password"><span class="inputName">登陆密码：</span></label>
						<input name="user_password" value="<%=user_password %>" type="password" maxlength=60 placeholder="请输入登录密码" class='input'>
					</div>
					<div class="formItem">
						<label for="title"><span class="inputName">手机号码：</span></label> <input name="telephone" value="<%=telephone %>" type="text" maxlength=60 placeholder="请输入手机号码" class='input'>
					</div>
					<div class="formItem">
						<label for="title"><span class="inputName">邮箱地址：</span></label> <input name="email" value="<%=email%>" type="text" maxlength=60 placeholder="请输入邮箱地址" class='input'>
					</div>
					<div class="formItem">
						<label for="question"><span class="inputName">密保问题：</span></label>
						<select name="user_problem" style="width: 256px; height: 38px" class='input'>
							<option value="你最喜爱的老师名字叫什么？" <%=problem[0]%>>你最喜爱的老师名字叫什么？</option>
							<option value="你毕业的高中名字是？" <%=problem[1]%>>你毕业的高中名字是？</option>
							<option value="你最喜欢的一种颜色是？" <%=problem[2]%>>你最喜欢的一种颜色是？</option>
							<option value="你最喜欢的仓鼠种类是？" <%=problem[3]%>>你最喜欢的仓鼠种类是？</option>
						</select>
					</div>
					<div class="formItem">
						<label for="title"><span class="inputName">输入答案：</span></label> <input name="user_answer" value="<%=answer%>" type="text" maxlength=60 placeholder="请输入密保答案" class='input'>
					</div>
					<div class="formItem">
						<input name="permission" type="checkbox" value="h1"><span id="permission">我已经阅读并同意<a
						href="http://service.tianya.cn/guize/regist.do" id="protocol">《王者荣耀之仓鼠论坛用户注册协议》</a></span>
					</div>
					<div class="formItem">
						<input name="register" type="submit" value="立即注册" id="registerButton">
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
			<br>
			<p id="subfooter2">&copy; 2017/12/9 王者荣耀之仓鼠论坛</p>
		</div>
	</body>

</html>