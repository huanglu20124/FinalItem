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
	String user_sex = "";
	String telephone = "";
	String email = "";

	User user = (User)session.getAttribute("user");
	user_name = user.getUser_nickname();	
	user_sex = user.getSex();
	telephone = user.getTelephone();
	email = user.getEmail();
	
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
	<jsp:include page="header.jsp" flush="true" />
	<div class="main_content">
		<div class="basic_info">
			<div class="img_container">
				<img src="images/头像.png" style="width: 100%; height: auto;" />
			</div>
			<div class="text_info">
				<p class="name_p">
					<span style="display: inline-block; font-size: inherit; vertical-align: middle;"><%=user_name %></span>
					<img src="images/修改.png" style="width: 20px; margin-left: 30px; cursor: pointer; vertical-align: middle;" onclick="alertModal()">		
				</p>
				<p class="optional_p">
					<span><%=user_sex %></span>
					<span><%=telephone %></span>
					<span><%=email %></span>
					<span>未填写地址</span>
					<span>未填写生日</span>
				</p>
				<p class="desc_p">个人简介</p>
			</div>
		</div>

		<div class="own_item">
			<p class="own_item_hd"><span>我的帖子</span></p>
			<div class="note_container">
				<% 
				   NoteService noteService = new NoteService();
				   List<SimpleNote>simpleNotes = noteService.getSimpleNotes(request, response);
				   for(int i = 0; i < simpleNotes.size(); i++){
					  SimpleNote note = simpleNotes.get(i);
				%>
					<div class="left_note">
						<p class="note_hd"><a href="post.jsp?note_id=<%=note.getNote_id()%>"><%=note.getNote_title()%></a></p>
						<div class="note_desc">
							<img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;">
							<span><%=note.getUser_name()%></span>
							<span><%=note.getNote_time()%></span>
							<span><%=note.getRat_name()%></span>
						</div>
					</div>
                <% }%>
				<!-- <div class="left_note">
					<p class="note_hd"><a href="detail.jsp?note_id=1">老公公老婆婆的养殖</a></p>
					<div class="note_desc">
						<img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;">
						<span>恩比德</span>
						<span>2017-12-15</span>
						<span>老公公老婆婆</span>
					</div> -->
				</div>
			</div>
		</div>
		<jsp:include page="footer.jsp" flush="true" />

		<div class="deleteAlertMask">
			<div class="deleteAlert">
				<div class="alertHd">
					<!-- <a type="button" class="close confirm_cancel" aria-hidden="true" style="display: inline-block; vertical-align: middle;">&times;</a> -->
					<h5 style="display: inline-block; vertical-align: middle;">更改个人信息</h5>
				</div>
				<div class="alert_body">
					<div class="form-group">
						<label>用户昵称</label>
						<input type="text" name="nickname" value="<%=user_name %>" />
					</div>
					<div class="form-group">
						<label>用户性别</label>
						<select name="sex">
							<option value="男">男</option>
							<option value="女">女</option>
						</select>
					</div>
					<div class="form-group">
						<label>用户电话</label>
						<input type="text" name="telephone" value="<%=telephone %>" />
					</div>
					<div class="form-group">
						<label>用户邮件</label>
						<input type="text" name="email" value="<%=email %>" />
					</div>
				</div>
				<div class="modal_foot">
					<button type="button" class="btn confirm_cancel">取消</button>
					<button type="button" class="btn" id="confirm_delete" style="background: rgba(205,46,22, 0.8); color: white;">确认</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var deleteAlertMask = document.getElementsByClassName("deleteAlertMask")[0];
		var deleteAlert = document.getElementsByClassName("deleteAlert")[0];
		var confirm_button = document.getElementById("confirm_delete");
		var confirm_cancel = document.getElementsByClassName("confirm_cancel")[0];

		//弹窗
		function alertModal(){
			deleteAlertMask.style.display = "block";
			setTimeout(function(){
				deleteAlert.style.opacity = 1;
				deleteAlert.style.marginTop = -deleteAlert.offsetHeight/2+"px";
			}, 0);
		}

		window.onload = function() {
			confirm_button.onclick = function() {
				deleteAlertMask.style.display = "none";
				deleteAlert.style.marginTop = "0px";
				deleteAlert.style.opacity = 0;
			}
			confirm_cancel.onclick = function() {
				deleteAlertMask.style.display = "none";
				deleteAlert.style.marginTop = "0px";
				deleteAlert.style.opacity = 0;
			}
		}

	</script>
</body>
</html>