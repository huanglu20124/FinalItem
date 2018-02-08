## OverView

web期末项目——利用原生Js和jsp语言编写的一个仓鼠论坛

## Requirements

* tomcat服务器
* eclipse

## Function

* 登录注册功能并记录用户登录态
* 论坛首页查看论坛动态推送信息和排行榜
* 发布页使用富文本编辑器发送内容和图片
* 个人设置页面查看或修改个人信息

## Details

* JSP+tomact搭建的前后端全栈逻辑
* 前端通过`<%= >`输出后台返回数据，并通过部分ajax与后端通信
* 后端处理逻辑用JavaBean形式构建处理函数，并通过MVC结构分层，请求参数通过`getParameter`函数获取
* JSP控制cookie和session的记录，在页面跳转时记录会话用户态
* 弹窗通过`absolute`布局样式和js控制实现
* 各个页面和样式利用html和css编写，基本逻辑用原生js实现

## Screenshot

* 登录页面<br/>
![img](https://github.com/huanghlun/img_repository/raw/master/%E4%BB%93%E9%BC%A01.png)

* 首页<br/>
![img](https://github.com/huanghlun/img_repository/raw/master/仓鼠2.png)

* 个人页<br/>
![img](https://github.com/huanghlun/img_repository/raw/master/仓鼠3.png)

## Author

| Author | E-mail |
| :------:  | :------: |
| Eric_Wong |  564945308@qq.com |
| huanglu | 845758437@qq.com |
