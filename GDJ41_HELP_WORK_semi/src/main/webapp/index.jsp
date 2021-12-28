<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.help.member.model.vo.*" %>
<%
	Member loginMember=(Member)session.getAttribute("loginMember");
	String saveId=null;
	Cookie[] cookies=request.getCookies();
	if(cookies!=null){
		for(Cookie c : cookies){
			if(c.getName().equals("saveId")) {
				saveId=c.getValue();	
				break;
			}
		}
	}
%>
<head>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script type="text/javascript"></script>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<style>
	* {
	  margin: 0;
	  padding: 0;
	  box-sizing: border-box;
	  font-family: 'Do Hyeon', sans-serif;
	}
	/* a {
	  text-decoration: none;
	  color: black;
	}
	li {
	  list-style: none;
	} */
	.wrap {
	  width: 100%;
	  height: 100vh;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  background: rgba(0, 0, 0, 0.1);
	}
	.login {
	  width: 30%;
	  height: 600px;
	  background: white;
	  border-radius: 20px;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  flex-direction: column;
	}
	
	h2 {
	  color: #6710f242;
	  font-size: 2em;
	}	
	/* .login_id {
	  margin-top: 20px;
	  width: 80%;
	}
	
	.login_id input {
	  width: 100%;
	  height: 50px;
	  border-radius: 30px;
	  margin-top: 10px;
	  padding: 0px 20px;
	  border: 1px solid lightgray;
	  outline: none;
	}
	
	.login_pw {
	  margin-top: 20px;
	  width: 80%;
	}
	
	.login_pw input {
	  width: 100%;
	  height: 50px;
	  border-radius: 30px;
	  margin-top: 10px;
	  padding: 0px 20px;
	  border: 1px solid lightgray;
	  outline: none;
	}
	
	.login_etc {
	  padding: 10px;
	  width: 80%;
	  font-size: 14px;
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  font-weight: bold;
	} */
	.form-floating,.checkbox{
		color:purple;
	}
	.submit {
	  margin-top: 25px;
	  width: 80%;
	}
	.enrollMember {
	  margin-top: 10px;
	  width: 80%;
	}
	.enrollMember input{
	  width: 100%;
	  height: 50px;
	  border: 0;
	  outline: none;
	  border-radius: 40px;
	}
	.submit button{
	  width: 100%;
	  height: 50px;
	  border: 0;
	  outline: none;
	  border-radius: 40px;
	}
.btn-outline-secondary:hover{
   background-color: #6710f242;
   border: 1px solid #6710f242;
}
.btn-outline-secondary{
   border: 1px solid #6710f242;
   color:#6710f242;
}
	</style>
</head>
<main>
	<%-- <form class="wrap" action="<%=request.getContextPath()%>/views/member/memberLoginAction.jsp" method="post"> --%>
	<form class="wrap" action="<%=request.getContextPath()%>/member/memberLogin.do" method="post">
        <div class="login">
            <h2>HELP-WORK</h2>
            <h2>LOGIN</h2><br>
            <div class="form-floating mb-3">
	            <!-- <label for="exampleInputEmail1" class="form-label">아이디</label> -->
			  	<input type="text" class="form-control" id="floatingInput" name="memberId" placeholder="name@example.com" value="<%=saveId!=null?saveId:""%>">
			  	<label for="floatingInput">email로 입력하세요</label>
			</div>
            <div class="login_etc">
                <div class="checkbox">
                	<input type="checkbox" name="saveId" id="saveId" <%=saveId!=null?"checked":""%>>
                	<label for="saveId">아이디저장</label>
                </div>
            </div>
			<div class="form-floating">
			  <input type="password" class="form-control" id="floatingPassword" name="memberPwd" placeholder="Password">
			  <label for="floatingPassword">패스워드를 입력하세요</label>
			</div>
			<br>
            <div class="login_etc">
                <div class="forgot_email">
	 		        <input type="button" class="btn btn-outline-secondary" value="아이디 찾기" onclick="location.assign('<%=request.getContextPath()%>/member/findMemberId.do')">
	 		        <input type="button" class="btn btn-outline-secondary" value="패스워드 찾기" onclick="location.assign('<%=request.getContextPath()%>/member/findMemberPwd.do')">
            	</div> 
            </div>
            <div class="submit btn-outline-secondary">
            	
                <button type="submit" value="로그인" class="btn btn-outline-secondary">로그인</button>
            
            </div>
	        <div class="enrollMember btn-outline-secondary">
 		        <input type="button" class="btn btn-outline-secondary" value="회원가입" onclick="location.assign('<%=request.getContextPath()%>/member/enrollMember.do')">
		        <%-- <input type="button" value="회원가입" onclick="location.assign('<%=request.getContextPath()%>/views/member/enrollMember.jsp')"> --%>
		        
	        </div>
        </div>
    </form>
</main>
