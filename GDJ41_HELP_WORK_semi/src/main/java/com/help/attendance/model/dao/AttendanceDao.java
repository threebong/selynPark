package com.help.attendance.model.dao;

import static com.help.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.help.attendance.model.vo.Attendance;

public class AttendanceDao {
	private Properties prop = new Properties();
	
	public AttendanceDao() {
		try {
			String path = AttendanceDao.class.getResource("/sql/attendance/attendance_sql.properties").getPath();
			prop.load(new FileReader(path));
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	//출근등록
	public int insertAttTime(Connection conn, String memberId, String attTime, String attDate, String attStatus) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertAttTime");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, attTime);
			pstmt.setString(3, attDate);
			pstmt.setString(4, attStatus);
			
			result = pstmt.executeUpdate();
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	
	//출근/퇴근시간 출력
	public Attendance outputAttTime(Connection conn, String memberId, String attDate) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Attendance a = null;
		String sql = prop.getProperty("outputAttTime");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,memberId);
			pstmt.setString(2, attDate);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				a = Attendance.builder()
						.memberId(rs.getString("MEMBER_ID"))
						.attTime(new SimpleDateFormat("HH:mm").format(rs.getDate("ATT_TIME")))
						.leaveTime(rs.getDate("LEAVE_TIME")==null?"퇴근 정보가 없습니다": new SimpleDateFormat("HH:mm").format(rs.getDate("LEAVE_TIME")))
						.attDate(rs.getString("ATT_DATE"))
						.attStatus(rs.getString("ATT_STATUS"))
						.build();
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return a;
	}
	
	
	//퇴근등록
	public int updateLeaveTime(Connection conn, String memberId, String leaveTime, String attDate, String attStatus) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateLeaveTime");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, leaveTime);
			pstmt.setString(2, attStatus);
			pstmt.setString(3, memberId);
			pstmt.setString(4, attDate);
			result = pstmt.executeUpdate();
			
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
		
	}
	
	
	//근태 조회(사원)
	public List<Attendance> selectAttendanceMonthly(Connection conn, String memberId, String month){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Attendance> list = new ArrayList();
		try {
			pstmt = conn.prepareStatement(prop.getProperty("attendanceMonthly"));
			pstmt.setString(1,  memberId);
			pstmt.setString(2,  month);
			rs = pstmt.executeQuery();
	
		while(rs.next()) {
			Attendance a = Attendance.builder()
					.memberId(rs.getString("MEMBER_ID"))
					.attTime(new SimpleDateFormat("HH시 mm분").format(rs.getDate("ATT_TIME")))
					.leaveTime(rs.getDate("LEAVE_TIME")==null?"퇴근 정보가 없습니다": new SimpleDateFormat("HH시 mm분").format(rs.getDate("LEAVE_TIME")))
					.attDate(new SimpleDateFormat("yyyy년 MM월 dd일").format(rs.getDate("ATT_DATE")))
					.attStatus(rs.getString("ATT_STATUS"))
					.build();
			list.add(a);
		}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return list;
	}

}
