<%@page import="com.finalItem.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
</head>
<body>
<%  String msg = "";
    String user_account = "";
    String user_password = "";
    Cookie[]cookies = request.getCookies();
    if(cookies.length > 0){
    	for(Cookie cookie : cookies){
    		if(cookie.getName().equals("user_account")){
    			user_account = cookie.getValue();
    		}
    		if(cookie.getName().equals("user_password")){
    			user_password = cookie.getValue();
    		}
    	}
    }
   request.setCharacterEncoding("utf-8");
if(request.getMethod().equalsIgnoreCase("post")){
	user_account = request.getParameter("user_account");
	user_password = request.getParameter("user_password");
	UserService userService = new UserService();
	msg = userService.login(request, response);
}%>
<form action="login.jsp" method="post">
   账号：<input name="user_account" type="text" value="<%=user_account%>"><br>
密码：<input name="user_password" type="text" value="<%=user_password%>"><br>
记住登录：<input name="autoLogin" type="checkbox"> <br>
<input type="submit" value="登录">
</form>
<%=msg%><br>
<a href="register.jsp">注册</a>
</body>
</html>