package com.finalItem.domain;

/**
 * 首页显示的基本数据
 * @author huanglu
 */
public class SimpleNote {
	private Integer note_id;
	private Integer user_id;
	private String user_name;
	private String note_title; // 标题;
	private String note_time; // 时间
	private String note_uuid; // 唯一id，后期索引搜索可能用到
	public Integer getNote_id() {
		return note_id;
	}
	public void setNote_id(Integer note_id) {
		this.note_id = note_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getNote_title() {
		return note_title;
	}
	public void setNote_title(String note_title) {
		this.note_title = note_title;
	}
	public String getNote_time() {
		return note_time;
	}
	public void setNote_time(String note_time) {
		this.note_time = note_time;
	}
	public String getNote_uuid() {
		return note_uuid;
	}
	public void setNote_uuid(String note_uuid) {
		this.note_uuid = note_uuid;
	}
	
}
