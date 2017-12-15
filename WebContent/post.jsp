<%@page import="com.finalItem.util.Const"%>
<%@page import="com.finalItem.service.NoteService"%>
<%@page import="com.finalItem.domain.Note"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%>  
<%@ page import="org.apache.commons.fileupload.*"%>  
<%@ page import="org.apache.commons.fileupload.disk.*"%>  
<%@ page import="org.apache.commons.fileupload.servlet.*"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="style/layout.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>详情页</title>
	<style type="text/css">
		/* html {
                height:100%;
                width: 100%;
                margin: 0;
                padding: 0;
                font-family: Microsoft YaHei, Consolas;
                background-color: #F4F4F4;
        }
        body {
        	width: 1050px;
        	height: 100%; 
        	margin: 0 auto;
        	background-color:#FFFFFF;
        }*/
        #title {
			padding: 20px 70px;
			text-align: left;
			font-style: bold; 
			font-size:  30px;
			/*background-color: gray;*/
		}
		#post_detail {
			/* height: 600px; */
			padding: 10px 70px 0px 70px;
			/*background-color: gray;*/
		}
		#artical {
			width:900px;
			height: auto;
			padding: 4px;
			/* background-color: lightpink; */
			word-wrap: break-word;
			word-break: normal;
		}
		.hamsterimg {
			width: 100%;
			height: auto;
			/* background-color: lightpink; */
			display: block;
		}
		#post_footer {
			/* height: 80px; */
		    padding: 10px 70px;
		    /* background-color: #5896D5; */
		    overflow:hidden;
		}
		#user {
			float: left;
			height: 80px;
			width: 400px;
			/* background-color: #7250F0; */
		}
		#diggit {
			float: right;
			width: 300px;
		}
		#oppose, #recommend {
			float: right;
			height: 80px;
			width: 100px;
			margin-left: 10px;
			/* background-color: #7250F0; */
		}
		#opposenum, #recommendnum {
			display: block;
		    width: 70px;
		    height: 30px;
		    text-align: center;
		    padding-top: 4px;
		    margin: 0px 10px 7px 10px;
		    border: solid 1px;
		}
		.userimage {
			vertical-align: top;
			width: 70px;
			height: 70px;
			
		}
		.minimage {
			width: 30px;
			height: 35px;
			margin-right: 7px;
			vertical-align: middle;
		}
		#opposenum +p, #recommendnum +p, #user p {
			margin: 0px 10px;
		}

	</style>
</head>
<body>
    <%  
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String note_title = "";
        String note_content = "";
        Note note = new NoteService().getOneNote(request, response);
        if(note != null){
        	note_title = note.getNote_title();
        	note_content = note.getNote_content();
        }
	%>
	<jsp:include page="header.jsp" flush="true" />
	<div class="main_content">
		<main style="padding: 20px 30px; background-color:white; overflow:hidden;">
		<div id="title" style="border-bottom: solid 1px #9B9B9B; padding: 10px 0px;">
			<a id="artitle" style="font-weight: bold; font-size:16px; line-height: 2em;"><%=note_title%></a>
		</div>

		<div id="post_detail">	
			<div id="artical">
<!-- 				<img src="http://localhost:8080/final_item/file/note1_1.jpg" id="hamsterimg" name="hamsterimg" hspace="5"> -->
				<p style="white-space: pre-wrap;"><%=note_content%></p>
			</div>
		</div>

		<div id="post_footer">
			<div id="user">
				<p>
					<img class="userimage" src="images/me.png">
					<span class="user_info"><%=note.getUser_name()%> 仓鼠种类：<%=note.getRat_name() %>
					</span>
				</p>
			</div>
			<div id="diggit">
				<div id="oppose" onclick="opposefunc(<%=note.getNote_id()%>, <%=note.getRat_id()%>, 1)" style="cursor:pointer;">	
					<p id="opposenum"><%=note.getGood_num()%></p>
					<p>
					<img class="minimage" src="images/bad.png">反对
					</p>	
				</div>
				<div id="recommend" onclick="recommendfunc(<%=note.getNote_id()%>, <%=note.getRat_id()%>, 0)" style="cursor:pointer;">
					<p id="recommendnum"><%=note.getGood_num()%></p>
					<p>
					<img class="minimage" src="images/good.png">推荐
					</p>
				</div>
				
			</div>
		</div>
		</main>
		<jsp:include page="footer.jsp" flush="true" />
	</div>
	<script type="text/javascript">
		function opposefunc(note_id, rat_id, type) {
			var data = {
				note_id : note_id,
				rat_id: rat_id,
				type: type
			}
			var send_data = "";
			for(var temp_index in data ){
				send_data += temp_index + "=" + data[temp_index] + "&";
			}
			
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.open("post", "post.jsp", true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.onreadystatechange = function() {
				if(xmlhttp.readyState == 4 && xmlhttp.status == "200") {
					console.log("success");
					var opposenum = document.getElementById("opposenum");
					var num = parseInt(opposenum.innerHTML);
					num ++;
					opposenum.innerHTML = num;
				} else {
					console.log(xmlhttp.readyState);
				}
			}
			console.log(send_data.substring(0, send_data.length-1));
			xmlhttp.send(send_data.substring(0, send_data.length-1));
		}
		
		function recommendfunc(note_id, rat_id, type) {
			var data = {
				note_id : note_id,
				rat_id: rat_id,
				type: type
			}
			var send_data = "";
			for(var temp_index in data ){
				send_data += temp_index + "=" + data[temp_index] + "&";
			}
			
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.open("post", "post.jsp", true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.onreadystatechange = function() {
				if(xmlhttp.readyState == 4 && xmlhttp.status == "200") {
					console.log("success");
					var recommendnum = document.getElementById("recommendnum");
					var num = parseInt(recommendnum.innerHTML);
					num ++;
					recommendnum.innerHTML = num;
				} else {
					console.log(xmlhttp.readyState);
				}
			}
			console.log(send_data.substring(0, send_data.length-1));
			xmlhttp.send(send_data.substring(0, send_data.length-1));
		}
	</script>
</body>
</html>