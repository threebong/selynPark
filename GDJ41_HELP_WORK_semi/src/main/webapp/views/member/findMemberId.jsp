<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<form name="findIdFrm" method = "post" action="<%=request.getContextPath()%>/member/findMemberIdEnd.do" onsubmit="return idValidate();">
			<div class = "searchNamePhone">
				<h3>휴대폰 본인확인</h3>
			</div>
		<section class = "form-search">
			<div class = "find-name">
				<label>이름</label>
				<input type="text" name="userName" class = "userName" placeholder = "등록한 이름">
			<br>
			</div>
			<div class = "find-phone">
				<label>번호</label>
				<input type="tel" name="phone" class = "phone" placeholder = "휴대폰번호를 '-'없이 입력">
			</div>
			<br>
		</section>
		<div class ="btn-search">
			<input type="submit" value="찾기">
			<input type="button" value="취소" onClick="history.back()">
	 	</div>
	</form>
 <script>
 	const idValidate=()=>{
 		const userName=$("#userName").val().trim();
 		const phone=$("#phone").val().trim();
 		if(userName.length<1){
 			alert("이름을 입력해주세요");
 			$("#userName").focus();
 			return false;
 		}else(phone.length!=11){
 			alert("핸드폰번호를 정확하게 입력해주세요");
 			$("#phone").focus();
 			return false;
 		}
 	}
 </script>

</body>
</html>