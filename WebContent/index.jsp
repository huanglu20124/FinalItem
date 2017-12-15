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
	<jsp:include page="header.jsp" flush="true" />
	<div class="main_content">
		<main>
			<div class="left_main">
				<div class="left_img_container">
					<img src="images/麦田.jpg" style="width: 100%;" id="left_img"/>
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
							<img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;">
							<span><%=note.getUser_name()%></span>
							<span><%=note.getNote_time()%></span>
							<span><%=note.getRat_name()%></span>
						</div>
					</div>
                <% }%>
	                <!-- 处理分页 -->
	                <%
						Integer pgno = 0; //当前页号
						String param = request.getParameter("page");
						if (param != null && !param.isEmpty()) {
							pgno = Integer.parseInt(param);
						}
						int pgprev = (pgno > 0) ? pgno - 1 : 0;
						int pgnext = pgno + 1;
				    %>
	                <div class="page_foot">
						<span class="left_page"><a href="index.jsp?page=<%=pgprev%>"><<</a></span>
						<span class="page_desc">
							当前页数 <span class="cur_page"><%=param%></span>/<span class="all_page"><%=session.getAttribute("page_sum")%></span>
						</span>
						<span class="right_page"><a href="index.jsp?page=<%=pgnext%>">>></a></span>
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
				<div class="relation_link">
					<p class="rank_hd">
						<a>相关链接</a>
					</p>
					<a style="width: 100%; display: inline-block; overflow: hidden;" href="http://tieba.baidu.com/f?kw=%B2%D6%CA%F3&fr=ala0&tpl=5">
						<img src="images/rat_ba.jpg" style="width: 100%;" />
					</a>
				</div>
			</div>
		</main>
	</div>
	<script type="text/javascript">
	   <% 
	      List<Note> list = noteService.getHotNote(request, response);
	   %>
			var noteImg_array = <%=JSON.toJSONString(list)%>
			console.log(noteImg_array);
			var index = 0; //记录滚动图片的索引
			var left_img = document.getElementById("left_img");
			var left_img_desc = document.getElementsByClassName("left_img_desc")[0];
		    var left_img_desc_content = document.getElementsByClassName("left_img_desc_content")[0];
		    var span_ = left_img_desc.getElementsByTagName("span");
		    var slideTimeout; //记录超时运行的函数

		    //增删class属性
		    function addClass(obj, cls){
			    var obj_class = obj.className,//获取 class 内容.
		        blank = (obj_class != '') ? ' ' : '';//判断获取到的 class 是否为空, 如果不为空在前面加个'空格'.
			    added = obj_class + blank + cls;//组合原来的 class 和需要添加的 class.
			    obj.className = added;//替换原来的 class.
			}

			function removeClass(obj, cls){
			    var obj_class = ' '+obj.className+' ';//获取 class 内容, 并在首尾各加一个空格. ex) 'abc    bcd' -> ' abc    bcd '
			    obj_class = obj_class.replace(/(\s+)/gi, ' '),//将多余的空字符替换成一个空格. ex) ' abc    bcd ' -> ' abc bcd '
		        removed = obj_class.replace(' '+cls+' ', ' ');//在原来的 class 替换掉首尾加了空格的 class. ex) ' abc bcd ' -> 'bcd '
			    removed = removed.replace(/(^\s+)|(\s+$)/g, '');//去掉首尾空格. ex) 'bcd ' -> 'bcd'
			    obj.className = removed;//替换原来的 class.
			}

			function hasClass(obj, cls){
			    var obj_class = obj.className;//获取 class 内容
			    console.log(obj_class + " " + cls);
		        if(obj_class.indexOf(cls) != -1) {
		            return true;
		        }
    			return false;
    		}

			// 改变图片和内容
			function slideImage() {
				left_img.setAttribute("src", noteImg_array[index].images[0]);
				left_img_desc_content.innerHTML = noteImg_array[index].note_title;
				for(var i = 0; i < 5; i++) {
					if(hasClass(span_[i], "doc_hover")) {
						removeClass(span_[i], "doc_hover");
					}
				}
				addClass(span_[index], "doc_hover");
				index = (index+1) % 5;
				slideTimeout = setTimeout(arguments.callee, 4000);
			}

			window.onload = function() {
				slideImage();
				for(var i = 0; i < span_.length; i++) {
					// console.log("here");
					span_[i].onclick = (function(temp_index) {
						console.log("here");
						return function() {
							clearTimeout(slideTimeout);
							for(var j = 0; j < span_.length; j++) {
								if(hasClass(span_[j], "doc_hover")) {
									removeClass(span_[j], "doc_hover");
								}
							}
							addClass(span_[temp_index], "doc_hover");
							left_img.setAttribute("src", noteImg_array[temp_index].images[0]);
							left_img_desc_content.innerHTML = noteImg_array[temp_index].note_title;
							index = temp_index;
							slideTimeout = setTimeout(slideImage, 4000);
						}
					})(i);
				}
			}

	</script>
</body>
</html>