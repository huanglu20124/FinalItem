<%@page import="com.finalItem.domain.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.finalItem.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>测试主页面</title>
	</head>

	<body>
		<% request.setCharacterEncoding("utf-8");
           User user = (User)session.getAttribute("user");
           if(user != null){
	            out.print("你好" + user.getUser_nickname()); 
            }
        %>
		<br>
		<a href="logout.jsp">退出登录</a>
	</body>

</html>