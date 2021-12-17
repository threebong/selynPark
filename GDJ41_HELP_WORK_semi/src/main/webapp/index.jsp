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
<style>
	* {
	  margin: 0;
	  padding: 0;
	  box-sizing: border-box;
	  font-family: "Noto Sans KR", sans-serif;
	}
	a {
	  text-decoration: none;
	  color: black;
	}
	li {
	  list-style: none;
	}
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
	  color: tomato;
	  font-size: 2em;
	}	
	.login_id {
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
	}
	
	.submit {
	  margin-top: 50px;
	  width: 80%;
	}
	.submit input {
	  width: 100%;
	  height: 50px;
	  border: 0;
	  outline: none;
	  border-radius: 40px;
	  background: linear-gradient(to left, rgb(255, 77, 46), rgb(255, 155, 47));
	  color: white;
	  font-size: 1.2em;
	  letter-spacing: 2px;
	}

</style>
<main>
	<form class="wrap" action="<%=request.getContextPath()%>/memberLogin.do" method="post">
        <div class="login">
            <h2>Log-in</h2>
            <div class="login_id" id="login-div">
                <h4>아이디</h4>
                <input type="text" name="userId" id="userId" placeholder="id를 email형식으로 입력하세요">
            </div>
            <div class="login_etc">
                <div class="checkbox">
                	<input type="checkbox" name="saveId" id="saveId"> 아이디 저장
                </div>
            </div>
            <div class="login_pw">
                <h4>비밀번호</h4>
                <input type="password" name="password" id="password" placeholder="패스워드를 입력하세요">
            </div>
            <div class="login_etc">
                <div class="forgot_email">
                	<a href="">아이디를 잊으셨나요?</a>
            	</div>
                <div class="forgot_pw">
                	<a href="">패스워드를 잊으셨나요?</a>
            	</div>
            </div>
            <div class="submit">
                <input type="submit" value="로그인">
            </div>
        </div>
        <%-- <input type="button" value="회원가입" onclick="location.assign('<%=request.getContextPath()%>/memberEnroll.do')" --%>
    </form>
</main>
