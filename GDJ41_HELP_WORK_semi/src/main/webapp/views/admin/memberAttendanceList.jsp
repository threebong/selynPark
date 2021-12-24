<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.help.admin.model.vo.AdminAttendance" %>
<%@ include file="/views/common/header.jsp" %>

<%
	List<AdminAttendance> list = (List<AdminAttendance>)request.getAttribute("attendanceDay");

%>
<style>
table.attendanceType {
  border-collapse: collapse;
  text-align: center;
  line-height: 1.5;
  width:100%;

}
table.attendanceType thead th {
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: black;
  border-bottom: 3px solid #036;
}
table.attendanceType tbody th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-bottom: 1px solid black;
  background: #f3f6f7;
}
table.attendanceType td {
  
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
	<input id="checkDate" type="date" name="checkDate">
	</form>


	<table class="attendanceType">
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
	 
	</table>

</main>
<script>

var today = moment(c).format('yyyy년 MM월 DD일');
var c = $("#checkDate").val();
$("#selectDate").text(today);
$("#checkDate").change(e=>{
	var c2 = $("#checkDate").val();
	var t = moment(c2).format('yyyy년 MM월 DD일');
	$("#selectDate").text(t);
	
	$("#selectDate").val($("#checkDate").val());
	let day = $("#checkDate").val();
	
	$.ajax({
		url : "<%=request.getContextPath()%>/admin/attendanceListEnd.do",
		
		
		
	})
})
</script>
