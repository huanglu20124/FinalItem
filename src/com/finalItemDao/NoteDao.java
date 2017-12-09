package com.finalItemDao;

import com.finalItem.util.DaoUtil;
import com.mchange.v2.c3p0.ComboPooledDataSource;

public class NoteDao {
	private ComboPooledDataSource dataSource = DaoUtil.getDataSource();
}
