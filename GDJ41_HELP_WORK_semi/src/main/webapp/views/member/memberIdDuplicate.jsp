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
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script type="text/javascript"></script>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<title>아이디 중복확인</title>
<style>
	*{
		font-family: 'Do Hyeon', sans-serif;
	  	color:#6710f242
	}
	.btn-outline-secondary:hover{
	   background-color: #6710f242;
	   border: 1px solid #6710f242;
	}
	.btn-outline-secondary{
	   border: 1px solid #6710f242;
	   color:#6710f242;
	}
	span{
		text-align:center;
	}
</style>
</head>
<body>
	<div id="checkId-container">
		<%if(m==null){ %>
			[<span><%=request.getParameter("memberId") %></span>]는 사용가능합니다.	
			<br><br>
			<button type="button" id="btn" class="btn btn-outline-secondary" >닫기</button>
		<%}else {%>
			[<span id="duplicated"><%=m.getMemberId() %></span>]는 사용중입니다.
			<br><br>
			<form action="<%=request.getContextPath() %>/member/idDuplicate.do" 
			method="post" onsubmit="checks">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" id="memberId" name="memberId" placeholder="name@example.com">
					<label for="floatingInput">아이디 입력</label>
					<span>이메일 형식으로 입력해주세요 ex)silver@world.com</span>
				</div>
				<input type="submit" class="btn btn-outline-secondary" value="중복검사" >
			</form>
		<%} %>	
	</div>
	<script>
		const el=document.querySelector("#btn").addEventListener("click",e=>{
			const memberId='<%=request.getParameter("memberId")%>';
			opener.enrollMemberFrm.memberId.value=memberId;
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