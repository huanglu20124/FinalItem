<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册成功</title>
</head>

<body>
	<div align="center">
		<img style="width: 30%; height: auto;" src="images/hamsterLogo.jpg">
		<br>
		<p style="font-size: 1.2em">
		    <img style="width: 20px; height: auto;" src="images/勾.png">
		   <%=request.getAttribute("msg")%>
		</p>
	</div>

</body>

</html>