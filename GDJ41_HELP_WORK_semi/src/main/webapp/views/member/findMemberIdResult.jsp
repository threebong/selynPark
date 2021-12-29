<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId=(String)request.getAttribute("findMemberId");
	System.out.println(memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js">
</script>
<script>
$(()=>{
		$("#idMasking").onLoad(e=>{
			const memberId=<%=memberId%>
			const id=userId.split("@")[0].replace(/(?<=.{1})./gi,"*");
			const mail=memberId.split("@")[1].replace(/(?=.{4})./gi,"*");
			memberId=id+"@"+mail;
		});
	});	
</script>
</head>
<body onload="idMasking();">
	<form name="idsearch" method="post" onLoad="idMasking();">
      <%
       if (memberId != null) {
      %>
      
		<div class = "container">
      		<div class = "found-success">
	      		<h4>  회원님의 아이디는 </h4>  
	      		<div class ="found-id">
		      		<span id="maskingId"><%=memberId %></span>
	      		</div>
	      		<h4>  입니다 </h4>
	     	</div>
	    	<div class = "found-login">
 		    	<input type="button" id="btnLogin" value="로그인" onClick = "login();"/>
       		</div>
       	</div>
      <%
	  } else {
	  %>
        <div class = "container">
      		<div class = "found-fail">
	      		<h4>  등록된 정보가 없습니다 </h4>  
	     	</div>
	    	<div class = "found-login">
 		    	<input type="button" id="btnback" value="다시 찾기" onClick="history.back();"/>
 		    	<input type="button" id="btnjoin" value="회원가입" onClick="enrollMember();"/>
       		</div>
       	</div>
      <%
  	  }
	  %> 
	</form>
</body>
<script>

	const login=()=>{
		const url="<%=request.getContextPath()%>";
		location.assign(url);
	}
	const enrollMember=()=>{
		const url="<%=request.getContextPath()%>/member/enrollMember.do"
		location.assign(url);
	}



</script>
</html>