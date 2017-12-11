<%@page import="com.finalItem.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>退出登录</title>
	</head>

	<body>
		<% 
			request.setCharacterEncoding("utf-8");
			String msg = new UserService().logout(request, response);
			out.print(msg);
        %>
		<a href="login.jsp">返回登录界面</a>
	</body>
	

</html>