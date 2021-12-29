<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.help.admin.model.vo.AdminAttendance" %>
<%@ include file="/views/common/header.jsp" %>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

<%
	List<AdminAttendance> list = (List<AdminAttendance>)request.getAttribute("attendanceDay");

%>
<style>
table {
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

table tbody th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-bottom: 1px solid black;
  background: #f3f6f7;
}

table td {
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}

input#checkDate{
 float: right;
}

input#selectDate{
border:none;
font-size:30px;
}



tr:hover {
  background-color:rgba(183, 191, 225,0.2);
}


div#attTitle, div.modal, table {
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

	<div id="attTitle"><h1>근태관리</h1><br>
		<form id="frm" action="">
		<h3 id="selectDate"></h3>
		<input id="checkDate" type="date" name="checkDate" onchange="adminAttendanceList();">
		<input id="hiddenDate" type="hidden">
		</form><br>
	</div>
		<hr style="margin-top: 5px;">
	


	<div id="writeTable"></div>
<form action="<%=request.getContextPath() %>/admin/updateMemberAttendance.do" method="post" id="update_attendance_frm" onsubmit="return update_attendance(this);">
<div class="modal fade" id="attendanceModal" tabindex="-1" aria-labelledby="attendanceModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
      	<div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">출퇴근 정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      	</div>
      	<div class="modal-body">
        이름<input class="form-control form-control-m modName" type="text" aria-label=".form-control-lg example" name="memberName" id="modName" readonly><br>
        아이디<input class="form-control form-control-m modId" type="text" aria-label=".form-control-lg example" name="memberId" id="modId" readonly><br>
        출근시간<input class="form-control form-control-m" type="time" aria-label=".form-control-lg example" name="attTime" id="modAttTime" autocomplete="off"><br>
        퇴근시간<input class="form-control form-control-m" type="time" aria-label=".form-control-lg example" name="leaveTime" id="modLeaveTime" autocomplete="off"><br>
        상태<input class="form-control form-control-m" type="text" placeholder="상태(출근/퇴근 상태입력)" aria-label=".form-control-lg example" name="attStatus" id="modAttStatus" autocomplete="off"><br>
        <input type="hidden" name="attDate" id="modAttDate">
        <span id="proName-result"></span>
      	</div>
      	<div class="modal-footer">
        	<button type="submit" class="btn btn-primary">수정</button>
        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close-project">닫기</button>
        </div>
        </div>
  </div>
</div>
</form>
	
	<button id="update-AttendanceBtn" type="button" class="btn btn-primary"
     data-bs-toggle="modal" data-bs-target="#attendanceModal" style="display: none;">출퇴근정보 수정</button> 
     <div id="pageNavContainer" style="display: flex; justify-content: center; margin-top: 15px; "></div>
</div>
</main>
<script>

//오늘 날짜 출력
var today = moment(checkDay).format('yyyy년 MM월 DD일');
var checkDay = $("#checkDate").val();
$("#selectDate").text(today);

//최초 change 함수 자동실행 위한 날짜포맷
var today2 = moment(new Date()).format('yyyy-MM-DD');
	
//함수 먼저 실행
$(document).ready(()=>{
	adminAttendanceList();
	$("#checkDate").val(today2).trigger('change');
});

//페이징 처리 ajax
function adminAttendanceList(cPage){
	$("#checkDate").change(e=>{ //input change마다 이벤트 발생
		var checkDay2 = $("#checkDate").val();
		var momentFormat = moment(checkDay2).format('yyyy년 MM월 DD일'); 
		$("#selectDate").text(momentFormat); //보여지는 날짜포맷
		$("#hiddenDate").val(checkDay2); // hidden에 날짜 넣고
		let changeDays = $("#hiddenDate").val(); //파라미터로 보내기 위한 날짜
		$.ajax({
			url:"<%=request.getContextPath()%>/admin/memberAttendanceListEnd.do",
			type:'post',
			data:{cPage:cPage, changeDays:changeDays},
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
				let th5=$("<th style='font-size:20px;'>").html("출근시간");
				let th6=$("<th style='font-size:20px;'>").html("퇴근시간");
				let th7=$("<th style='font-size:20px;'>").html("상태");
				let th8=$("<th style='font-size:20px;'>").html("비고");
				thead.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6).append(th7).append(th8);
				table.append(thead);
				if(memberList.length==0){
					let tr2 = $("<tr>");
					let ntd=$("<td>").html("조회결과가 없습니다.");
					ntd.attr("colspan","8");
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
						let attTime = $("<td>").html(memberList[i]["attTime"]);
						let leaveTime = $("<td>").html(memberList[i]["leaveTime"]);
						let attStatus = $("<td>").html(memberList[i]["attStatus"]);
						let inputAttStatus = $('<input>').attr({type:"hidden",name:"attStatus",id:"attStatus",value:memberList[i]["attStatus"]});
						attStatus.append(inputAttStatus);
						let note = $("<td>").html("<button>수정");
						note.children('button').attr({id:"updateAttendance"+i,class:"btn btn-outline-secondary"});
						note.children('button').attr("onclick","adminUpdateAttendance(this);");
						tbody.append(tr2);
						table.append(tbody);
						tr2.append(name).append(id).append(dName).append(pName).append(attTime).append(leaveTime).append(attStatus).append(note);


					}
				}
				const div=$("<div style='text-align:center;'>").attr("id","pageBar").html(data["pageBar"]);
				$("#pageNavContainer").append(div);
				$("#writeTable").html(table);
				
			}
		});
	});
};

const adminUpdateAttendance=(e)=>{
   var memberName = e.parentElement.parentElement.children[0].children[0].value;
   $("#modName").val(memberName);
   var memberId = e.parentElement.parentElement.children[1].children[0].value;
   $("#modId").val(memberId);
   var attStatus = e.parentElement.parentElement.children[6].children[0].value;
   $("#modAttStatus").val(attStatus);
   $("#modAttDate").val($("#checkDate").val());
   $("#update-AttendanceBtn").click();
   console.log(attStatus);
};




//출퇴근 상태 반드시 입력
const update_attendance=()=>{
    if($("#modAttStatus").val().trim().length == 0){
       $("#modAttStatus").focus();
       return false;
    }     
 };

</script>
<%@ include file="/views/common/footer.jsp"%>
