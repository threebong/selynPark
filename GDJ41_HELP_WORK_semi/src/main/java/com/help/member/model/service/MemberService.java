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
	public Member login(String memberId,String memberPwd) {
		Connection conn=getConnection();
		Member m=dao.login(conn,memberId,memberPwd);
		close(conn);
		return m;
	}
//	public int login(String memberId,String memberPwd) {
//		Connection conn=getConnection();
//		int result=dao.login(conn,userId,memberPwd);
//		close(conn);
//		return result;
//	}
	
	//id중복확인
	public Member checkIdDuplicate(String memberId) {
		Connection conn=getConnection();
		Member m=dao.checkIdDuplicate(conn,memberId);
		close(conn);
		return m;
	}
	
	//회원가입
	public int insertMember(Member m) {
		Connection conn=getConnection();
		int result=dao.insertMember(conn,m);
		if(result>0) commit(conn);
		else commit(conn);
		close(conn);
		return result;
	}
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
//	public boolean getEmailChecked(String memberId) {
//		Connection conn=getConnection();
//		boolean flag=dao.getEmailChecked(conn,memberId);
//		if(flag=true) commit(conn);
//		else commit(conn);
//		close(conn);
//		return flag;
//	}
//
//	//이메일 인증하기
//	public boolean setEmailChecked(String memberId) {
//		Connection conn=getConnection();
//		boolean flag=dao.getEmailChecked(conn,memberId);
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
	public int updatePassword(String memberId,String memberPwd) {
		Connection conn=getConnection();
		int result=dao.updatePassword(conn,memberId,memberPwd);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	//아이디 찾기
	public String findMemberId(String memberName,String memberPhone) {
		Connection conn=getConnection();
		String memberId=dao.findMemberId(conn,memberName,memberPhone);
		close(conn);
		return memberId;
	}

}
