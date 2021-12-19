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
	public int insertAttTime(String memberId) {
//		public int insertAttTime( String attTime, String attDate) {
		Connection conn = getConnection();
		int result = dao.insertAttTime(conn, memberId);
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
	public int updateLeaveTime(String memberId, String attDate) {
		Connection conn = getConnection();
		int result = dao.updateLeaveTime(conn, memberId, attDate);
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
