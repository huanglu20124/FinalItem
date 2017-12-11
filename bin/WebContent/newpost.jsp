<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发表新帖</title>
<style type="text/css">
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
        	height: 100%;
        	margin: 0 auto;
        }
        form {
        	padding: 20px 70px;
               /* height: 700px;*/
        	background-color: #FFFFFF;
        }
        p:first-of-type {
                font-size:22px;
                font-weight: bold;
        }
        #title {
        	width: 700px;
                height: 1.5em;
        }
        #hamster {
        	display: inline-block;
        	width: 80px;
        }
        [for="content"] {
                vertical-align: top;
        }
        #content {
        	width:700px;
        	height:300px;
        }
        #title, textarea, select {
                background-color: #FFFFFF;
                border: 1px solid #CCCCCC;
                box-shadow: 2px 2px 2px #F0F0F0 inset;
                font-family: inherit;
                font-size: 100%;
                line-height: 18px;
                padding: 4px;
                margin: 0;
                vertical-align: middle;
                -webkit-transition: border linear 0.2s, box-shadow linear 0.2s;
                -moz-transition: border linear 0.2s, box-shadow linear 0.2s;
                -ms-transition: border linear 0.2s, box-shadow linear 0.2s;
                -o-transition: border linear 0.2s, box-shadow linear 0.2s;
                transition: border linear 0.2s, box-shadow linear 0.2s;
                -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
                -moz-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
                box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
                border-radius:3px;
        }
        #title:focus, textarea:focus {
                outline: 0;
                border-color: rgba(82, 168, 236, 0.8);
                -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
                -moz-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
                box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
        }
        a {
                display: inline-block; 
        }
        .load {
                padding: 4px 10px;
                margin-left: 35px;
                height: 24px;
                line-height: 21px;
                position: relative;
                cursor: pointer;
                color: #888;
                background: #fafafa;
                border: 1px solid #ddd;
                border-radius: 4px;
        }
        .load input {
                cursor: pointer;
                height: 34px;
                width: 85px;
                overflow: hidden;
                position: absolute;
                font-size: 100px;
                right: 0;
                top:0;
                opacity: 0;
                filter: alpha(opacity=0);
        }
        .load:hover {
                color: #444;
                background: #eee;
                border-color: #CCCCCC;
                text-decoration: none;
        }
        button {
                padding: 4px 6px;
                width: 60px;
                height: 30px;
                line-height: 20px;
                cursor: pointer;
                color: #FFFFFF;
                background: #3E89FA;
                border: 1px solid #ddd;
                border-radius: 4px;
        }
        button:hover {
                background: #2A7DFA;
                border-color: #CCCCCC;
        }
	</style>
</head>
<body>
	<div id="header"></div>
	<form action="post.jsp" method="post">
		<p>发表新帖</p>
		<p>标题： <input type="text" id="title" name="title"></input></p>
                <a>仓鼠品种：<select id="hamster" name="hamster">
                        <option value="hamster1">淇</option>
                        <option value="hamster2">路</option>
                        <option value="hamster3">平</option>
                        <option value="hamster4">浩</option>
                </select> </a>
                <a class="load">选择图片<input type="file" id="photo" name="photo" value="浏览..."></input>
                </a>
                <br><br>
                <label for="content">内容：</label>
                <textarea id="content" type="text" name="content"></textarea> 
		<br><br>

		<button  type="submit" name="save" value="发表">发表</button>
                <button type="submit" name="exit" value="退出">退出</button>
		
	</form>
    <div id="footer"></div>
</body>
</html>