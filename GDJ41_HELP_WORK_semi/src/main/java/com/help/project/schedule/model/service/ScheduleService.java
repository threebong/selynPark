package com.help.project.schedule.model.service;
import static com.help.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.help.project.schedule.model.controller.ScheduleDao;
import com.help.project.schedule.model.vo.Schedule;

public class ScheduleService {

	private ScheduleDao dao = new ScheduleDao();
	
	public int insertSchedule(Schedule sc) {

		Connection conn = getConnection();
		
		int result = dao.insertSchedule(conn,sc);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int selectScheduleNo(Schedule sc) {
		Connection conn = getConnection();
		int scheduleNo = dao.selectScheduleNo(conn,sc);
		close(conn);
		return scheduleNo;
	}

	public int insertScheduleAttend(List<Map<String, Object>> saList) {

		Connection conn = getConnection();
		
		int result = dao.insertScheduleAttend(conn,saList);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
		
	}

}
