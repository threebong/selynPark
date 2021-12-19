<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<section id=enroll-container>
		<h2>회원 가입 정보 입력</h2>
    	<form name="enrollMemberFrm" action="<%=request.getContextPath() %>/member/enrollMemberEnd.do" method="post" enctype="multipart/form-data" onsubmit="return memberEnrollValidate();" >
    		<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" placeholder="이메일형식으로 입력해주세요" name="userId" id="userId_" >
						<input type="button" value="중복검사" id="idDuplicateBtn"><br>
						<span>이메일 형식으로 입력해주세요 ex)silver@world.com</span>
					</td>
				</tr>
				<tr>
					<th>패스워드</th>
					<td>
						<input type="password" name="password" id="password_" placeholder="비밀번호를 입력해주세요"><br>
						<span>비밀번호는 영문 대소문자+숫자+특수문자 조합 최소 8자리 이상으로 작성해주세요</span>
					</td>
				</tr>
				<tr>
					<th>패스워드확인</th>
					<td>	
						<input type="password" id="password_2" placeholder="비밀번호를 다시 한번 입력해주세요"><br>
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
					<th>휴대폰</th>
					<td>	
						<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="15" required><br>
					</td>
				</tr>
				<tr>
					<th>프로필사진</th>
					<td>	
						<div id="imageContainer"></div>
						<input type="file" name="upProfile" id="upProfile"><!-- <button id="upload">프로필사진 업로드</button> -->
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
	   
	   //아이디,비번 확인
	   	const memberEnrollValidate=()=>{
	   		const userId=$("#userId_").val().trim();
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
	   	
	   	//이미지미리보기
	   	
	   	$("#target").click(e=>{
	   		$("input[name=upProfile]").click();
	   	});
	   	$("input[name=upProfile]").change(e=>{
	   		if(e.target.files[0].type.includes("image")){
	   			let reader=new FileReader();
	   			reader.onload=(e)=>{
	   				const img=$("<img>").attr({
	   					src:e.target.result,
	   					width:"100px",
	   					height:"100px"
	   				});
	   				$("#imageContainer").append(img);
	   				$("#target").attr("src",e.target.result);
	   			}
	   			reader.readAsDataURL(e.target.files[0]);
	   		}
	   	})
	   	//이미지 업로드
	   	<%-- $("#upload").click(e=>{
			const frm=new FormData();
			const fileInput=$("input[name=upProfile]");
			frm.append("upfile",fileInput[0].files[0]);
			$.ajax({
				url:"<%=request.getContextPath()%>/member/profileUpload.do",
				type:"post",
				data:frm,
				processData:false,
				contentType:false,
				success:data=>{
					alert("파일업로드 성공");
					$("input[name=upProfile]").val("");
				}
			});
		}); --%>
   
   </script>
</body>
</html>