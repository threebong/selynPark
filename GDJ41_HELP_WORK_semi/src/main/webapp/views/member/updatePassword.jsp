<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
	<style>
    div#updatePassword-container{
        background:cornflowerblue;
    }
    div#updatePassword-container table {
        margin:0 auto;
        border-spacing: 20px;
    }
    div#updatePassword-container table tr:last-of-type td {
        text-align:center;
    }
    </style>
</head>
<body>
    <div id="updatePassword-container">
		<form name="updatePwdFrm" action="<%=request.getContextPath()%>/member/updatePasswordEnd.do" method="post" onsubmit="return passwordValidate()" >
			<table>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="password" id="password" required></td>
				</tr>
				<tr>
					<th>변경할 비밀번호</th>
					<td>
						<input type="password" name="password_new" id="password_new" required>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>	
						<input type="password" id="password_chk" required><br>
						<span id="pwresult"></span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="변경" />&nbsp;
						<input type="button" value="닫기" onclick="window.close();"/>						
					</td>
				</tr>
			</table>
			<input type="hidden" name="userId" value="<%=request.getParameter("userId") %>"/>
		</form>
	</div>
	<script>
		//비밀번호 글자수확인
		const passwordValidate=()=>{
	   		const password=$("#password_new").val().trim();
	   		if(password.length<8){
	   			alert("비밀번호는 8글자 이상 입력하세요!");
	   			$("#password_new").focus();
	   			return false;
	   		}
	   		
	   	}
		
		//비밀번호 일치 확인
	   	$(()=>{
	   		$("#password_chk").keyup(e=>{
	   			if($(e.target).val().trim().length>3){
	   				if($(e.target).val()==$("#password_new").val()){
	   					$("#pwresult").text("비밀번호가 일치합니다.").css({"color":"green"});
	   				}else{
	   					$("#pwresult").text("비밀번호가 불일치합니다.").css({"color":"red"});
	   				}
	   			}
	   		});
	   	});
	
	</script>
</body>
</html>