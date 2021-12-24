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


<%-- 	<table class="attendanceType">
	  <thead>
		  <tr>
		    <th>이름</th>
		    <th>아이디</th>
		    <th>부서</th>
		    <th>직급</th>
		    <th>출근시간</th>
		    <th>퇴근시간</th>
		    <th>비고</th>
		  </tr>
	  </thead>
	  <tbody id="ajaxTable">
	  <% if(list.isEmpty()){ %>
	 	<tr>
	 		<td colspan="7">조회된 출퇴근 내역이 없습니다.</td>
	 	</tr>
	 <%} else { 
	 		for(AdminAttendance day : list) {
	 %>
	 <tr>
	 	<td><%=day.getMemberName() %></td>
	 	<td><%=day.getMemberId() %></td>
	 	<td><%=day.getDeptName() %></td>
	 	<td><%=day.getPositionName() %></td>
	 	<td><%=day.getAttTime() %></td>
	 	<td><%=day.getLeaveTime() %></td>
	 	<td><button>수정</button></td>
	 
	 </tr>
	 	<%}
	 }%>
	
	  </tbody>
	 
	</table> --%>
	<div id="writeTable"></div>

</main>
<script>

//오늘 날짜 출력
var today = moment(checkDay).format('yyyy년 MM월 DD일');
var checkDay = $("#checkDate").val();
$("#selectDate").text(today);

//함수 먼저 실행
$(document).ready(()=>{
	adminAttendanceList();
	
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
				console.log(memberList);
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
				let th7=$("<th>").html("비고");
				thead.append(tr).append(th1).append(th2).append(th3).append(th4).append(th5).append(th6).append(th7);
				table.append(thead);
				if(memberList.length==0){
					let tr2 = $("<tr>");
					let ntd=$("<td>").html("조회결과가 없습니다.");
					ntd.attr("colspan","7");
					tr.css("text-align","center");
					tbody.append(tr).append(ntd);
					table.append(tbody);
				} else{
					for(let i=0; i<memberList.length; i++){
						let tr2 = $("<tr>");
						let name = $("<td>").html(memberList[i]["memberName"]);
						let id = $("<td>").html(memberList[i]["memberId"]);
						let dName = $("<td>").html(memberList[i]["deptName"]);
						let pName = $("<td>").html(memberList[i]["positionName"]);
						let attTime = $("<td>").html(memberList[i]["attTime"]);
						let leaveTime = $("<td>").html(memberList[i]["leaveTime"]);
						let note = $("<td>").html("<button>수정");
						tbody.append(tr2).append(name).append(id).append(dName).append(pName).append(attTime).append(leaveTime).append(note);
						table.append(tbody);
					}
				}
				const div=$("<div>").attr("id","pageBar").html(data["pageBar"]);
				table.append(div);
				$("#writeTable").html(table);
				
			}
		});
	});
};


</script>
