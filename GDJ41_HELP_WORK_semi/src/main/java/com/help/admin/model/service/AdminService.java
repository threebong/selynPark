package com.help.admin.model.service;

import java.sql.Connection;
import java.util.List;

import com.help.admin.model.dao.AdminDao;
import com.help.admin.model.vo.AdminListMember;
import static com.help.common.JDBCTemplate.getConnection;
import static com.help.common.JDBCTemplate.close;

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

}
