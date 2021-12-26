package com.help.project.schedule.model.service;
import static com.help.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.help.project.normal.model.vo.NormalComment;
import com.help.project.schedule.model.dao.ScheduleDao;
import com.help.project.schedule.model.vo.ScheComment;
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

	public int updateScheContent(Schedule s, int contentNo) {

		Connection conn = getConnection();
		
		int result = dao.updateScheContent(conn,s,contentNo);
		
		close(conn);
		
		return result;
	}

	public void insertScheCommenet(ScheComment sc) {

		Connection conn = getConnection();

		int result = dao.insertScheCommenet(conn,sc);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

	}

	public List<ScheComment> selectScheComment(int contentNo) {
		Connection conn = getConnection();
		
		List<ScheComment> scList = dao.selectScheComment(conn,contentNo);
		
		close(conn);
		
		return scList;
	}

	public void deleteScheComment(int contentNo) {
		Connection conn = getConnection();
		int result = dao.deleteScheComment(conn,contentNo);
		
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
	}

}
