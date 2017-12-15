package com.finalItem.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.print.attribute.standard.RequestingUserName;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.group.ChannelCoordinator;
import org.apache.el.parser.SimpleNode;

import com.finalItem.dao.UserDao;
import com.finalItem.domain.User;
import com.finalItem.util.TimeUtil;

import sun.applet.resources.MsgAppletViewer;

public class UserService {
	private UserDao userDao = new UserDao();

	public String register(HttpServletRequest request, HttpServletResponse response) {
		String msg = "";
		User user = new User();
		// 昵称先默认为用户账号
		user.setUser_account(request.getParameter("user_account"));
		user.setUser_nickname(request.getParameter("user_account"));
		user.setUser_password(request.getParameter("user_password"));
		user.setTelephone(request.getParameter("telephone"));
		user.setEmail(request.getParameter("email"));
		user.setSex("男");// 默认为男性
		user.setUser_answer(request.getParameter("user_answer"));
		user.setUser_problem(request.getParameter("user_problem"));
		user.setUser_good(0);
		user.setUser_register_time(TimeUtil.getCurrentTime());
		Integer user_id = userDao.registerUser(user);
		if (user_id == null) {
			msg = "注册失败";
		} else {
			user.setUser_id(user_id);
			msg = "注册成功，5秒后将跳转到主界面";
			response.setHeader("refresh", "5;url=/final_item/index.jsp?page=0");
			// 放到session里面
			request.getSession().setAttribute("user", user);
			request.setAttribute("msg", msg);
			// 转发到success.jsp
			try {
				request.getRequestDispatcher("/success.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return msg;
	}

	public String login(HttpServletRequest request, HttpServletResponse response) {
		String msg = "";
		String user_acccount = request.getParameter("user_account");
		String user_password = request.getParameter("user_password");
		if (user_acccount != null && user_password != null
				&& (!user_acccount.equals("")) && (!user_password.equals(""))) {
			User user = userDao.loginUser(user_acccount, user_password);
			if (user == null) {
				msg = "账号不存在或密码错误";
			} else {
				// 登录成功,存在session，返回主页
				request.getSession().setAttribute("user", user);
				// 如果选择自动登录
				String autoLogin = request.getParameter("autoLogin");
				if (autoLogin != null) {
					// 放到cookie里，下次自动登录
					Cookie account_cookie = new Cookie("user_account", user_acccount);
					Cookie password_cookie = new Cookie("user_password", user_password);
					Cookie autoLogin_cookie = new Cookie("autoLogin", "autoLogin");
					response.addCookie(account_cookie);
					response.addCookie(password_cookie);
					response.addCookie(autoLogin_cookie);
				}
				try {
					response.sendRedirect("/final_item/index.jsp?page=0");
					System.out.println("登录成功");
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
		} else {
			msg = "账号或密码不能为空";
		}
		return msg;
	}

	public String logout(HttpServletRequest request, HttpServletResponse response) {
		String msg = "";
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
			msg = "退出登录成功";
		} else {
			msg = "你尚未登录，退出登录失败";
		}
		return msg;
	}

	public List<User> getUserGoodRank(HttpServletRequest request, HttpServletResponse response) {
		// 获取用户排行榜,上限10个
		List<User> list = userDao.getUserGoodRank();
		if(list == null) list = new ArrayList<>();
		return list;
	}

	public String setUserInfo(HttpServletRequest request, HttpServletResponse response){
		//先从session里获取本人原来的信息
/*		Enumeration<String>enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String string = (String) enumeration.nextElement();
			System.out.println(string);
		}*/
		User user = (User)request.getSession().getAttribute("user");
		String user_nickname = request.getParameter("user_nickname");
		String telephone = request.getParameter("telephone");
		String email = request.getParameter("email");
		String sex = request.getParameter("sex");
		if(user_nickname != null) user.setUser_nickname(user_nickname);
		if(telephone != null)  user.setTelephone(telephone);
		if(email != null) user.setEmail(email);
		if(sex != null) user.setSex(sex);
		int update_ans = userDao.updateUser(user);
		if(update_ans == 0) return "修改失败";
		else {
			request.getSession().setAttribute("user", user);
			return "修改成功";
		}
	}
}
