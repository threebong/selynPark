<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ page import = "java.util.List, com.help.attendance.model.vo.Attendance, java.util.List" %>
<%
	List<Attendance> list = (List<Attendance>)request.getAttribute("attendanceMonthly");

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
  color: #369;
  border-bottom: 3px solid #036;
}
table.attendanceType tbody th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
  background: #f3f6f7;
}
table.attendanceType td {
  
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}
input#checkMonth{
 float: right;
}
input#selectMonth{
border:none;
font-size:30px;
}

</style>
<main>

	<form id="frm" action="" method="post">
		<span><input type="text" id="selectMonth" name="selectMonth" readonly/></input></span><br>
		<input id="checkMonth" type="month" onchange="selectDate();"/>


		<table class="attendanceType">
		  <thead>
		  <tr>
		    <th>날짜</th>
		    <th>출근시간</th>
		    <th>퇴근시간</th>
		    <th>상태</th>
		  </tr>
		  </thead>
		  <tbody>
			<% if(list.isEmpty()) { %>
		  	<tr>
		  		<td colspan="4">조회된 출퇴근 이력이 없습니다.</td>
		  	</tr>
		  	<%} else { 
		  		for(Attendance aMonth : list) {
		  	%>
		  	<tr>
		  		<td><%=aMonth.getAttDate()%></td>
		  		<td><%=sdf.format(aMonth.getAttTime()) %></td>
		  		<td>
		  	
		  		 <% try { %> 
		  		 <%=sdf.format(aMonth.getLeaveTime()) %>
		  		 <% } catch(Exception e){ %>
		  		 퇴근정보가 없습니다.
		  		<%} %> 
		  		</td>
		  		<td><%=aMonth.getAttStatus() %></td>
		  	</tr>
		  	<%}
		  	}%>
		
		  </tbody>
		</table>

	</form>
</main>
<script>
document.getElementById('checkMonth').valueAsDate = new Date(); //기본으로 현재 달 표기
$("#checkMonth").change(e=>{
	$("#selectMonth").val($("#checkMonth").val())
	<%-- $("#frm").attr("action","<%=request.getContextPath() %>/attendance/attendanceList.do")
	$("#frm").attr("method","post")
	$("#frm").submit() --%>
});
/* $(()=>{
	$("#checkMonth").change();
}); */

	

</script>

<%@ include file="/views/common/footer.jsp" %>