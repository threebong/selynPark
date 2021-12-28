<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member m=(Member)request.getAttribute("member");
%>
<%@ include file="/views/common/header.jsp" %>
<style>
.btn-outline-secondary:hover{
   background-color: #6710f242;
   border: 1px solid #6710f242;
}
.btn-outline-secondary{
   border: 1px solid #6710f242;
   color:#6710f242;
}
.updateMemberSection{
	width:500px;	
	position:absolute;
	left:0;
	right:0;
	top:20px;
	bottom:0;
	margin:auto;
}
.updatememberSection>h2{
	text-align:center;
}
.profileImg{
	align
}
.fas{
	font-size:500px;
}

</style>
	<section id=enroll-container class=updateMemberSection>
		<h2>회원 정보 수정</h2>
    	<form name="updateMemberFrm" action="<%=request.getContextPath() %>/member/updateMember.do" method="post" enctype="multipart/form-data"  >
    		<table class="updateTbl">
				<tr> 
					<td>
						<%if(m.getMemberProfile()!=null){ %>
							<div class="profileImg">
								<img src="<%=request.getContextPath() %>/upfile/member/<%=m.getMemberProfile() %>" width=250px height=250px>
							</div>
						<%}else{ %>
							<div class="profileImg">
								<img src="<%=request.getContextPath() %>/upfile/member/noImage2.png" width=250px height=250px>
							</div>
							<!-- <span>업로드한 프로필사진이 없습니다.</span> -->
						<%} %>
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" name="oriProfile" value="<%=m.getMemberProfile() %>">
					</td>
				</tr>
				<tr>
					<td>
						<span>현재 프로필사진</span>
					</td>
				</tr>		
				<tr>
					<th>아이디</th>
					<td>
						<div class="mb-3">
							<input class="form-control" type="text" value="<%=m.getMemberId() %>" id="memberId" name="memberId" aria-label="readonly input example" readonly>
						</div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>	
						<%-- <input type="text"  name="memberName" id="memberName" required value="<%=m.getMemberName() %>" ><br> --%>
						<div class="mb-3">
						  <input type="text" class="form-control" id="exampleFormControlInput1" name="memberName" required value="<%=m.getMemberName() %>">
						</div>
					</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td>	
						<div class="mb-3">
						  <input type="text" class="form-control" id="exampleFormControlInput1" name="memberPhone" required value="<%=m.getMemberPhone() %>">
						</div>
					</td>
				</tr>
				<tr>
					<th>프로필사진</th>
					<td>	
						<div id="imageContainer"></div>
						<div class="mb-3">
	  						<input class="form-control" type="file" id="formFile" name="memberProfile" >
						</div>
					</td>
				</tr>	
			</table>
<!-- 			<input type="submit" value="회원정보수정" >
			<input type="button" value="비밀번호 변경" id="pwChangeBtn" onclick="updatePassword();"> -->
			<button type="submit" value="로그인" class="btn btn-outline-secondary">회원정보수정</button>
			<button value="로그인" class="btn btn-outline-secondary" id="pwChangeBtn" onclick="updatePassword();">비밀번호 변경</button>
		</form>
	</section>
	<script>
		//이미지 미리보기
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
	   	})
	   	
		//회원정보수정
		const updateMember=()=>{
			const url="<%=request.getContextPath()%>/member/updateMember.do";
			$("form[name=updateMemberFrm]").attr("action",url);
			$("form[name=updateMemberFrm]").submit();	
		}
		
		//비밀번호 변경
		const updatePassword=()=>{
			const url="<%=request.getContextPath()%>/member/updatePassword.do?memberId=<%=m.getMemberId()%>";
			const style="width=400,height=210,top=200,left=500";
			open(url,"_blank",style);
		}
	</script>

<%@ include file="/views/common/footer.jsp"%>