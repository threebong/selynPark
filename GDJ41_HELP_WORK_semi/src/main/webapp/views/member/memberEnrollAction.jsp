<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.help.member.model.vo.Member"%>
<%@ page import="com.help.member.model.dao.MemberDao"%>
<%@ page import="com.help.gmail.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%

	request.setCharacterEncoding("UTF-8");

	String memberId = null;
	String memberPwd = null;
	String memberPhone = null;
	String memberProfile = null;
	String memberName = null;	

	if (request.getParameter("memberId") != null) {
		memberId = request.getParameter("memberId");
	}
	if (request.getParameter("memberPwd") != null) {
		memberPwd = request.getParameter("memberPwd");
	}
	if (request.getParameter("memberPhone") != null) {
		memberPhone = request.getParameter("memberPhone");
	}
	/* if (request.getParameter("memberProfile") != null) {
		upProfile = request.getParameter("memberProfile");
	} */
	if (request.getParameter("memberName") != null) {
		memberName = request.getParameter("memberName");
	}
/* 	if (memberId == null || memberPwd == null || memberPhone == null || memberProfile == null || memberName == null) {
 */	if (memberId == null || memberPwd == null || memberPhone == null || memberName == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	MemberDao dao = new MemberDao();
	int result = dao.insertMember(new Member(memberId,null,null,memberPwd,memberPhone,memberProfile,memberName,null,SHA256.getSHA256(memberId), false));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("memberId", memberId);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = '/views/member/emailSendAction.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%> --%>