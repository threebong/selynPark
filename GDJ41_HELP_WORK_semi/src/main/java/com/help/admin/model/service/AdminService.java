package com.help.admin.model.service;

import static com.help.common.JDBCTemplate.close;
import static com.help.common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.help.admin.model.dao.AdminDao;
import com.help.admin.model.vo.AdminAttendance;
import com.help.admin.model.vo.AdminListMember;

public class AdminService {
	private AdminDao dao = new AdminDao();
	
	
	public List<AdminListMember> memberAll(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<AdminListMember> list = dao.memberAll(conn, cPage, numPerPage);
		close(conn);
		return list;
	}
	
	
	public int MemberAllCount() {
		Connection conn = getConnection();
		int result = dao.MemberAllCount(conn);
		close(conn);
		return result;
		
	}
	
	public List<AdminListMember> waitMemberAll() {
		Connection conn = getConnection();
		List<AdminListMember> list = dao.waitMemberAll(conn);
		close(conn);
		return list;
	}
	
	
	public List<AdminAttendance> adminAttendanceFirst(String day){
		Connection conn = getConnection();
		List<AdminAttendance> list = dao.adminAttendanceFirst(conn, day);
		close(conn);
		return list;
	}

}
