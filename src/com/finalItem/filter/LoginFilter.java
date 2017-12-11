package com.finalItem.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.finalItem.domain.User;

public class LoginFilter implements Filter{

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;
		String path = request.getRequestURI();
		if(path.indexOf("/login.jsp") > -1 || path.indexOf("/register.jsp") > -1){
			//登录界面无需过滤
			chain.doFilter(request, response);
			return ;
		}else {
			User user = (User) request.getSession().getAttribute("user");
			if(user == null){
				//没有登录，重定向到登录界面
				response.sendRedirect("/final_item/login.jsp");
				System.out.println("重定向到登录界面");
			}else {
				chain.doFilter(request, response);
				System.out.println("登录成功");
			}
		}	
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
