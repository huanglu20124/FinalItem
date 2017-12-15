<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.finalItem.service.RatService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.finalItem.domain.Rat"%>
<%@page import="com.finalItem.service.UserService"%>
<%@page import="com.finalItem.domain.SimpleNote"%>
<%@page import="com.finalItem.service.NoteService"%>
<%@page import="com.finalItem.domain.Note"%>
<%@page import="java.util.List"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.finalItem.domain.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="com.finalItem.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String user_name = "";

	User user = (User)session.getAttribute("user");
	user_name = user.getUser_nickname();	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>仓鼠论坛</title>
<link rel="stylesheet" type="text/css" href="style/layout.css">
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.min.css">
</head>
<body>
	<header>
		<div class="main_content">
			<span class="header_span" style="display:inline-block; float: right;">
				<span style="width: 25px; height: 25px; border-radius: 50%; background-color: rgb(217,49,30); overflow: hidden; text-align: center; margin-right: 20px; cursor: pointer;" title="发布帖子">
					<img src="images/edit.png" style="width: 15px; height: 15px; margin-top: 3px;" />
				</span>
				<span class="logout"><a href="logout.jsp">退出</a></span>
				<span style="margin-top: 5px">
					<a href="own.jsp" style="margin-left: 1.5em;">
					<%=user_name %><img src="images/头像.png" style="height: 30px; margin-left: 1em;">
					</a>
				</span>
			</span>
			<a href="index.jsp" style="display:inline-block; height:40px; overflow:hidden;"><img src="images/hamsterLogo.jpg" style="height: 100%;" /></a>
		</div>
	</header>
</body>
</html>