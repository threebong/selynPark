package com.help.member.model.service;

import java.sql.Connection;

import com.help.member.model.dao.MemberDao;
import com.help.member.model.vo.Member;
import static com.help.common.JDBCTemplate.close;
import static com.help.common.JDBCTemplate.getConnection;
public class MemberService {
	
	private MemberDao dao=new MemberDao();
	
	public Member login(String userId,String password) {
		Connection conn=getConnection();
		Member m=dao.login(conn,userId,password);
		close(conn);
		return m;
	}

}
