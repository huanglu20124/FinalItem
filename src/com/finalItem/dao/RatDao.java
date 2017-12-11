package com.finalItem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.finalItem.domain.Rat;
import com.finalItem.util.DaoUtil;
import com.mchange.v2.c3p0.ComboPooledDataSource;

public class RatDao {
	private ComboPooledDataSource dataSource = DaoUtil.getDataSource();

	public List<Rat> getHotRats() {
		String sql = "select * from rat order by good_num desc limit 0,9";
		Connection connection = null;
		PreparedStatement psm = null;
		ResultSet resultSet = null;	
		try {
			connection = dataSource.getConnection();
			psm = connection.prepareStatement(sql);
			resultSet = psm.executeQuery();
			List<Rat>list = new ArrayList<>();
			while(resultSet.next()){
				Rat rat = new Rat();
				rat.setRat_id(resultSet.getInt("rat_id"));
				rat.setRat_name(resultSet.getString("rat_name"));
				rat.setRat_description(resultSet.getString("rat_description"));
				list.add(rat);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DaoUtil.close(connection, psm, resultSet);
		}
		return null;
	}
	
}
