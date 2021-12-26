<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.help.member.model.dao.MemberDao"%>
<%@ page import="com.help.gmail.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
   request.setCharacterEncoding("UTF-8");
   String code = null;
   if(request.getParameter("code") != null) {
	   code = request.getParameter("code");
   }
   MemberDao dao = new MemberDao();
   String userId = null;
   if(session.getAttribute("userId") != null) {
	   userId = (String) session.getAttribute("userId");
   }
   if(userId == null) {
	   PrintWriter script = response.getWriter();
	   script.println("<script>");
	   script.println("alert('로그인을 해주세요.');");
	   script.println("location.href = 'index.jsp'");
	   script.println("</script>");
	   script.close();
	   return;
   } 
   
   String userEmail = dao.getMemberEmail(userId);
   boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
   if(isRight == true) {
	   dao.setEmailChecked(userId);
	   PrintWriter script = response.getWriter();
	   script.println("<script>");
	   script.println("alert('인증에 성공했습니다.');");
	   script.println("location.href = '/views/project/myProjectView.jsp'");
	   script.println("</script>");
	   script.close();
	   return;
   } else {
	   PrintWriter script = response.getWriter();
	   script.println("<script>");
	   script.println("alert('유효하지 않은 코드입니다.');");
	   script.println("location.href = 'index.jsp'");
	   script.println("</script>");
	   script.close();
	   return;
   }
 
 %> --%>