package com.finalItem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.finalItem.domain.Note;
import com.finalItem.domain.SimpleNote;
import com.finalItem.util.Const;
import com.finalItem.util.DaoUtil;
import com.mchange.v2.c3p0.ComboPooledDataSource;

public class NoteDao {
	private ComboPooledDataSource dataSource = DaoUtil.getDataSource();

	public List<Note> getFiveHotNotes(){
		String sql = "select note_id, note_title from note"
				+ " where note_good > 5 "
				+ " order by note_time"
				+ " limit 5";
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet resultSet = null;	
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql);
			resultSet = psm.executeQuery();
			List<Note>notes = new ArrayList<>();
			while(resultSet.next()){
				Note note = new Note();
				note.setNote_id(resultSet.getInt("note_id"));
				note.setNote_title(resultSet.getString("note_title"));
				notes.add(note);
			}
			return notes;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			DaoUtil.close(connection, psm, resultSet);
		}
	}

	public List<String> getNoteImage(Integer note_id){
		String sql = "select image_url from image where note_id=?";
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet rs = null;	
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql);
			rs = psm.executeQuery();
			List<String>images = new ArrayList<>();
			while(rs.next()){
				String image_url = rs.getString("image_url");
				images.add(Const.FILE_IP + image_url);
			}
			return images;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DaoUtil.close(connection, psm, rs);
		}
		return null;
	}

	public List<SimpleNote> getSimpleNotes(String page_str){
		String sql = "select a.note_id, a.user_id,a.note_title,a.note_content,a.note_time,a.note_uuid, "
				+ " b.user_nickname"
				+ "  from note a, user b where a.user_id=b.user_id "
				+ " order by note_id"
				+ " desc limit ?,20";
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet rs = null;	
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql);
			psm.setInt(1, new Integer(page_str));
			rs = psm.executeQuery();
			List<SimpleNote>notes = new ArrayList<>();
			while (rs.next()) {
				SimpleNote simpleNote = new SimpleNote();
				simpleNote.setNote_id(rs.getInt("note_id"));
				simpleNote.setUser_id(rs.getInt("user_id"));
				simpleNote.setUser_name(rs.getString("user_nickname"));
				simpleNote.setNote_title(rs.getString("note_title"));
				simpleNote.setNote_time(rs.getString("note_time"));
				simpleNote.setNote_uuid(rs.getString("note_uuid"));
				notes.add(simpleNote);
			}
			return notes;
		} catch (SQLException e) {
			e.printStackTrace();
			DaoUtil.close(connection, psm, rs);
		}
		return null;
	}

	public Integer addNote(Note note) {
		Integer id = null;
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet rs = null;
		String sql = "insert into note values"
				+ "(null,?,?,?,?,"
				+ " ?,?,?);";
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			psm.setInt(1, note.getUser_id());
			psm.setInt(2, note.getRat_id());
			psm.setString(3, note.getNote_title());
			psm.setString(4, note.getNote_content());
			psm.setString(5, note.getNote_time());
			psm.setString(6, note.getNote_uuid());
			psm.setInt(7,0);
			psm.executeUpdate();
			rs = psm.getGeneratedKeys();
			if(rs.next()){
				id = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			DaoUtil.close(connection, psm, rs);
		}	
		return id;
	}

	public void addNoteImage(Integer note_id, String image_url) {
		Connection connection = null;
		PreparedStatement psm = null;
		String sql = "insert into image values (null,?,?);";
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql);
			psm.setInt(1, note_id);
			psm.setString(2, image_url);
			psm.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DaoUtil.close(connection, psm,null);
		}
	}

	public Note getOneNote(Integer note_id) {
		Integer id = null;
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet rs = null;
		String sql = "select a.*,b.user_nickname, c.rat_name"
				+ " from note a, user b, rat c"
				+ " where note_id=? and a.user_id=b.user_id and a.rat_id=c.rat_id";
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql);
			psm.setInt(1, note_id);
			rs = psm.executeQuery();
			while(rs.next()){
				Note note = new Note();
				note.setGood_num(rs.getInt("note_good"));
				note.setNote_content(rs.getString("note_content"));
				note.setNote_time(rs.getString("note_time"));
				note.setNote_title(rs.getString("note_title"));
				note.setNote_uuid(rs.getString("note_uuid"));
				note.setRat_id(rs.getInt(rs.getInt("rat_id")));
				note.setUser_id(rs.getInt("user_id"));
				note.setRat_name(rs.getString("rat_name"));
				note.setUser_name(rs.getString("user_nickname"));
				note.setNote_id(note_id);
				return note;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			DaoUtil.close(connection, psm, rs);
		}
		return null;
	}

}
