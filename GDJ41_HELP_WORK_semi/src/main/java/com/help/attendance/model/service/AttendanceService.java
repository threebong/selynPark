package com.help.attendance.model.service;

import com.help.attendance.model.dao.AttendanceDao;

public class AttendanceService {
	private AttendanceDao dao = new AttendanceDao();
	
	//근태 조회
//	public List<Attendance> selectAttendanceAll(String userId){
//		Connection conn = getConnection();
//		List<Attendance> list = dao.selectAttendanceAll(conn, userId);
//		close(conn);
//		return list;
//	}

}
