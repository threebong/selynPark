<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member m=(Member)request.getAttribute("member");
%>
<%@ include file="/views/common/header.jsp" %>

	<section id=enroll-container>
		<h2>회원 정보 수정</h2>
    	<form name="updateMemberFrm" action="<%=request.getContextPath() %>/member/updateMember.do" method="post" enctype="multipart/form-data"  >
    		<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="userId" id="userId_" value="<%=m.getMemberId() %>" readonly >
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>	
						<input type="text"  name="userName" id="userName" required value="<%=m.getMemberName() %>" ><br>
					</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td>	
						<input type="tel" name="phone" id="phone" required value="<%=m.getMemberPhone()%>"><br>
					</td>
				</tr>
				<tr>
					<th>프로필사진</th>
					<td>	
						<div id="imageContainer"></div>
						<input type="file" name="upProfile" id="upProfile">
					</td>
				<tr>
					<td>
						<%if(m.getMemberProfile()!=null){ %>
						<img src="<%=request.getContextPath() %>/upfile/member/<%=m.getMemberProfile() %>" width=100px height=100px>
						<%}else{ %>
						<span>업로드한 프로필사진이 없습니다.</span>
						<%} %>
						<span>현재 프로필사진</span>
					</td>
				</tr>
					<td>
						<input type="hidden" name="oriProfile" value="<%=m.getMemberProfile() %>">
					</td>
				</tr>
			</table>
			<input type="submit" value="회원정보수정" >
			<input type="button" value="비밀번호 변경" id="pwChangeBtn" onclick="updatePassword();">
			<input type="button" value="탈퇴" >
		</form>
	</section>
	<script>
		//이미지 미리보기
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
	   	
		//회원정보수정
		const updateMember=()=>{
			const url="<%=request.getContextPath()%>/member/updateMember.do";
			$("form[name=updateMemberFrm]").attr("action",url);
			$("form[name=updateMemberFrm]").submit();	
		}
		
		//비밀번호 변경
		const updatePassword=()=>{
			const url="<%=request.getContextPath()%>/member/updatePassword.do?userId=<%=m.getMemberId()%>";
			const style="width=400,height=210,top=200,left=500";
			open(url,"_blank",style);
		}
		
		//회원탈퇴하기
		const memberDelete=()=>{
			const url="<%=request.getContextPath()%>/member/memberDelete.do";
			$("memberFrm").attr("action",url);
		}
	</script>

<%@ include file="/views/common/footer.jsp"%>