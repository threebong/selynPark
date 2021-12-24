package com.help.admin.model.dao;

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

import com.help.admin.model.vo.AdminAttendance;
import com.help.admin.model.vo.AdminListMember;


public class AdminDao {
	
	private Properties prop = new Properties();

		public AdminDao() {
		
		try {
			String path=AdminDao.class.getResource("/sql/admin/admin_sql.properties").getPath();
			prop.load(new FileReader(path));
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
		
	//등록사원 조회 페이지당
	public List<AdminListMember> memberAll(Connection conn, int cPage, int numPerPage){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminListMember> list = new ArrayList();
		
		try {
			pstmt = conn.prepareStatement(prop.getProperty("memberAll"));
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				AdminListMember alm = AdminListMember.builder()
						.memberName(rs.getString("MEMBER_NAME"))
						.memberId(rs.getString("MEMBER_ID"))
						.deptName(rs.getString("DEPT_NAME"))
						.positionName(rs.getString("POSITION_NAME"))
						.memberPhone(rs.getString("MEMBER_PHONE"))
						.build();
				list.add(alm);
			}
			
			
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
		
	}
	
	
	//등록사원 총 인원수
	public int MemberAllCount(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		String sql = prop.getProperty("memberAllCount");
		
		try {
			
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
			
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			
		} return result;

	}
	
	//대기사원 조회
	public List<AdminListMember> waitMemberAll(Connection conn){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminListMember> list = new ArrayList();
		
		try {
			pstmt = conn.prepareStatement(prop.getProperty("waitMemberAll"));
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				AdminListMember alm = AdminListMember.builder()
						.memberName(rs.getString("MEMBER_NAME"))
						.memberId(rs.getString("MEMBER_ID"))
						.deptName(rs.getString("DEPT_NAME"))
						.positionName(rs.getString("POSITION_NAME"))
						.memberPhone(rs.getString("MEMBER_PHONE"))
						.build();
				list.add(alm);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
		
	}
	
	
	//출퇴근 조회 첫 페이지
	public List<AdminAttendance> adminAttendanceFirst(Connection conn, String day){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminAttendance> list = new ArrayList();
		
		try {
			pstmt = conn.prepareStatement(prop.getProperty("adminAttendance"));
			pstmt.setString(1, day);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				AdminAttendance aa = AdminAttendance.builder()
						.memberName(rs.getString("MEMBER_NAME"))
						.memberId(rs.getString("MEMBER_ID"))
						.deptName(rs.getString("DEPT_NAME")==null?"미등록":rs.getString("DEPT_NAME"))
						.positionName(rs.getString("POSITION_NAME")==null?"미등록":rs.getString("POSITION_NAME"))
						.attTime(rs.getDate("ATT_TIME")==null?"출근 전": new SimpleDateFormat("HH시 mm분").format(rs.getDate("ATT_TIME")))
						.leaveTime(rs.getDate("LEAVE_TIME")==null?"퇴근 전": new SimpleDateFormat("HH시 mm분").format(rs.getDate("LEAVE_TIME")))
						.build();
				list.add(aa);
				System.out.println(list);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return list;
		
		
	}
	

}
