package com.finalItem.domain;

public class User {
	private Integer user_id;
	private String user_account; // 用户账号
	private String user_password; // 用户密码
	private String user_nickname; // 用户昵称
	private String sex;
	private String user_register_time; // 用户注册时间
	private String user_problem;// 密保问题
	private String user_answer; // 密保回答
	private Integer user_good; // 点赞数量

	private String telephone;
	private String email;

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getUser_account() {
		return user_account;
	}

	public void setUser_account(String user_account) {
		this.user_account = user_account;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	public String getUser_register_time() {
		return user_register_time;
	}

	public void setUser_register_time(String user_register_time) {
		this.user_register_time = user_register_time;
	}

	public String getUser_problem() {
		return user_problem;
	}

	public void setUser_problem(String user_problem) {
		this.user_problem = user_problem;
	}

	public String getUser_answer() {
		return user_answer;
	}

	public void setUser_answer(String user_answer) {
		this.user_answer = user_answer;
	}

	public Integer getUser_good() {
		return user_good;
	}

	public void setUser_good(Integer user_good) {
		this.user_good = user_good;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
