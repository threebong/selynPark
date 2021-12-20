package com.help.project.schedule.model.controller;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import com.help.project.work.model.dao.WorkDao;
import static com.help.common.JDBCTemplate.*;

public class ScheduleDao {

	private Properties prop=new Properties();
	public ScheduleDao() {
		try {
			prop.load(new FileReader(WorkDao.class.getResource("/").getPath()+"sql/project/schedule/schedule_sql.properties"));
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
	
	}
}
