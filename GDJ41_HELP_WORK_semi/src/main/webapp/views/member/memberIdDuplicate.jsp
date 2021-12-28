<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.help.member.model.vo.Member" %>
<%
	Member m=(Member)request.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="checkId-container">
		<%if(m==null){ %>
			[<span><%=request.getParameter("memberId") %></span>]는 사용가능합니다.	
			<br><br>
			<button type="button" id="btn" >닫기</button>
		<%}else {%>
			[<span id="duplicated"><%=m.getMemberId() %></span>]는 사용중입니다.
			<br><br>
			<form action="<%=request.getContextPath() %>/member/idDuplicate.do" 
			method="post" onsubmit="checks">
				<input type="text" name="userId" id="userId">
				<input type="submit" value="중복검사" >
			</form>
		<%} %>	
	</div>
	<script>
		const el=document.querySelector("#btn").addEventListener("click",e=>{
			const memberId='<%=request.getParameter("memberId")%>';
			opener.enrollMemberFrm.memberId.value=userId;
			opener.enrollMemberFrm.memberPwd.focus();
			close();
		});
		
		const checks=()=>{
			const checkId=RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
			if(!checkId.test($("#memberId").val())){
	   			alert("이메일 형식으로 작성해주세요");
	   			$("#memberId").val("");
	   			$("#memberId").focus();
	   			return false;
	   		}
		}
	</script>

</body>
</html>