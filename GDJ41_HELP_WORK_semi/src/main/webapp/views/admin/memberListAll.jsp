<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>


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
#menu-container a {
	font-size: 25px;
	font-weight: bold;
	color: gray;
}
#menu-container {
	margin-left: 30px;
}


</style>

<main>
		
	<h1>사원관리</h1><br>
	<div id="menu-container">
		<ul class="nav">
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="#" onclick="adminMemberList();">직원현황</a></li>
			<li class="nav-item"><a class="nav-link" href="#">대기현황</a></li>
		</ul>
	</div>
	<hr style="margin-top: 5px;">
		
		<div id="writeTable"></div>
		  
		

</main>
<script>
//관리자 -> 사원관리
function adminMemberList(cPage){
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/memberListEnd.do",
		type:'post',
		data:{cPage:cPage},
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
			let th5=$("<th>").html("연락처");
			let th6=$("<th>").html("비고");
			thead.append(tr).append(th1).append(th2).append(th3).append(th4).append(th5).append(th6);
			table.append(thead);
			for(let i=0; i<memberList.length; i++){
				let tr2 = $("<tr>");
				let name = $("<td>").html(memberList[i]["memberName"]);
				let id = $("<td>").html(memberList[i]["memberId"]);
				let dName = $("<td>").html(memberList[i]["deptName"]);
				let pName = $("<td>").html(memberList[i]["positionName"]);
				let phone = $("<td>").html(memberList[i]["memberPhone"]);
				let note = $("<td>").html("없음");
				tbody.append(tr2).append(name).append(id).append(dName).append(pName).append(phone).append(note);
				table.append(tbody);
			}
			const div=$("<div>").attr("id","pageBar").html(data["pageBar"]);
			table.append(div);
			$("#writeTable").html(table);
			
		}
	});
};
</script>


<%@ include file="/views/common/footer.jsp"%>