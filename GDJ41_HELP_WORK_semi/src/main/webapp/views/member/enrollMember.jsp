<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.help.gmail.SHA256" %>
<%@ page import="com.help.member.model.dao.MemberDao" %>
<%@ page import="com.help.member.model.vo.Member" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
	<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script type="text/javascript"></script>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
</head>
<body>
	<section id=enroll-container>
		<h2>회원 가입 정보 입력</h2>
     	<form name="enrollMemberFrm" action="<%=request.getContextPath() %>/member/enrollMemberEnd.do" method="post" enctype="multipart/form-data" onsubmit="return checks()" >
    	<%-- <form name="enrollMemberFrm" action="<%=request.getContextPath() %>/views/member/memberEnrollAction.jsp" method="post" enctype="multipart/form-data" onsubmit="return checks()" > --%>
    		<table class="table" style="margin-left: auto; margin-right: auto;">
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" placeholder="이메일형식으로 입력해주세요" name="memberId" id="memberId" >
						<input type="button" value="중복검사" id="idDuplicateBtn">
						<span>이메일 형식으로 입력해주세요 ex)silver@world.com</span>
					</td>
				</tr>
				<tr>
					<th>패스워드</th>
					<td>
						<input type="password" name="memberPwd" id="memberPwd" placeholder="비밀번호를 입력해주세요"><br>
						<span>비밀번호는 영문 대소문자+숫자+특수문자 조합 최소 8자리 이상으로 작성해주세요</span>
					</td>
				</tr>
				<tr>
					<th>패스워드확인</th>
					<td>	
						<input type="password" id="memberPwd_2" placeholder="비밀번호를 다시 한번 입력해주세요"><br>
						<span id="pwresult"></span>
					</td>
				</tr>  
				<tr>
					<th>이름</th>
					<td>	
						<input type="text"  name="memberName" id="memberName" required><br>
					</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td>	
						<input type="tel" placeholder="휴대폰번호를 '-'없이 입력" name="memberPhone" id="memberPhone" maxlength="15" required><br>
					</td>
				</tr>
				<tr>
					<th>프로필사진</th>
					<td>	
						<div id="imageContainer"></div>
						<input type="file" name="memberProfile" id="memberProfile">
					</td>
				</tr>
			</table>
			<input type="submit" value="가입" >
			<input type="reset" value="취소" >
		</form>
		<form name="idDuplicateFrm">
			<input type="hidden" name="memberId">
		</form>
	</section>
	<script>
		//비밀번호 일치 확인
	   	$(()=>{
	   		$("#memberPwd_2").keyup(e=>{
	   			if($(e.target).val().trim().length>3){
	   				if($(e.target).val()==$("#memberPwd").val()){
	   					$("#pwresult").text("비밀번호가 일치합니다.").css({"color":"green"});
	   				}else{
	   					$("#pwresult").text("비밀번호가 불일치합니다.").css({"color":"red"});
	   				}
	   			}
	   		});
	   	});
	   
	   //아이디,비번,전화번호,이름 확인(정규표현식 적용)
	   	const checks=()=>{
	   		const checkId=RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	   		const checkPw=RegExp(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,25}$/);
			const checkPhone=RegExp(/^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/);
			const getName= RegExp(/^[가-힣]+$/);
			
			if(!checkId.test($("#memberId").val())){
	   			alert("이메일 형식으로 작성해주세요");
	   			$("#memberId").val("");
	   			$("#memberId").focus();
	   			return false;
	   		}

			if(!checkPw.test($("#memberPwd").val())){
				alert("비밀번호는 영문 대소문자+숫자+특수문자 조합 최소 8자리 이상으로 작성해주세요");				
	   			$("#memberPwd").val("");
	   			$("#memberPwd").focus();
	   			return false;
			}
			
			if(!checkPhone.test($("#memberPhone").val())){
				alert("전화번호를 정확하게 입력해주세요!");
				$("#memberPhone").val("");
				$("#memberPhone").focus();
				return false;
			}
			
			if (!getName.test($("#memberName").val())) {
		        alert("이름 똑띠 쓰세용");
		        $("#memberName").val("");
		        $("#memberName").focus();
		        return false;
		      }
	   		
	   	}
	   	
	   	//아이디 중복확인하기
	   	$(()=>{
	   		$("#idDuplicateBtn").click(e=>{
	   			const userId=$("#memberId").val().trim();
	   			if(userId.match("@")){
	   				const url="<%=request.getContextPath()%>/member/idDuplicate.do";
	   				const title="idDuplicate";
	   				const style="width=300,height=200";
	   				open("",title,style);
	   				idDuplicateFrm.userId.value=userId;
	   				idDuplicateFrm.action=url;
	   				idDuplicateFrm.method="post";
	   				idDuplicateFrm.target=title;
	   				idDuplicateFrm.submit();
	   				
	   			}else{
	   				alert("이메일 형식으로 작성해주세요");
	   				$("#memberId").focus();
	   			}
	   		});
	   	});
	   	
	   	$("#target").click(e=>{
	   		$("input[name=memberProfile]").click();
	   	});
	   	$("input[name=memberProfile]").change(e=>{
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
	   	});
   
   </script>
</body>
</html>