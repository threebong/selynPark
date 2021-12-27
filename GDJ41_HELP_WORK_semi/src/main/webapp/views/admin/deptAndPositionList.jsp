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


<div id="deptTitle"><h1>부서/직급관리</h1></div><br>

	<div id="menu-container">
		<ul class="nav">
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="#" onclick="adminDeptList();">부서관리</a></li>
			<li class="nav-item"><a class="nav-link" href="#" onclick="waitPositionList();">직급관리</a></li>
		</ul>
	</div>
	<hr style="margin-top: 5px;">
	
	<div id="DeptTable"></div>
	<div id="PositionTable"></div>
	


</main>


<script>
$(document).ready(()=>{
	adminDeptList();
});


function adminDeptList(){
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/waitMemberListEnd.do",
		type:'post',
		dataType : 'json',
		success:data=>{
			const table=$('<table>');
			let thead=$("<thead>");
			let tbody=$('<tbody>');
			let tr=$("<tr>");
			let th1=$("<th>").html("부서코드");
			let th2=$("<th>").html("부서명");
			let th3=$("<th>").html("수정");
			let th4=$("<th>").html("삭제");
			thead.append(tr).append(th1).append(th2).append(th3).append(th4);
			table.append(thead);
			if(data.length==0){
				let tr2 = $("<tr>");
				let ntd=$("<td>").html("조회결과가 없습니다.");
				ntd.attr("colspan","4");
				tr.css("text-align","center");
				tr2.append(ntd);
				tbody.append(tr2);
				table.append(tbody);
			} else{
				for(let i=0; i<data.length; i++){
					let tr2 = $("<tr>");
					let name = $("<td>").html(data[i]["memberName"]);
					let memberName = $('<input>').attr({type:"hidden",name:"memberName",id:"memberName",value:data[i]["memberName"]});
					name.append(memberName);
					let id = $("<td>").html(data[i]["memberId"]);
					let memberId = $('<input>').attr({type:"hidden",name:"memberId",id:"memberId",value:data[i]["memberId"]});
					id.append(memberId);
					let dName = $("<td>").html(data[i]["deptName"]);
					let pName = $("<td>").html(data[i]["positionName"]);
					let phone = $("<td>").html(data[i]["memberPhone"]);
					let note = $("<td>").html("<button>수정");
					note.children('button').attr("id","updateWaitMember"+i);
					note.children('button').attr("onclick","adminUpdateWaitMember(this);");
					table.append(tbody);
					tbody.append(tr2);
					tr2.append(name).append(id).append(dName).append(pName).append(phone).append(note);
				}
			}
			$("#writeTable").html(table);
		}
	});
};

</script>



<%@ include file="/views/common/footer.jsp"%>
