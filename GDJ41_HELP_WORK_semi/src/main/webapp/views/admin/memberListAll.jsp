<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

<style>
table {
  border-collapse: collapse;
  text-align: center;
  line-height: 1.5;
  width:100%;
  border-radius: 30px;
  

}

table thead th {
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: black;
  border-bottom: 3px solid #036;
}


table td {
  
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}

#menu-container a {
	font-size: 25px;
	font-weight: bold;
	color: gray;
}
#menu-container {
	margin-left: 30px;
}

tr:hover {
  background-color:rgba(183, 191, 225,0.2);
}

div#memberTitle, div#menu-container, div#MemberInfoModal, div#WaitMemberModal, table{
font-family: 'Do Hyeon', sans-serif;
}


.btn-outline-secondary:hover{
   background-color: #6710f242;
   border: 1px solid #6710f242;
}
.btn-outline-secondary{
   border: 1px solid #6710f242;
   color:#6710f242;
}


div#pageAll{
margin : 30px 30px;
}

div#writeTable{
background-color:rgba(183, 191, 225,0.2);
border-radius:30px;

}


</style>

<main>
<div id="pageAll">		
	<div id="memberTitle"><h1>사원관리</h1></div><br>
	<div id="menu-container">
		<ul class="nav">
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="#" onclick="adminMemberList();">직원현황</a></li>
			<li class="nav-item"><a class="nav-link" href="#" onclick="waitMemberList();">대기현황</a></li>
		</ul>
	</div>
	<hr style="margin-top: 5px;">
		
		<div id="writeTable"></div>

<!-- 대기현황 모달창 -->	
<form action="<%=request.getContextPath() %>/admin/updateWaitMember.do" method="post" id="update_WaitMember_frm">
<div class="modal fade" id="WaitMemberModal" tabindex="-1" aria-labelledby="WaitMemberModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
      	<div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">대기사원 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      	</div>
      	<div class="modal-body">
        이름<input class="form-control form-control-m modName" type="text" aria-label=".form-control-lg example" name="memberName" id="modName" readonly><br>
        아이디<input class="form-control form-control-m modId" type="text" aria-label=".form-control-lg example" name="memberId" id="modId" readonly><br>
        부서명<select class="form-select" aria-label="Default select example" name="modDeptName" id="modDeptName">
			</select><br>
        직급명<select class="form-select" aria-label="Default select example" name="modPositionName" id="modPositionName">
			</select><br>
        
        <span id="proName-result"></span>
      	</div>
      	<div class="modal-footer">
        	<button type="submit" class="btn btn-primary">등록</button>
        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close-project">닫기</button>
        </div>
        </div>
  </div>
</div>
</form>
		
		
<!-- 사원 정보수정 모달창 -->  
<form action="<%=request.getContextPath() %>/admin/updateMemberInfo.do" method="post" id="update_MemberInfo_frm" onsubmit="return update_memberInfo(this);">
<div class="modal fade" id="MemberInfoModal" tabindex="-1" aria-labelledby="#MemberInfoModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
      	<div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">사원 정보수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      	</div>
      	<div class="modal-body">
        아이디<input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="memberId" id="modId2" readonly><br>
        이름<input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="memberName" id="modName2"><br>
        부서명<select class="form-select" aria-label="Default select example" name="modDeptName2" id="modDeptName2">
			</select><br>
        직급명<select class="form-select" aria-label="Default select example" name="modPositionName2" id="modPositionName2">
			</select><br>
        연락처<input class="form-control form-control-m modName" placeholder="ex) 01012345678" type="text" aria-label=".form-control-lg example" name="modPhone" id="modPhone"><br>
        
        <span id="proName-result"></span>
      	</div>
      	<div class="modal-footer">
        	<button type="submit" class="btn btn-primary">등록</button>
        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close-project">닫기</button>
        </div>
        </div>
  </div>
</div>
</form>

	<button id="update-WaitMemberBtn" type="button" class="btn btn-primary"
     data-bs-toggle="modal" data-bs-target="#WaitMemberModal" style="display: none;">대기사원 등록</button> 

	<button id="update-MemberInfoBtn" type="button" class="btn btn-primary"
     data-bs-toggle="modal" data-bs-target="#MemberInfoModal" style="display: none;">사원정보 수정</button> 
	
	<div id="pageNavContainer" style="display: flex; justify-content: center; margin-top: 15px; "></div>
</div>	
</main>
<script>
$(document).ready(()=>{
	adminMemberList();
});

//관리자 -> 사원관리
function adminMemberList(cPage){
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/memberListEnd.do",
		type:'post',
		data:{cPage:cPage},
		dataType : 'json',
		success:data=>{
			$("#pageNavContainer").html("");
			const memberList = data["list"];
			const table=$('<table>');
			let thead=$("<thead>");
			let tbody=$('<tbody>');
			let tr=$("<tr>");
			let th1=$("<th style='font-size:20px;'>").html("이름");
			let th2=$("<th style='font-size:20px;'>").html("아이디");
			let th3=$("<th style='font-size:20px;'>").html("부서");
			let th4=$("<th style='font-size:20px;'>").html("직책");
			let th5=$("<th style='font-size:20px;'>").html("연락처");
			let th6=$("<th style='font-size:20px;'>").html("비고");
			table.append(thead);
			thead.append(tr);
			tr.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6);
			if(memberList.length==0){
				let tr2 = $("<tr>");
				let ntd=$("<td>").html("조회결과가 없습니다.");
				ntd.attr("colspan","6");
				tr.css("text-align","center");
				tr2.append(ntd);
				tbody.append(tr2);
				table.append(tbody);
			} else{
				for(let i=0; i<memberList.length; i++){
					let tr2 = $("<tr>");
					let name = $("<td>").html(memberList[i]["memberName"]);
					let memberName = $('<input>').attr({type:"hidden",name:"memberName",id:"memberName",value:memberList[i]["memberName"]});
					name.append(memberName);
					let id = $("<td>").html(memberList[i]["memberId"]);
					let memberId = $('<input>').attr({type:"hidden",name:"memberId",id:"memberId",value:memberList[i]["memberId"]});
					id.append(memberId);
					let dName = $("<td>").html(memberList[i]["deptName"]);
					let deptName = $('<input>').attr({type:"hidden",name:"deptName",id:"deptName",value:memberList[i]["deptName"]});
					dName.append(deptName);
					let pName = $("<td>").html(memberList[i]["positionName"]);
					let positionName = $('<input>').attr({type:"hidden",name:"positionName",id:"positionName",value:memberList[i]["positionName"]});
					pName.append(positionName);
					let phone = $("<td>").html(memberList[i]["memberPhone"]);
					let note = $("<td>").html("<button>수정");
					note.children('button').attr({id:"updateMember"+i, class:"btn btn-outline-secondary"});
					note.children('button').attr("onclick","adminUpdateMember(this);");
					table.append(tbody);
					tbody.append(tr2);
					tr2.append(name).append(id).append(dName).append(pName).append(phone).append(note);
				}
			}
			const div=$("<div style='text-align:center;'>").attr("id","pageBar").html(data["pageBar"]);
			$("#pageNavContainer").append(div);
			$("#writeTable").html(table);
			
		}
	});
};

//대기현황
function waitMemberList(cPage){
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/waitMemberListEnd.do",
		type:'post',
		data:{cPage:cPage},
		dataType : 'json',
		success:data=>{
			$("#pageNavContainer").html("");
			const memberList = data["list"];
			const table=$('<table>');
			let thead=$("<thead>");
			let tbody=$('<tbody>');
			let tr=$("<tr>");
			let th1=$("<th style='font-size:20px;'>").html("이름");
			let th2=$("<th style='font-size:20px;'>").html("아이디");
			let th3=$("<th style='font-size:20px;'>").html("부서");
			let th4=$("<th style='font-size:20px;'>").html("직책");
			let th5=$("<th style='font-size:20px;'>").html("연락처");
			let th6=$("<th style='font-size:20px;'>").html("비고");
			thead.append(tr).append(th1).append(th2).append(th3).append(th4).append(th5).append(th6);
			table.append(thead);
			if(data.length==0){
				let tr2 = $("<tr>");
				let ntd=$("<td>").html("조회결과가 없습니다.");
				ntd.attr("colspan","6");
				tr.css("text-align","center");
				tr2.append(ntd);
				tbody.append(tr2);
				table.append(tbody);
			} else{
				for(let i=0; i<memberList.length; i++){
					let tr2 = $("<tr>");
					let name = $("<td>").html(memberList[i]["memberName"]);
					let memberName = $('<input>').attr({type:"hidden",name:"memberName",id:"memberName",value:memberList[i]["memberName"]});
					name.append(memberName);
					let id = $("<td>").html(memberList[i]["memberId"]);
					let memberId = $('<input>').attr({type:"hidden",name:"memberId",id:"memberId",value:memberList[i]["memberId"]});
					id.append(memberId);
					let dName = $("<td>").html(memberList[i]["deptName"]);
					let pName = $("<td>").html(memberList[i]["positionName"]);
					let phone = $("<td>").html(memberList[i]["memberPhone"]);
					let note = $("<td>").html("<button>수정");
					note.children('button').attr({id:"updateWaitMember"+i, class:"btn btn-outline-secondary"});
					note.children('button').attr("onclick","adminUpdateWaitMember(this);");
					table.append(tbody);
					tbody.append(tr2);
					tr2.append(name).append(id).append(dName).append(pName).append(phone).append(note);
				}
			}
			const div=$("<div style='text-align:center;'>").attr("id","pageBar").html(data["pageBar"]);
			$("#pageNavContainer").append(div);
			$("#writeTable").html(table);
		}
	});
};

//수정버튼 클릭시 클릭한 위치의 사원명,아이디 넣어주기위함(대기현황)
const adminUpdateWaitMember=(e)=>{
	   var memberName = e.parentElement.parentElement.children[0].children[0].value;
	   $("#modName").val(memberName);
	   var memberId = e.parentElement.parentElement.children[1].children[0].value;
	   $("#modId").val(memberId);
	   $("#update-WaitMemberBtn").click();
};

//모달창 부서명,직급명 선택 -> 대기사원 수정
$("#update-WaitMemberBtn").click(e=>{
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/updateDeptAndPosition.do",
		type:'post',
		dataType : 'json',
		success:data=>{
			const deptList = data["deptList"];
			const positionList = data["positionList"];
			
			//부서명 value값은 name이 아닌 code값으로
			for(let i=0; i<deptList.length; i++){
				$("#modDeptName").append('<option value="'+deptList[i]["deptCode"]+'">'+deptList[i]["deptName"]+'</option>');
			};
			
			//직급명 value값은 name이 아닌 code값으로
			for(let i=0; i<positionList.length; i++){
				$("#modPositionName").append('<option value="'+positionList[i]["positionCode"]+'">'+positionList[i]["positionName"]+'</option>');
			};
			
		}
		
	});
});


//사원정보 수정버튼 클릭시 클릭한 위치의 사원명,아이디 넣어주기 이름은 변경가능, 아이디는 변경불가(사원현황)
const adminUpdateMember=(e)=>{
	   var memberName = e.parentElement.parentElement.children[0].children[0].value;
	   $("#modName2").val(memberName);
	   var memberId = e.parentElement.parentElement.children[1].children[0].value;
	   $("#modId2").val(memberId);
	   
	 
	   var deptName = e.parentElement.parentElement.children[2].children[0].value;
	   //$("#modDeptName2 option").filter(function() {return this.text == deptName;}).attr('selected',true);
	   var dept = $('#modDeptName2 option:contains('+deptName+')').val();  
	   $('#modDeptName2').val(dept); 
	   var positionName = e.parentElement.parentElement.children[3].children[0].value;
	   var position = $('#modPositionName2 option:contains('+positionName+')').val();  
	   $('#modPositionName2').val(position); 
	   
	   $("#update-MemberInfoBtn").click();
};


//모달창 부서명,직급명 선택 -> 사원수정
$("#update-MemberInfoBtn").click(e=>{
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/updateDeptAndPosition.do",
		type:'post',
		dataType : 'json',
		success:data=>{
			const deptList = data["deptList"];
			const positionList = data["positionList"];
			
			//부서명 value값은 name이 아닌 code값으로
			for(let i=0; i<deptList.length; i++){
				$("#modDeptName2").append('<option value='+deptList[i]["deptCode"]+'>'+deptList[i]["deptName"]+'</option');
			};
			
			//직급명 value값은 name이 아닌 code값으로
			for(let i=0; i<positionList.length; i++){
				$("#modPositionName2").append('<option value="'+positionList[i]["positionCode"]+'">'+positionList[i]["positionName"]+'</option');
			};
			
		}
		
	});
});


//사원 정보수정시 이름,연락처 반드시 입력
const update_memberInfo=()=>{
    if($("#modName2").val().trim().length == 0){
       $("#modName2").focus();
       return false;
    }     
    if($("#modPhone").val().trim().length == 0){
       $("#modPhone").focus();
       return false;
    }     
 };

 $(document).on("click", ".modal_close",function(){
     $(".modal").removeClass("on");
     $('#form_box')[0].reset(); 
     $(this).parents(".modal_layer").fadeOut("fast");
 });

</script>


<%@ include file="/views/common/footer.jsp"%>