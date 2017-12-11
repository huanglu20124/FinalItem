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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.finalItem.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String user_name = "";

	User user = (User)session.getAttribute("user");
	user_name = user.getUser_nickname();	
	
%>
<!DOCTYPE html>
<html>
<head>
	<title>仓鼠论坛</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="style/layout.css">
</head>
<body>
	<header>
		<div class="main_content">
			<span class="header_span" style="display:inline-block; float: right;">
				<span><a href="logout.jsp">退出登录</a></span>
				<span style="margin-top: 5px">
				<a href="person.jsp?user_id=<%=user.getUser_id()%>" style="margin-left: 1.5em;">
				<%=user_name %><img src="images/头像.png" style="height: 30px; margin-left: 1em;">
				</a>
				</span>
			</span>
			<img src="images/logo.png" style="height: 40px;" />
		</div>
	</header>
	<div class="main_content">
		<main>
			<div class="left_main">
				<div class="left_img_container">
					<img src="images/麦田.jpg" style="width: 100%;" />
					<div class="left_img_desc">
						<p class="left_img_desc_content">连黄牛都玩AI了 春节抢票不加钱回不了家了</p>
						<span></span><span></span><span></span><span></span><span></span>
					</div>
				</div>

				<div class="left_note_container">
				<% 
				   NoteService noteService = new NoteService();
				   List<SimpleNote>simpleNotes = noteService.getSimpleNotes(request, response);
				   for(int i = 0; i < simpleNotes.size(); i++){
					  SimpleNote note = simpleNotes.get(i);
				%>
					<div class="left_note">
						<p class="note_hd"><a href="detail.jsp?note_id=<%=note.getNote_id()%>"><%=note.getNote_title()%></a></p>
						<div class="note_desc">
							<span><img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;"></span>
							<span><%=note.getUser_name()%></span>
							<span><%=note.getNote_time()%></span>
							<span><%=note.getRat_name()%></span>
						</div>
					</div>
                <% }%>
                <!-- 处理分页 -->
               <%
				Integer pgno = 0; //当前页号
				Integer pgcnt = 4; //每页行数
				String param = request.getParameter("page");
				if (param != null && !param.isEmpty()) {
					pgno = Integer.parseInt(param);
				}
				int pgprev = (pgno > 0) ? pgno - 1 : 0;
				int pgnext = pgno + 1;
			    %>
			   <div style="float: right">
			   <a href="index.jsp?page=<%=pgprev%>">上一页</a> 
			   <a href="index.jsp?page=<%=pgnext%>">下一页</a>
		      </div>
				</div>
			</div>
			<div class="right_main">
				<div class="hamster_know">
					<p class="hamster_hd">
						<a href="">仓鼠百科</a>
					</p>
					<div class="hamester_list">
					<% List<Rat>rat_list = new RatService().getHotRats(request, response);
					   for(int i = 0; i < rat_list.size(); i++)  
					   {
						   Rat rat = rat_list.get(i);
					   %>
						<p><a href="rat.jsp?<%=rat.getRat_id()%>"><%=rat.getRat_name() %>  | <%=rat.getRat_description().substring(0,15)%></a></p>
					   <%}%>
					</div>
				</div>
				<div class="rank">
					<p class="rank_hd">
						<a>博主排名榜</a>
					</p>
					<div class="rank_list">
					    <%
					        UserService userService = new UserService();
					        List<User>users = userService.getUserGoodRank(request, response);
					        for(int i = 0; i < users.size(); i++)
					        {
					        	User oneUser = users.get(i);
					        	String honour = Const.honours[i];
					    %>
						<p class="rank_list_item">
						    <a href="person.jsp?user_id=<%=oneUser.getUser_id()%>">
						       	<span><img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;"></span>
							    <span style="margin-left: 1em; color: black;"><%=oneUser.getUser_nickname()%></span>
						    </a>
							<span style="margin-left: 1em;"><%=honour%></span>
						</p>
						<%}%>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
	   <% 
	      List<Note> list = noteService.getHotNote(request, response);
	   %>
		  var y = <%=JSON.toJSONString(list)%>
		  console.log(y);
	</script>
</body>
</html>