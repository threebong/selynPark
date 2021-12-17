<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%-- <%@ page import = "java.util.List, com.member.attendance.vo.Attendance" %> --%>
<%-- <%
	List<Attendance> list (List<Attendance>)request.getAttribute("attendanceList");
%> --%>
<main>

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
<input type="text" id="selectMonth" readonly/></input><br>
<!-- 연,월만 들어가게끔 여기랑 일치하는 날짜만 db가져오게-->
<input id="checkMonth" type="month" onchange="selectDate();"/><!--연,월 선택  -->



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
<%--   	<% if(list.isEmpty()) { %>
  	<tr>
  		<td colspan="4">조회된 출퇴근 이력이 없습니다.</td>
  	</tr>
  	<%} else { 
  		for(Attendance a : list) {
  	%>
  	<tr>
  		<td><%=a.getAttDate().getDate() %></td> <!-- '일'만 가져와야함 -->
  		<td><%=a.getAttTime() %></td>
  		<td><%=a.getLeaveTime() %></td>
  		<td><%=a.getAttStatus() %></td>
  	</tr>
  	<%}
  	}%> --%>
  <tr>
    <th>1일</th>
    <td>09:00</td>
    <td>18:00</td>
    <td>퇴근</td>
  </tr>
  <tr>
    <th>2일</th>
    <td>09:00</td>
    <td>-</td>
    <td>출근</td>
  </tr>
  <tr>
    <th>3일</th>
    <td>09:00</td>
    <td>17:00</td>
    <td>조퇴</td>
  </tr>
  </tbody>
</table>

<script>
const selectDate =()=> {
    var checkMonth = document.getElementById("checkMonth");
    var selectMonth = document.getElementById("selectMonth");
    selectMonth.value = checkMonth.value;
  };
	

</script>



</main>
<%@ include file="/views/common/footer.jsp" %>