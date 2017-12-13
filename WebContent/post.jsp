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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>详情页</title>
	<style type="text/css">
		html {
                height:100%;
                width: 100%;
                margin: 0;
                padding: 0;
                font-family: Microsoft YaHei, Consolas;
                background-color: #F4F4F4;
        }
        body {
        	width: 1050px;
        	/* height: 100%; */
        	margin: 0 auto;
        	background-color:#FFFFFF;
        }
        #title {
			padding: 20px 70px;
			text-align: left;
			height: 20px;
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
			height: 80px;
		    padding: 10px 70px;
		    /* background-color: #5896D5; */
		}
		#user {
			float: left;
			height: 80px;
			width: 600px;
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
	<div id="header"></div>
	<div id="wrapper">
		<div id="title" style="border-bottom: solid 1px #9B9B9B;">
			<a id="artitle" style="font-weight: bold;"><%=note_title%></a>
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
				<div id="oppose">	
					<p id="opposenum"><%=note.getGood_num()%></p>
					<p>
					<img class="minimage" src="images/bad.png">反对
					</p>	
				</div>
				<div id="recommend">
					<p id="recommendnum"><%=note.getGood_num()%></p>
					<p>
					<img class="minimage" src="images/good.png">推荐
					</p>
				</div>
				
			</div>
		</div>
	
	</div>
	<div id="footer"></div>
</body>
</html>