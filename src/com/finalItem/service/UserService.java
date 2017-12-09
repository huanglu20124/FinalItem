package com.finalItem.service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.finalItem.dao.UserDao;
import com.finalItem.domain.User;
import com.finalItem.util.TimeUtil;

public class UserService {
	private UserDao userDao = new UserDao();
	
	public String register(HttpServletRequest request, HttpServletResponse response){
		String msg = "";
		User user = new User();
		//昵称先默认为用户账号
		user.setUser_account(request.getParameter("user_account"));
		user.setUser_nickname(request.getParameter("user_account"));
		user.setUser_password(request.getParameter("user_password"));
		user.setTelephone(request.getParameter("telephone"));
		user.setEmail(request.getParameter("email"));
		user.setSex("男");//默认为男性
		user.setUser_answer(request.getParameter("user_answer"));
		user.setUser_problem(request.getParameter("user_problem"));
		user.setUser_good(0);
		user.setUser_register_time(TimeUtil.getCurrentTime());
		try {
			Integer user_id = userDao.registerUser(user);
			user.setUser_id(user_id);
			msg = "注册成功，5秒后将跳转到主界面";
			response.setHeader("refresh", "5;url=/final_item/main.jsp");
			//放到session里面
			request.getSession().setAttribute("user", user);
			request.setAttribute("msg", msg);
			//转发到success.jsp
			request.getRequestDispatcher("/success.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			msg = "注册失败";
		}
		return msg;
	}
	
	public String login(HttpServletRequest request, HttpServletResponse response){
		String msg = "";
		String user_acccount = request.getParameter("user_account");
		String user_password = request.getParameter("user_password");
		if(user_acccount != null && user_password != null){
			try {
				User user = userDao.loginUser(user_acccount,user_password);
				if(user == null){
					msg = "账号不存在或密码错误";
				}else {
					//登录成功,存在session，返回主页
					request.getSession().setAttribute("user", user);
					//如果选择自动登录
					String autoLogin = request.getParameter("autoLogin");
					if(autoLogin != null){
						//放到cookie里，下次自动登录
						Cookie account_cookie = new Cookie("user_account", user_acccount);
					    Cookie password_cookie = new Cookie("user_password", user_password);
					    response.addCookie(account_cookie);
					    response.addCookie(password_cookie);
					}
					response.sendRedirect("/final_item/main.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
				msg = "登录失败";
			}
		}else {
			msg = "账号或密码不能为空";
		}
		return msg;
	}

	public String logout(HttpServletRequest request, HttpServletResponse response){
		String msg = "";
		HttpSession session = request.getSession(false);
		if(session != null){
			session.invalidate();
			msg = "退出登录成功";
		}else {
			msg = "你尚未登录，退出登录失败";
		}
		return msg;
	}
	
}
