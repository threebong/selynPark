package com.help.admin.model.service;

import static com.help.common.JDBCTemplate.close;
import static com.help.common.JDBCTemplate.commit;
import static com.help.common.JDBCTemplate.getConnection;
import static com.help.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.help.admin.model.dao.AdminDao;
import com.help.admin.model.vo.AdminAttendance;
import com.help.admin.model.vo.AdminListMember;
import com.help.admin.model.vo.DeptAndPosition;

public class AdminService {
	private AdminDao dao = new AdminDao();
	
	
	public List<AdminListMember> memberAll(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<AdminListMember> list = dao.memberAll(conn, cPage, numPerPage);
		close(conn);
		return list;
	}
	
	
	public int memberAllCount() {
		Connection conn = getConnection();
		int result = dao.memberAllCount(conn);
		close(conn);
		return result;
	}
	
	public List<AdminListMember> waitMemberAll(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<AdminListMember> list = dao.waitMemberAll(conn, cPage, numPerPage);
		close(conn);
		return list;
	}
	
	
	public int waitMemberAllCount() {
		Connection conn = getConnection();
		int result = dao.waitMemberAllCount(conn);
		close(conn);
		return result;
	}
	
	
	public List<AdminAttendance> adminAttendance(String day, int cPage, int numPerPage){
		Connection conn = getConnection();
		List<AdminAttendance> list = dao.adminAttendance(conn, day, cPage, numPerPage);
		close(conn);
		return list;
	}
	
	
	public int adminAttendanceCount(String day) {
		Connection conn = getConnection();
		int result = dao.adminAttendanceCount(conn, day);
		close(conn);
		return result;
	}
	
	
	public int updateAttendance(String attTime, String leaveTime, String attStatus, String memberId, String attDate) {
		Connection conn = getConnection();
		int result = dao.updateAttendance(conn, attTime, leaveTime, attStatus, memberId, attDate);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	public List<DeptAndPosition> deptAllList(){
		Connection conn = getConnection();
		List<DeptAndPosition> list = dao.deptAllList(conn);
		close(conn);
		return list;
	}
	
	
	public List<DeptAndPosition> positionAllList(){
		Connection conn = getConnection();
		List<DeptAndPosition> list = dao.positionAllList(conn);
		close(conn);
		return list;
	}
	
	
	public int updateWaitMember(String memberId, String deptCode, String positionCode) {
		Connection conn = getConnection();
		int result = dao.updateWaitMember(conn, memberId, deptCode, positionCode);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	
	public int updateInfoMember(String memberId, String memberName, String deptCode, String positionCode, String memberPhone) {
		Connection conn = getConnection();
		int result = dao.updateInfoMember(conn, memberId, memberName, deptCode, positionCode, memberPhone);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	
	public int updateDeptName(String deptCode, String deptName) {
		Connection conn = getConnection();
		int result = dao.updateDeptName(conn, deptCode, deptName);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}

	public int updatePositionName(String positionCode, String positionName) {
		Connection conn = getConnection();
		int result = dao.updatePositionName(conn, positionCode, positionName);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	
	public int deleteDept(String deptCode) {
		Connection conn = getConnection();
		int result = dao.deleteDept(conn, deptCode);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
	
	
	
	public int deletePosition(String positionCode) {
		Connection conn = getConnection();
		int result = dao.deletePosition(conn, positionCode);
		if(result>0) commit(conn);
		else rollback(conn);
		return result;
	}
}
