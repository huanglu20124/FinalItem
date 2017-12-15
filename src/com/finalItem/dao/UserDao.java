package com.finalItem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.finalItem.domain.User;
import com.finalItem.util.DaoUtil;
import com.mchange.v2.c3p0.ComboPooledDataSource;


public class UserDao {
	private ComboPooledDataSource dataSource = DaoUtil.getDataSource();
	
	public Integer registerUser(User user){
		Integer id = null;
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet rs = null;
		String sql = "insert into user values"
				+ "(null,?,?,?,"
				+ " ?,?,?,"
				+ " ?,?,?,"
				+ " ?);";
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			psm.setString(1, user.getUser_account());
			psm.setString(2, user.getUser_password());
			psm.setString(3, user.getUser_nickname());
			psm.setString(4, user.getSex());
			psm.setString(5, user.getUser_register_time());
			psm.setString(6, user.getUser_problem());
			psm.setString(7, user.getUser_answer());
			psm.setInt(8, user.getUser_good());
			psm.setString(9, user.getTelephone());
			psm.setString(10, user.getEmail());
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

	public User loginUser(String user_acccount, String user_password){
		String sql = "select * from user where user_account=? and user_password=?";
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet resultSet = null;	
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql);
			psm.setString(1, user_acccount);
			psm.setString(2, user_password);
			resultSet = psm.executeQuery();
			while(resultSet.next()){
				User user = new User();
				user.setEmail(resultSet.getString("email"));
				user.setTelephone(resultSet.getString("telephone"));
				user.setSex(resultSet.getString("sex"));
				user.setUser_account(resultSet.getString("user_account"));
				user.setUser_answer(resultSet.getString("user_answer"));
				user.setUser_problem(resultSet.getString("user_problem"));
				user.setUser_good(resultSet.getInt("user_good"));
				user.setUser_id(resultSet.getInt("user_id"));
				user.setUser_nickname(resultSet.getString("user_nickname"));
				user.setUser_register_time(resultSet.getString("user_register_time"));
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			DaoUtil.close(connection, psm, resultSet);
		}
		return null;
	}

	
    public List<User> getUserGoodRank() {
		String sql = "select * from user order by user_good desc limit 0,10";
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet resultSet = null;	
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql);
			List<User>users = new ArrayList<>();
			resultSet = psm.executeQuery();
			while(resultSet.next()){
				User user = new User();
				user.setEmail(resultSet.getString("email"));
				user.setTelephone(resultSet.getString("telephone"));
				user.setSex(resultSet.getString("sex"));
				user.setUser_account(resultSet.getString("user_account"));
				user.setUser_answer(resultSet.getString("user_answer"));
				user.setUser_problem(resultSet.getString("user_problem"));
				user.setUser_good(resultSet.getInt("user_good"));
				user.setUser_id(resultSet.getInt("user_id"));
				user.setUser_nickname(resultSet.getString("user_nickname"));
				user.setUser_register_time(resultSet.getString("user_register_time"));
				users.add(user);
			}
			return users;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			DaoUtil.close(connection, psm, resultSet);
		}
	}

	
    public int updateUser(User user) {
    	System.out.println(user.getUser_nickname() + "--" + user.getEmail() + "--" + user.getTelephone() + "---" + user.getSex() + "--" + user.getUser_id());
		String sql = "update user set " 
				+ "user_nickname=?, sex=?, telephone=?,email=?"
				+ " where user_id=?";
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet resultSet = null;	
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql);
			psm.setString(1, user.getUser_nickname());
			psm.setString(2, user.getSex());
			psm.setString(3, user.getTelephone());
			psm.setString(4, user.getEmail());
			psm.setInt(5, user.getUser_id());
			return psm.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}finally {
			DaoUtil.close(connection, psm, resultSet);
		}
	}
}
