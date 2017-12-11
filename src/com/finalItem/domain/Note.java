package com.finalItem.domain;

import java.util.List;

/**
 * 用于详情页显示的
 * 
 * @author huanglu
 */
public class Note extends SimpleNote {
	private String note_content; // 内容;
	private List<String> images; // 帖子图片
	private Integer good_num; // 点赞数量

	public String getNote_content() {
		return note_content;
	}

	public void setNote_content(String note_content) {
		this.note_content = note_content;
	}

	public List<String> getImages() {
		return images;
	}

	public void setImages(List<String> images) {
		this.images = images;
	}

	public Integer getGood_num() {
		return good_num;
	}

	public void setGood_num(Integer good_num) {
		this.good_num = good_num;
	}

	
}
