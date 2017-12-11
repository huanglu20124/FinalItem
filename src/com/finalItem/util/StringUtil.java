package com.finalItem.util;

public class StringUtil {
	public static String getFixString(String str,int length){
		if(str.length() >length) return str;
		else {
			//用空格将字符串补到该长度
			StringBuilder sb = new StringBuilder(str);
			int add_size = length - str.length();
			while(add_size > 0){
				sb.append("  ");
				add_size--;
			}
			System.out.println(sb.length());
			return sb.toString();
		}

	}
}
