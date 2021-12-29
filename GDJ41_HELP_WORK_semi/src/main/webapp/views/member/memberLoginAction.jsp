<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.help.member.model.vo.Member"%>
<%@ page import="com.help.member.model.dao.MemberDao"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    String memberId = null;
    String memberPwd = null;
    if(request.getParameter("memberId") !=null) {
    	memberId = request.getParameter("memberId");
    }
    if(request.getParameter("memberPwd") != null) {
    	memberPwd = (String) request.getParameter("memberPwd");
	}
    if(memberId == null ||memberPwd ==null) {
    	PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
    }else if(memberId=="admin"&&memberPwd=="admin"){
    	PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자님의 입장을 환영합니다. ^_^');");
		script.println("location.href='views/project/myProjectView.jsp'");
		script.println("</script>");
		script.close();
		return;
    }
    MemberDao dao = new MemberDao();
	int result = dao.login(memberId, memberPwd);
	if (result == 1) {
		session.setAttribute("memberId", memberId);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='/views/project/myProjectView.jsp'");
		script.println("</script>");
		script.close();
		return;

	} else if (result == 0) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		
	} else if (result == -1) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
	    script.println("alert('존재하지 않는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;

	} else if (result == -2) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}

%>  --%>