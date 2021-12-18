<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section id=enroll-container>
		<h2>회원 가입 정보 입력</h2>
    	<form name="enrollMemberFrm" action="<%=request.getContextPath() %>/member/enrollMemberEnd.do" method="post" onsubmit="return memberEnrollValidate();" >
    		<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" placeholder="이메일형식으로 적어주세요" name="userId" id="userId_" >
						<input type="button" value="중복검사" id="idDuplicateBtn">
					</td>
					</tr>
					<tr>
					<th>패스워드</th>
					<td>
						<input type="password" name="password" id="password_" ><br>
					</td>
				</tr>
				<tr>
					<th>패스워드확인</th>
					<td>	
						<input type="password" id="password_2" ><br>
						<span id="pwresult"></span>
					</td>
				</tr>  
				<tr>
					<th>이름</th>
					<td>	
						<input type="text"  name="userName" id="userName" ><br>
					</td>
				</tr>
				<tr>
					<th>나이</th>
					<td>	
						<input type="number" name="age" id="age"><br>
					</td>
				</tr> 
				<tr>
					<th>프로필사진</th>
					<td>	
						<input type="email" placeholder="abc@xyz.com" name="email" id="email"><br>
					</td>
				</tr>
			</table>
			<input type="submit" value="가입" >
			<input type="reset" value="취소" >
		</form>
		<form name="idDuplicateFrm">
			<input type="hidden" name="userId">
		</form>
	</section>
	<script>
	   	$(()=>{
	   		$("#password_2").keyup(e=>{
	   			if($(e.target).val().trim().length>3){
	   				if($(e.target).val()==$("#password_").val()){
	   					$("#pwresult").text("비밀번호가 일치합니다.").css({"color":"green"});
	   				}else{
	   					$("#pwresult").text("비밀번호가 불일치합니다.").css({"color":"red"});
	   				}
	   			}
	   		});
	   	});
	   
	   
	   	const memberEnrollValidate=()=>{
	   		//1. userId입력값이 4자리이상인지 확인
	   		//2. password가 4글자 이상인지 확인
	   		const userId=$("#userId_").val().trim();//공백을 빼고 처리
	   		if(!userId.match("@")){
	   			alert("이메일 형식으로 작성해주세요");
	   			$("#userId_").focus();
	   			return false;
	   		}
	   		const password=$("#password_").val().trim();
	   		if(password.length<8){
	   			alert("패스워드는 8글자 이상 입력하세요!");
	   			$("#password_").focus();
	   			return false;
	   		}
	   		
	   	}
	   	
	   	//아이디 중복확인하기
	   	$(()=>{
	   		$("#idDuplicateBtn").click(e=>{
	   			const userId=$("#userId_").val().trim();
	   			if(userId.match("@")){
	   				const url="<%=request.getContextPath()%>/member/idDuplicate.do";
	   				const title="idDuplicate";
	   				const style="width=300,height=200";
	   				open("",title,style);
	   				console.log(idDuplicateFrm);
	   				console.log(idDuplicateFrm.userId);
	   				idDuplicateFrm.userId.value=userId;
	   				idDuplicateFrm.action=url;
	   				idDuplicateFrm.method="post";
	   				idDuplicateFrm.target=title;
	   				idDuplicateFrm.submit();
	   				
	   			}else{
	   				alert("이메일 형식으로 작성해주세요");
	   				$("#userId_").focus();
	   			}
	   		});
	   	});
   
   </script>
</body>
</html>