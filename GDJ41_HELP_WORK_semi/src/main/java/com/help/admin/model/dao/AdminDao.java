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
import com.help.admin.model.vo.DeptAndPosition;


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
	public int memberAllCount(Connection conn) {
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
	
	
	//출퇴근 조회 페이징
	public List<AdminAttendance> adminAttendance(Connection conn, String day, int cPage, int numPerPage){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminAttendance> list = new ArrayList();
		
		try {
			pstmt = conn.prepareStatement(prop.getProperty("adminAttendance"));
			pstmt.setString(1, day);
			pstmt.setInt(2, (cPage-1)*numPerPage+1);
			pstmt.setInt(3, cPage*numPerPage);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				AdminAttendance aa = AdminAttendance.builder()
						.memberName(rs.getString("MEMBER_NAME"))
						.memberId(rs.getString("MEMBER_ID"))
						.deptName(rs.getString("DEPT_NAME")==null?"미등록":rs.getString("DEPT_NAME"))
						.positionName(rs.getString("POSITION_NAME")==null?"미등록":rs.getString("POSITION_NAME"))
						.attTime(rs.getDate("ATT_TIME")==null?"출근 전": new SimpleDateFormat("HH시 mm분").format(rs.getDate("ATT_TIME")))
						.leaveTime(rs.getDate("LEAVE_TIME")==null?"퇴근 전": new SimpleDateFormat("HH시 mm분").format(rs.getDate("LEAVE_TIME")))
						.attStatus(rs.getString("ATT_STATUS"))
						.build();
				list.add(aa);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return list;
		
		
	}
	
	//출퇴근 조회 count
	public int adminAttendanceCount(Connection conn, String day) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		String sql = prop.getProperty("adminAttendanceCount");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, day);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt("COUNT(*)");
			}
			
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			
		} return result;

	}
	
	
	//관리자가 출퇴근 수정
	public int updateAttendance(Connection conn, String attTime, String leaveTime, String attStatus, String memberId, String attDate) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateMemberAttendance");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, attTime);
			pstmt.setString(2, leaveTime);
			pstmt.setString(3, attStatus);
			pstmt.setString(4, memberId);
			pstmt.setString(5, attDate);
			result=pstmt.executeUpdate();
			
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			
		} return result;
		
		
	}
	
	//부서명 전체 가져오기
	public List<DeptAndPosition> deptAllList(Connection conn){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<DeptAndPosition> list = new ArrayList();
		
		try {
			pstmt = conn.prepareStatement(prop.getProperty("deptAll"));
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DeptAndPosition d = DeptAndPosition.builder()
						.deptCode(rs.getString("DEPT_CODE"))
						.deptName(rs.getString("DEPT_NAME"))
						.build();
				list.add(d);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
	
	
	//직급명 전체 가져오기
	public List<DeptAndPosition> positionAllList(Connection conn){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<DeptAndPosition> list = new ArrayList();
		
		try {
			pstmt = conn.prepareStatement(prop.getProperty("positionAll"));
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				DeptAndPosition p = DeptAndPosition.builder()
						.positionCode(rs.getString("POSITION_CODE"))
						.positionName(rs.getString("POSITION_NAME"))
						.build();
				list.add(p);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
	
	
	//대기사원 부서,직급 등록
	public int updateWaitMember(Connection conn, String memberId, String deptCode, String positionCode) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateWaitMember");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, deptCode);
			pstmt.setString(2, positionCode);
			pstmt.setString(3, memberId);
			result=pstmt.executeUpdate();
			
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			
		} return result;
		
		
	}
	
	//사원 정보수정 -> 이름,부서,직급,연락처
	public int updateInfoMember(Connection conn, String memberId, String memberName, String deptCode, String positionCode, String memberPhone) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateInfoMember");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memberName);
			pstmt.setString(2, deptCode);
			pstmt.setString(3, positionCode);
			pstmt.setString(4, memberPhone);
			pstmt.setString(5, memberId);
			result=pstmt.executeUpdate();
			
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			
		} return result;
		
		
	}
	

}
