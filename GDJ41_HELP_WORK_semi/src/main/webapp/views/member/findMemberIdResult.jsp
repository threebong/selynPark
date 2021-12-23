<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userId=(String)request.getAttribute("findMemberId");
	System.out.println(userId);
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
			const userId=<%=userId%>
			const id=userId.split("@")[0].replace(/(?<=.{1})./gi,"*");
			const mail=userId.split("@")[1].replace(/(?=.{4})./gi,"*");
			userId=id+"@"+mail;
		});
	});	
</script>
</head>
<body onload="idMasking();">
	<form name="idsearch" method="post" onLoad="idMasking();">
      <%
       if (userId != null) {
      %>
      
		<div class = "container">
      		<div class = "found-success">
	      		<h4>  회원님의 아이디는 </h4>  
	      		<div class ="found-id">
		      		<span id="maskingId"><%=userId %></span>
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
	
	<%-- const idMasking=(<%=userId%>)=>{
		const userId=<%=userId%>
		const id=userId.split("@")[0].replace(/(?<=.{1})./gi,"*");
		const mail=userId.split("@")[1].replace(/(?=.{4})./gi,"*");
		userId=id+"@"+mail;
		$("#idMasking").text(userId).css({"color":"black"}); --%>
		
		
	}



</script>
</html>