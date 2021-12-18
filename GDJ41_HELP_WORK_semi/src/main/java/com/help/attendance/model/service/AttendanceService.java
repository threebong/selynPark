package com.help.attendance.model.service;

import static com.help.common.JDBCTemplate.close;
import static com.help.common.JDBCTemplate.getConnection;
import static com.help.common.JDBCTemplate.commit;
import static com.help.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.help.attendance.model.dao.AttendanceDao;
import com.help.attendance.model.vo.Attendance;

public class AttendanceService {
	private AttendanceDao dao = new AttendanceDao();
	
	//출근
	public int insertAttTime(String memberId, String attTime, String attDate) {
//		public int insertAttTime( String attTime, String attDate) {
		Connection conn = getConnection();
		int result = dao.insertAttTime(conn, memberId, attTime, attDate);
//		int result = dao.insertAttTime(conn, attTime, attDate);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	//퇴근
	public int updateLeaveTime(String memberId, String leaveTime, String attDate) {
		Connection conn = getConnection();
		int result = dao.updateLeaveTime(conn, memberId, leaveTime, attDate);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	
	//근태 조회
	public List<Attendance> selectAttendanceAll(String userId){
		Connection conn = getConnection();
		List<Attendance> list = dao.selectAttendanceAll(conn, userId);
		close(conn);
		return list;
	}

}
