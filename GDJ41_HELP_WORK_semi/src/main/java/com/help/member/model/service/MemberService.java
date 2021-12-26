package com.help.member.model.service;

import java.sql.Connection;

import com.help.member.model.dao.MemberDao;
import com.help.member.model.vo.Member;
import static com.help.common.JDBCTemplate.close;
import static com.help.common.JDBCTemplate.getConnection;
import static com.help.common.JDBCTemplate.commit;
import static com.help.common.JDBCTemplate.rollback;
public class MemberService {
	
	private MemberDao dao=new MemberDao();
	
	//로그인
//	public Member login(String userId,String password) {
//		Connection conn=getConnection();
//		Member m=dao.login(conn,userId,password);
//		close(conn);
//		return m;
//	}
//	public int login(String userId,String password) {
//		Connection conn=getConnection();
//		int result=dao.login(conn,userId,password);
//		close(conn);
//		return result;
//	}
	
	//id중복확인
	public Member checkIdDuplicate(String userId) {
		Connection conn=getConnection();
		Member m=dao.checkIdDuplicate(conn,userId);
		close(conn);
		return m;
	}
	
	//회원가입
//	public int insertMember(Member m) {
//		Connection conn=getConnection();
//		int result=dao.insertMember(conn,m);
//		if(result>0) commit(conn);
//		else commit(conn);
//		close(conn);
//		return result;
//	}
//	public int insertMember(Member m) {
//		Connection conn=getConnection();
//		int result=dao.insertMember(conn,m);
//		if(result>0) commit(conn);
//		else commit(conn);
//		close(conn);
//		return result;
//	}
//	
//	//이메일 인증여부
//	public boolean getEmailChecked(String userId) {
//		Connection conn=getConnection();
//		boolean flag=dao.getEmailChecked(conn,userId);
//		if(flag=true) commit(conn);
//		else commit(conn);
//		close(conn);
//		return flag;
//	}
//
//	//이메일 인증하기
//	public boolean setEmailChecked(String userId) {
//		Connection conn=getConnection();
//		boolean flag=dao.getEmailChecked(conn,userId);
//		if(flag=true) commit(conn);
//		else commit(conn);
//		close(conn);
//		return flag;
//	}
	
	//회원정보수정
	public int updateMember(Member m) {
		Connection conn=getConnection();
		int result=dao.updateMember(conn,m);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//비밀번호 변경
	public int updatePassword(String userId,String password) {
		Connection conn=getConnection();
		int result=dao.updatePassword(conn,userId,password);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//아이디 찾기
	public String findMemberId(String userName,String phone) {
		Connection conn=getConnection();
		String userId=dao.findMemberId(conn,userName,phone);
		close(conn);
		return userId;
	}

}
