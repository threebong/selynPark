<%@ page  language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ page import = "java.util.List, com.help.attendance.model.vo.Attendance" %>
<%
	List<Attendance> list = (List<Attendance>)request.getAttribute("attendanceMonthly");
 
	SimpleDateFormat time = new SimpleDateFormat("HH:mm");
	SimpleDateFormat date = new SimpleDateFormat("yyyy-mm-dd");

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
input#checkMonth{
 float: right;
}
input#selectMonth{
border:none;
font-size:30px;
}

</style>



<main>
		<form id="frm" action="">
		<span><input type="text" id="selectMonth" name="selectMonth" readonly/></input></span><br>
		<input id="checkMonth" type="month" name="checkMonth">
		</form>


		<table class="attendanceType">
		  <thead>
		  <tr>
		    <th>날짜</th>
		    <th>출근시간</th>
		    <th>퇴근시간</th>
		    <th>상태</th>
		  </tr>
		  </thead>
		  <tbody id="ajaxTable">
		 	<% if(list.isEmpty()) { %>
		  	<tr id="result">
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

</main>
<script>
  //document.getElementById('checkMonth').valueAsDate = new Date();  //기본으로 현재 달 표기
 	$("#checkMonth").change(e=>{
 		$("#ajaxTable").hide(); // 최초페이지에서 출력한 데이터 숨겨주고
 		$("#ajaxTable").remove(); 
    	 const memberId ="<%=loginMember.getMemberId()%>";
    	$("#selectMonth").val($("#checkMonth").val());
		let month = $("#selectMonth").val();
   
    	 $.ajax({
    		url : "<%=request.getContextPath()%>/attendance/attendanceListEnd.do",
    		type:'post',
			data : {"memberId":memberId,"month":month},
			dataType : 'json',
            success:data=>{
				let tbody=$('tbody[id="changeAjax"]');
				for(let i=0; i<data.length; i++){
					let tr=$("<tr>");
					let attDate=$("<td>").html(data[i]["attDate"]);
					let attTime=$("<td>").html.(data[i]["attTime"]);
					let leaveTime=$("<td>").html(data[i]["leaveTime"]);
					let attStatus=$("<td>").html(data[i]["attStatus"]);
					tr.append(attDate).append(attTime).append(leaveTime).append(attStatus);
					tbody.append(tr);
				}
				$("#ajaxTable").html(data);
				console.log(data);
            }
    	 })
     });
  

<%--   $("#checkMonth").change(e=>{
	$.ajax({
		url:"<%=request.getContextPath()%>/attendance/attendanceListEnd.do",
		type:"post",
		data:{"monthData":$("#checkMonth").val()},
		success:data=>{
			for(let i=0; i<data.length; i++){
			let tr=$('tr[id="result"]');
			let attDate=$("<td>").html(data[i]["attDate"]);
			let attTime=$("<td>").html(data[i]["attTime"]);
			let leaveTime=$("<td>").html(data[i]["leaveTime"]);
			let attStatus=$("<td>").html(data[i]["attStatus"]);
			tr.append(attDate).append(attTime).append(leaveTime).append(attStatus);
			table.append(tr);
			}
		}
	})
}) --%>


<%-- var request = new XMLHttpRequest();
function searchMonth(){
	request.open("Post","<%=request.getContextPath()%>/JSONServlet",true);
	request.onreadystatechange = searchProcess;
	request.send(null);
	
}
function searchProcess(){
	var table = document.getElementById("ajaxTable");
	table.innerHTML = "";
	if(request.readyState)==4&&request.status=200){
		var object = eval('('+request.responseText+')');
		var result = object.result;
		for(var i=0; i<result.length; i++){
			var row = table.insertRow(0);
			for(var j=0; j<result[i].length; j++){
				var cell = row.insertCell(j);
				cell.innerHTML = result[i][j].value;
			}
		}
	}
} --%>
	

</script>

<%@ include file="/views/common/footer.jsp" %>