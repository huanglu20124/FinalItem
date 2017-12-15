<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
				<p class="name_p">席梦思</p>
				<p class="optional_p">
					<span>未填写行业</span>
					<span>未填写职位</span>
					<span>未填写姓名</span>
					<span>未填写地址</span>
					<span>未填写性别</span>
					<span>未填写生日</span>
				</p>
				<p class="desc_p">个人简介</p>
			</div>
		</div>

		<div class="own_item">
			<p class="own_item_hd"><span>我的帖子</span></p>
			<div class="note_container">
				<div class="left_note">
					<p class="note_hd"><a href="detail.jsp?note_id=1">老公公老婆婆的养殖</a></p>
					<div class="note_desc">
						<img src="images/头像.png" class="flex-none" style="height: 20px; width: auto;">
						<span>恩比德</span>
						<span>2017-12-15</span>
						<span>老公公老婆婆</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>