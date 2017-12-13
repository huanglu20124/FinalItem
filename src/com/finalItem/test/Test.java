package com.finalItem.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import com.finalItem.dao.NoteDao;
import com.finalItem.domain.Note;
import com.finalItem.domain.SimpleNote;
import com.finalItem.util.DaoUtil;
import com.finalItem.util.TimeUtil;
import com.mchange.v2.c3p0.ComboPooledDataSource;


public class Test {
	public static void main(String[] args) {
		String string = "sdfsdfsdg\r\n<img>sfsdg<img>";
		System.out.println(string.replaceFirst("<img>", "---"));
	}
	
	private void add() {
		Note note = new Note();
		note.setNote_time(TimeUtil.getCurrentTime());
		note.setNote_title("test");
		note.setNote_content("sfsdf");
		note.setNote_uuid("wsfsdf");
		note.setUser_id(1);
		note.setRat_id(1);
		System.out.println(new NoteDao().addNote(note));
	}
	
	public static void test2(){
		//new NoteDao().getNoteImage(1);
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://119.23.229.19:3306/finalItem?useUnicode=true&amp;characterEncoding=utf-8";
		String username = "student";
		String password = "137137lu";
		Connection conn = null;
		try {
			Class.forName(driver); //classLoader,加载对应驱动
			try {
				conn = (Connection) DriverManager.getConnection(url, username, password);
				System.out.println("xxx");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		System.out.println("x");
	}
}
