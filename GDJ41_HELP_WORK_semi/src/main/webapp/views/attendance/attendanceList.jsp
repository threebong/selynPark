<%@ page  language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%@ page import = "com.help.attendance.model.vo.Attendance" %>
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
<h3 id="selectMonth"></h3>
		<form id="frm" action="">
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
		  	<tr>
		  		<td colspan="4">조회된 출퇴근 이력이 없습니다.</td>
		  	</tr>
		  	<%} else { 
		  		for(Attendance aMonth : list) {
		  	%>
		  	<tr>
		  		<td><%=aMonth.getAttDate()%></td>
		  		<td><%=aMonth.getAttTime()%></td>
		  		<td>
		  	 	 <% try { %> 
		  			<%=aMonth.getLeaveTime()%>
		  		 <% } catch(Exception e){ %>
		  		 퇴근정보가 없습니다.
		  		<%} %>  
		  		</td>
		  		<td><%=aMonth.getAttStatus() %></td>
		  	</tr>
		  	<%}
		  	}%>
		
		  </tbody>
		  <tbody id="changeAjax">
		  </tbody>
		
		</table>

</main>
<script>
	var date = moment(check).format('yyyy년 MM월');
	var check = $("#checkMonth").val();
	$("#selectMonth").text(date);

 	$("#checkMonth").change(e=>{
		var check2 = $("#checkMonth").val();
		var date = moment(check2).format('yyyy년 MM월');
		$("#selectMonth").text(date);
    	const memberId ="<%=loginMember.getMemberId()%>";
    	$("#selectMonth").val($("#checkMonth").val());
		let month = $("#checkMonth").val();
   
    	 $.ajax({
    		url : "<%=request.getContextPath()%>/attendance/attendanceListEnd.do",
    		type:'post',
			data : {"memberId":memberId,"month":month},
			dataType : 'json',
            success:data=>{
 	 			$("#ajaxTable").remove();
				let tbody=$('tbody[id="changeAjax"]');
				tbody.empty();
				if(data.length==0){
					let tr=$("<tr>");
					let ntd=$("<td>").html("조회결과가 없습니다.");
					ntd.attr("colspan","4");
					tr.css("text-align","center");
					tr.append(ntd);
					tbody.append(tr);
				}else{
					for(let i=0; i<data.length; i++){
						let tr=$("<tr>");
						let attDate=$("<td>").html(data[i]["attDate"]);
						let attTime=$("<td>").html(data[i]["attTime"]);
						let leaveTime=$("<td>").html(data[i]["leaveTime"]);
						let attStatus=$("<td>").html(data[i]["attStatus"]);
						tr.append(attDate).append(attTime).append(leaveTime).append(attStatus);
						tbody.append(tr);
					}	
				}
				tbody.html(tr);
            }
    	 })
     });
 

	

</script>

<%@ include file="/views/common/footer.jsp" %>