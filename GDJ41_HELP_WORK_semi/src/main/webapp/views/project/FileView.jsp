<%@page import="com.help.project.model.vo.ProjectAddMember"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.help.project.model.vo.ProMemberJoinMember"%>
<%@page import="java.util.List"%>
<%@page import="com.help.project.model.vo.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<!-- projectDetailView의 css가져옴 -->
<link rel ="stylesheet" href="<%=request.getContextPath()%>/css/projectDetailView.css" type="text/css">
<%//project -> '파일' 눌렀을때 뜨는 상세 화면입니다. 
   Project p = (Project)request.getAttribute("projectInfo");
   List<ProMemberJoinMember> pMember = (List)request.getAttribute("ProMemberJoinMember");
   
%>
<style>
#input-group{
	display:flex;
	justify-content:center;
	align-items:center;
}
</style>

<main>

<div id="title-container">
   <div id="pro-bookmark-star"><i class="fas fa-star"></i></div>
   <div id="project-title"><span><%=p.getProName() %></span></div>
   <div style="float:right;">
   <%if(loginMember.getMemberId().equals(p.getMemberId())){ %> <!-- 현재 로그인된 멤버와, 프로젝트 생성자 아이디가 같으면 초대 버튼 활성화 -->
   <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#addProjectMemberModal" id="add_btn">사원 추가</button>
   <%} %>
   </div>
</div>


<div id="menu-container">
   <ul class="nav">
      <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">홈</a></li>
      <li class="nav-item"><a class="nav-link" href="#">업무</a></li>
      <li class="nav-item"><a class="nav-link" href="#">파일</a></li>
   </ul>
</div>


   <hr style="margin-top: 5px;">
<div id="pro_container">
   <div id="inner_pro_container">
   
	   <div id="inputContent_container">
	      <div id="input-group">
	         <div id=""><span><i class="fas fa-file-archive"></i>&nbsp;파일</span></div>
	      </div>
	   </div>
	   
<!-- 	   파일 검색  -->
	   <div class="input-group mb-3"  style="width: 400px;">
            <div>
               <select class="form-select" aria-label="Default select example" style="width: 140px;" id="searchConSelect">
               	  <option selected>찾아보기</option>
                  <option value="MEMBER_NAME">파일 이름</option>
                  <option value="CONTENT_TITLE">확장자</option>
               </select>
            </div>        
            <input type="text" class="form-control" placeholder="keyword" aria-label="Recipient's username" aria-describedby="button-addon2" id="searchConKeyword">
            <button class="btn btn-outline-success" type="button" id="searchConBtn">검색</button>
      </div>
      
	   <!-- 파일출력공간 -->
	   <div id="fileList">
	   		<div id="workFileList"></div>
	   		<div id="normalFileList"></div>
	   </div>
   </div>


</div>
   
   
<script>
$(()=>{//로드되자마자 실행 
	alert("실행되니?");
	let proNo=<%=p.getProjectNo()%>;//프로젝트번호 
	console.log("누르신 프로젝트 번호는:"+proNo);
	//업무 파일
			let table=$("<table>");
			let tr=$("<tr>");
			let th=$("<th>").html("제목");
			let th1=$("<th>").html("파일 이름");
			tr.append(th).append(th1);
			table.append(tr);
	$.ajax({
		url: "<%=request.getContextPath()%>/project/WorkFileInProjectEndServlet.do",
		type: "post",
		data : {"proNo":proNo},
		success : data =>{
			alert("석세스 안이야");
			console.log(data);
			
			
			for(let i=0;i<data.length;i++){
				let tr2=$("<tr >");
				let title=$("<td>").html(data[i]["contentTitle"]);
				let oriFileName=$("<td onclick='WorkfileDownload(this);'>").html(data[i]["workOriFileName"])
				//let reFileName=$("<input type='hidden' id='rename' name='rename' value=''>").attr('value',data[i]["workReFileName"]);
				let reFileName=$("<td style='visibility:hidden'>").html(data[i]["workReFileName"]);
				tr2.append(title).append(oriFileName).append(reFileName);
				table.append(tr2);
			}
			//$("#workFileList").html(table);
		}
	});
	//일반 파일
	$.ajax({
		url: "<%=request.getContextPath()%>/project/NormalFileInProjectEndServlet.do",
		type: "post",
		data : {"proNo":proNo},
		success : data =>{
			alert("석세스 안이야");
			console.log(data);
			
		/* 	let table=$("<table>");
			let tr=$("<tr>");
			let th=$("<th>").html("제목");
			let th1=$("<th>").html("파일 이름");
			tr.append(th).append(th1);
			table.append(tr); */
			
			for(let i=0;i<data.length;i++){
				let tr2=$("<tr >");
				let title=$("<td>").html(data[i]["contentTitle"]);
				let oriFileName=$("<td onclick='NormalfileDownload(this);'>").html(data[i]["workOriFileName"])
				//let reFileName=$("<input type='hidden' id='rename' name='rename' value=''>").attr('value',data[i]["workReFileName"]);
				let reFileName=$("<td style='visibility:hidden'>").html(data[i]["workReFileName"]);
				tr2.append(title).append(oriFileName).append(reFileName);
				table.append(tr2);
			}
			$("#workFileList").html(table);
		}
	});
	
});

function WorkfileDownload(e){//업무파일다운
	alert("업무파일다운실행이야")
	let oriFileName=$(e).text();
	let reFileName=$(e).next().text();
	
	console.log(oriFileName);
	console.log(reFileName);
		
		const url = "<%=request.getContextPath()%>/project/workfileDownload.do";
	    const encode = encodeURIComponent(oriFileName);
	    location.assign(url+"?workOriFileName="+encode+"&&workReFileName="+reFileName);
	    
		
}
function NormalfileDownload(e){//일반파일다운
	alert("일반파일다운실행이야")
	let oriFileName=$(e).text();
	let reFileName=$(e).next().text();
	
	console.log(oriFileName);
	console.log(reFileName);
		
	    
	const url = "<%=request.getContextPath()%>/project/normalfileDownload.do";
    const encode = encodeURIComponent(oriFileName);
    location.assign(url+"?normalOriFileName="+encode+"&&normalReFileName="+reFileName); 
}
</script>




</main>
<%@ include file="/views/common/footer.jsp" %>