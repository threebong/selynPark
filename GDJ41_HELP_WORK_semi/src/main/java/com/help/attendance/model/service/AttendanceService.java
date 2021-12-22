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
	
	//출근등록
	public int insertAttTime(String memberId, String attTime, String attDate, String attStatus) {
//		public int insertAttTime( String attTime, String attDate) {
		Connection conn = getConnection();
		int result = dao.insertAttTime(conn, memberId,attTime,attDate,attStatus);
		if(result>0) {
			commit(conn); 
			//출근정보 저장되고 다시 가져오려면 여기서 다시 dao로
		}
		else rollback(conn);
		return result;
	}
	
	//출근시간출력
	public Attendance outputAttTime(String memberId, String attDate) {
		Connection conn = getConnection();
		Attendance a = dao.outputAttTime(conn,memberId,attDate);
		close(conn);
		return a;
	}
	
	//퇴근등록
	public int updateLeaveTime(String memberId, String leaveTime, String attDate, String attStatus) {
		Connection conn = getConnection();
		int result = dao.updateLeaveTime(conn, memberId, leaveTime, attDate, attStatus);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	
	//근태 조회
	public List<Attendance> selectAttendanceMonthly(String memberId, String month){
		Connection conn = getConnection();
		List<Attendance> list = dao.selectAttendanceMonthly(conn, memberId, month);
		close(conn);
		return list;
	}

}
