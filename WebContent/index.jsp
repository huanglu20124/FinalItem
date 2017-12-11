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
				<span><a href="" style="margin-left: 1.5em;"><%=user_name %></a></span>
				<img src="images/头像.png" style="height: 30px; margin-left: 1em;">
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
					<div class="left_note">
						<p class="note_hd">JavaScript文字张草</p>
						<div class="note_desc">
							<span><img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;"></span>
							<span>司马懿字仲达</span>
							<span>12月08日 11:37</span>
							<span>标签</span>
						</div>
					</div>

					<div class="left_note">
						<p class="note_hd">JavaScript文字张草</p>
						<div class="note_desc">
							<span><img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;"></span>
							<span>司马懿字仲达</span>
							<span>12月08日 11:37</span>
							<span>标签</span>
						</div>
					</div>

					<div class="left_note">
						<p class="note_hd">JavaScript文字张草</p>
						<div class="note_desc">
							<span><img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;"></span>
							<span>司马懿字仲达</span>
							<span>12月08日 11:37</span>
							<span>标签</span>
						</div>
					</div>
				</div>
			</div>
			<div class="right_main">
				<div class="hamster_know">
					<p class="hamster_hd">
						<a href="">仓鼠百科</a>
					</p>
					<div class="hamester_list">
						<p><a href="">图文直播 | BDTC 2017 中国大数据技术大会正在进行</a></p>
						<p><a href="">图文直播 | BDTC 2017 中国大数据技术大会正在进行</a></p>
						<p><a href="">图文直播 | BDTC 2017 中国大数据技术大会正在进行</a></p>
						<p><a href="">图文直播 | BDTC 2017 中国大数据技术大会正在进行</a></p>
						<p><a href="">图文直播 | BDTC 2017 中国大数据技术大会正在进行</a></p>
					</div>
				</div>
				<div class="rank">
					<p class="rank_hd">
						<a>博主排名榜</a>
					</p>
					<div class="rank_list">
						<p class="rank_list_item">
							<span><img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;"></span>
							<span style="margin-left: 1em;">司马懿字仲达</span>
							<span style="margin-left: 1em;">称号</span>
						</p>
						<p class="rank_list_item">
							<span><img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;"></span>
							<span style="margin-left: 1em;">司马懿字仲达</span>
							<span style="margin-left: 1em;">称号</span>
						</p>
						<p class="rank_list_item">
							<span><img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;"></span>
							<span style="margin-left: 1em;">司马懿字仲达</span>
							<span style="margin-left: 1em;">称号</span>
						</p>
						<p class="rank_list_item">
							<span><img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;"></span>
							<span style="margin-left: 1em;">司马懿字仲达</span>
							<span style="margin-left: 1em;">称号</span>
						</p>
					</div>
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
	   <% NoteService noteService = new NoteService();
	      List<Note> list = noteService.getHotNote(request, response);%>
		var y = <%=JSON.toJSONString(list)%>
		console.log(y);
	</script>
</body>
</html>