package com.finalItem.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.finalItem.dao.RatDao;
import com.finalItem.domain.Rat;

public class RatService {
	private RatDao ratDao = new RatDao();
	
	public List<Rat> getHotRats(HttpServletRequest request, HttpServletResponse response){
		//返回9只热门仓鼠
		List<Rat>list = ratDao.getHotRats();
		if(list == null) list = new ArrayList<>();
		return list;
		
	}
}
