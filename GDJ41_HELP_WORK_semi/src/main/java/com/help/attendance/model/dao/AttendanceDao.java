//package com.help.attendance.model.dao;
//
////import static com.member.common.JDBCTemplate.close;
//import java.io.FileReader;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Properties;
//
//import com.help.attendance.model.vo.Attendance;
//
//public class AttendanceDao {
//	private Properties prop = new Properties();
//	
//	public AttendanceDao() {
//		try {
//			String path = AttendanceDao.class.getResource("/sql/attendance/attendance_sql.properties").getPath();
//			prop.load(new FileReader(path));
//		} catch(IOException e) {
//			e.printStackTrace();
//		}
//	}
//	
//	
//	//근태 조회(사원)
//	public List<Attendance> selectAttendanceAll(Connection conn, String userId){
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		List<Attendance> list = new ArrayList();
//		try {
//			pstmt = conn.prepareStatement(prop.getProperty("attendanceAll"));
//			pstmt.setString(1,  userId);
//			rs = pstmt.executeQuery();
//	
//		while(rs.next()) {
//			Attendance a = Attendance.bulider()
//					.memberId(rs.getString("member_Id"))
//					.attTime(rs.getDate("att_Time"))
//					.leaveTime(rs.getDate("leave_Time"))
//					.attDate(rs.getDate("att_Date"))
//					.attStatus(rs.getString("att_status"))
//					.build();
//			list.add(a);
//		}
//			
//		} catch(SQLExection e) {
//			e.printStackTrace();
//		} finally {
//			close(rs);
//			close(pstmt);
//		} return list;
//	}
//
//}
