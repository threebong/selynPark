<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.help.admin.model.vo.AdminAttendance" %>
<%@ include file="/views/common/header.jsp" %>

<%
	List<AdminAttendance> list = (List<AdminAttendance>)request.getAttribute("attendanceDay");

%>
<style>
table {
  border-collapse: collapse;
  text-align: center;
  line-height: 1.5;
  width:100%;

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

</style>

<main>
<h1>근태관리</h1><br>
<h3 id="selectDate"></h3>
	<form id="frm" action="">
	<input id="checkDate" type="date" name="checkDate" onchange="adminAttendanceList();">
	<input id="hiddenDate" type="hidden">
	</form>



	<div id="writeTable"></div>
<form action="#" method="post" onsubmit="return create_pro(this);" id="update_attendance_frm">
<div class="modal fade" id="attendanceModal" tabindex="-1" aria-labelledby="attendanceModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
      	<div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">출퇴근 정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      	</div>
      	<div class="modal-body">
        <input class="form-control form-control-m" type="text" placeholder="이름(버튼 클릭했을때 유저 이름넣고 수정불가해야함)" aria-label=".form-control-lg example" name="memberName" id="proName_" autocomplete="off"><br>
        <input class="form-control form-control-m" type="text" placeholder="아이디(버튼 클릭했을때 유저 아이디넣고 수정불가해야함)" aria-label=".form-control-lg example" name="memberId" id="proName_" autocomplete="off"><br>
        <input class="form-control form-control-m" type="time" placeholder="출근시간(ex) 09:00)" aria-label=".form-control-lg example" name="attTime" id="proName_" autocomplete="off"><br>
        <input class="form-control form-control-m" type="time" placeholder="퇴근시간(ex) 18:00)" aria-label=".form-control-lg example" name="leaveTime" id="proName_" autocomplete="off"><br>
        <input class="form-control form-control-m" type="text" placeholder="상태(출근/퇴근 상태입력)" aria-label=".form-control-lg example" name="attStatus" id="proName_" autocomplete="off"><br>
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
         data-bs-toggle="modal" data-bs-target="#attendanceModal" style="display: none;">New Project</button> 

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
				const memberList = data["list"];
				const table=$('<table>');
				let thead=$("<thead>");
				let tbody=$('<tbody>');
				let tr=$("<tr>");
				let th1=$("<th>").html("이름");
				let th2=$("<th>").html("아이디");
				let th3=$("<th>").html("부서");
				let th4=$("<th>").html("직책");
				let th5=$("<th>").html("출근시간");
				let th6=$("<th>").html("퇴근시간");
				let th7=$("<th>").html("상태");
				let th8=$("<th>").html("비고");
				thead.append(th1).append(th2).append(th3).append(th4).append(th5).append(th6).append(th7).append(th8);
				table.append(thead);
				if(memberList.length==0){
					let tr2 = $("<tr>");
					let ntd=$("<td>").html("조회결과가 없습니다.");
					ntd.attr("colspan","8");
					tr.css("text-align","center");
					tr.append(ntd);
					tbody.append(tr);
					table.append(tbody);
				} else{
					for(let i=0; i<memberList.length; i++){
						let tr2 = $("<tr>");
						let name = $("<td>").html(memberList[i]["memberName"]);
						let id = $("<td>").html(memberList[i]["memberId"]);
						let memberId = $('<input>').attr("type","hidden");
						memberId.attr("name","memberId");
						memberId.attr("value",memberList[i]["memberId"]);
						id.append(memberId);
						let dName = $("<td>").html(memberList[i]["deptName"]);
						let pName = $("<td>").html(memberList[i]["positionName"]);
						let attTime = $("<td>").html(memberList[i]["attTime"]);
						let leaveTime = $("<td>").html(memberList[i]["leaveTime"]);
						let attStatus = $("<td>").html(memberList[i]["attStatus"]);
						let note = $("<td>").html("<button>수정");
						note.children('button').attr("id","updateAttendance"+i);
						note.children('button').attr("onclick","adminUpdateAttendance(this);");
						tbody.append(tr2);
						table.append(tbody);
						tr2.append(name).append(id).append(dName).append(pName).append(attTime).append(leaveTime).append(attStatus).append(note);
					 /* 	$(document).on("click", "#updateAttendance"+i, function() {
						   alert(i);
						}); */

					}
				}
				const div=$("<div>").attr("id","pageBar").html(data["pageBar"]);
				table.append(div);
				$("#writeTable").html(table);
				
			}
		});
	});
};

const adminUpdateAttendance=(e)=>{
   var tr = e.parentElement.parentElement;
   console.log("input");
   $("#update-AttendanceBtn").click();
   console.log(tr);
};

</script>
