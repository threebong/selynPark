<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
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
</style>	
</head>
<body>
	<form name="findIdFrm" method = "post" action="<%=request.getContextPath()%>/member/findMemberIdEnd.do" onsubmit="return checks();">
			<div class = "searchNamePhone">
				<br>
				<h3>휴대폰 본인확인</h3>
				<br>
			</div>
		<section class = "form-search">
			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="memberName" name="memberName" placeholder="은세계">
				<label for="floatingInput">이름 입력</label>
				<br> 
			</div>
			<div class="form-floating mb-3">
				<input type="tel" class="form-control" id="memberPhone" name="memberPhone" placeholder="휴대폰번호를 '-'없이 입력">
				<label for="floatingInput">휴대폰번호를 '-'없이 입력</label>
			</div>
			<br>
		</section>
		<div class ="btn-search">
			<button type="submit" class="btn btn-outline-secondary" value="찾기">찾기</button>
			<input type="button" class="btn btn-outline-secondary" value="취소" onClick="window.close()">
	 	</div>
	</form>
 <script>
 const checks=()=>{
		const checkPhone=RegExp(/^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/);
		const getName= RegExp(/^[가-힣]+$/);
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
 </script>

</body>
</html>