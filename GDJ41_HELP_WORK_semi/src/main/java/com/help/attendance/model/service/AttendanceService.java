//package com.help.attendance.model.service;
//
//import java.sql.Connection;
//import java.util.List;
//
//import com.help.attendance.model.dao.AttendanceDao;
//import com.help.attendance.model.vo.Attendance;
//
//public class AttendanceService {
//	private AttendanceDao dao = new AttendanceDao();
//	
//	//근태 조회
//	public List<Attendance> selectAttendanceAll(String userId){
//		Connection conn = getConnection();
//		List<Attendance> list = dao.selectAttendanceAll(conn, userId);
//		close(conn);
//		return list;
//	}
//
//}
