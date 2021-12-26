<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.help.member.model.vo.Member"%>
<%@ page import="com.help.member.model.dao.MemberDao"%>
<%@ page import="com.help.gmail.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%

	request.setCharacterEncoding("UTF-8");

	String userId = null;
	String password = null;
	String phone = null;
	String upProfile = null;
	String userName = null;	

	if (request.getParameter("userId") != null) {
		userId = request.getParameter("userId");
	}
	if (request.getParameter("password") != null) {
		password = request.getParameter("password");
	}
	if (request.getParameter("phone") != null) {
		phone = request.getParameter("phone");
	}
	/* if (request.getParameter("upProfile") != null) {
		upProfile = request.getParameter("upProfile");
	} */
	if (request.getParameter("userName") != null) {
		userName = request.getParameter("userName");
	}
/* 	if (userId == null || password == null || phone == null || upProfile == null || userName == null) {
 */	if (userId == null || password == null || phone == null || userName == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	MemberDao dao = new MemberDao();
	int result = dao.insertMember(new Member(userId,null,null,password,phone,upProfile,userName,null,SHA256.getSHA256(userId), false));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userId", userId);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = '/views/member/emailSendAction.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>