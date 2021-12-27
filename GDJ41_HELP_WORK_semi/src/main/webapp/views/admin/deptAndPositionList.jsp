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
			<li class="nav-item"><a class="nav-link" href="#" onclick="adminPositionList();">직급관리</a></li>
		</ul>
	</div>
	<hr style="margin-top: 5px;">
	
	<div id="ajaxTable"></div>

<!-- 부서수정 모달창 -->
<button id="update-DeptBtn" type="button" class="btn btn-primary"
data-bs-toggle="modal" data-bs-target="#UpdateDeptModal" style="display: none;">부서 수정</button> 

<form action="<%=request.getContextPath() %>/admin/updateDeptName.do" method="post" id="update_DeptName_frm" onsubmit="return update_deptName(this);">
<div class="modal fade" id="UpdateDeptModal" tabindex="-1" aria-labelledby="#UpdateDeptModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
      	<div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">부서명 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      	</div>
      	<div class="modal-body">
      	
        부서코드<input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="modDeptCode" id="modDeptCode" readonly><br>
        기존 부서명<input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="modDeptName" id="modDeptName" readonly><br>
        수정할 부서명<input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="updateDeptName" id="updateDeptName"><br>
        
        <span id="proName-result"></span>
      	</div>
      	<div class="modal-footer">
        	<button type="submit" class="btn btn-primary">등록</button>
        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close-project">닫기</button>
        </div>
        </div>
  </div>
</div>
</form>
	
	
	
<!-- 직급수정 모달창 -->
<button id="update-PositionBtn" type="button" class="btn btn-primary"
data-bs-toggle="modal" data-bs-target="#UpdatePositionModal" style="display: none;">직급 수정</button> 

<form action="<%=request.getContextPath() %>/admin/updatePositionName.do" method="post" id="update_PositionName_frm" onsubmit="return update_positionName(this);">
<div class="modal fade" id="UpdatePositionModal" tabindex="-1" aria-labelledby="#UpdatePositionModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
      	<div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">직급명 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      	</div>
      	<div class="modal-body">
      	
        직급코드<input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="modPositionCode" id="modPositionCode" readonly><br>
        기존 직급명<input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="modPositionName" id="modPositionName" readonly><br>
        수정할 직급명<input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="updatePositionName" id="updatePositionName"><br>
        
        <span id="proName-result"></span>
      	</div>
      	<div class="modal-footer">
        	<button type="submit" class="btn btn-primary">등록</button>
        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close-project">닫기</button>
        </div>
        </div>
  </div>
</div>
</form>


<!-- 부서 삭제 -->
<button id="delete-DeptBtn" type="button" class="btn btn-primary"
data-bs-toggle="modal" data-bs-target="#DeleteDeptModal" style="display: none;">부서 삭제</button> 

<form action="<%=request.getContextPath() %>/admin/deleteDept.do" method="post" id="delete_Dept_frm">
	<div class="modal fade" id="DeleteDeptModal" tabindex="-1" aria-labelledby="#DeleteDeptModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">정말 삭제하시겠습니까?</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        
	        삭제할 부서코드 <input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="deleteDeptCode" id="deleteDeptCode" readonly>
	        삭제할 부서명 <input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="deleteDeptName" id="deleteDeptName" readonly>
	      
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-primary">예</button>
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
	      </div>
	    </div>
	  </div>
	</div>
</form>



<!-- 직급 삭제 -->
<button id="delete-PositionBtn" type="button" class="btn btn-primary"
data-bs-toggle="modal" data-bs-target="#DeletePositionModal" style="display: none;">직급 삭제</button> 

<form action="<%=request.getContextPath() %>/admin/deletePosition.do" method="post" id="delete_Position_frm">
	<div class="modal fade" id="DeletePositionModal" tabindex="-1" aria-labelledby="#DeletePositionModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">정말 삭제하시겠습니까?</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        
	        삭제할 직급코드 <input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="deletePositionCode" id="deletePositionCode" readonly>
	        삭제할 직급명 <input class="form-control form-control-m" type="text" aria-label=".form-control-lg example" name="deletePositionName" id="deletePositionName" readonly>
	      
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-primary">예</button>
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
	      </div>
	    </div>
	  </div>
	</div>
</form>

</main>


<script>
$(document).ready(()=>{
	adminDeptList();
});

//부서관리 페이지
function adminDeptList(){
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/deptAllListEnd.do",
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
					let deptCode = $("<td>").html(data[i]["deptCode"]);
					let inputDeptCode = $('<input>').attr({type:"hidden",name:"deptCode",id:"deptCode",value:data[i]["deptCode"]});
					deptCode.append(inputDeptCode);
					let deptName = $("<td>").html(data[i]["deptName"]);
					let inputDeptName = $('<input>').attr({type:"hidden",name:"deptName",id:"deptName",value:data[i]["deptName"]});
					deptName.append(inputDeptName);
					let updateDept = $("<td>").html("<button>수정");
					updateDept.children('button').attr("id","updateDept"+i);
					updateDept.children('button').attr("onclick","updateDept(this);");
					let deleteDept = $("<td>").html("<button>삭제");
					deleteDept.children('button').attr("id","deleteDept"+i);
					deleteDept.children('button').attr("onclick","deleteDept(this);");
					table.append(tbody);
					tbody.append(tr2);
					tr2.append(deptCode).append(deptName).append(updateDept).append(deleteDept);
				}
				
			}
			$("#ajaxTable").html(table);
		}
	});
};


//부서수정
const updateDept=(e)=>{
	   var deptCode = e.parentElement.parentElement.children[0].children[0].value;
	   $("#modDeptCode").val(deptCode);
	   var deptName = e.parentElement.parentElement.children[1].children[0].value;
	   $("#modDeptName").val(deptName);
	   $("#update-DeptBtn").click();
};


//부서삭제
const deleteDept=(e)=>{
	   var deptCode = e.parentElement.parentElement.children[0].children[0].value;
	   $("#deleteDeptCode").val(deptCode);
	   var deptName = e.parentElement.parentElement.children[1].children[0].value;
	   $("#deleteDeptName").val(deptName);
	   $("#delete-DeptBtn").click();
};




//직급관리 페이지
function adminPositionList(){
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/positionAllListEnd.do",
		type:'post',
		dataType : 'json',
		success:data=>{
			const table=$('<table>');
			let thead=$("<thead>");
			let tbody=$('<tbody>');
			let tr=$("<tr>");
			let th1=$("<th>").html("직급코드");
			let th2=$("<th>").html("직급명");
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
					let positionCode = $("<td>").html(data[i]["positionCode"]);
					let inputPositionCode = $('<input>').attr({type:"hidden",name:"positionCode",id:"positionCode",value:data[i]["positionCode"]});
					positionCode.append(inputPositionCode);
					let positionName = $("<td>").html(data[i]["positionName"]);
					let inputPositionName = $('<input>').attr({type:"hidden",name:"positionName",id:"positionName",value:data[i]["positionName"]});
					positionName.append(inputPositionName);
					let updatPosition = $("<td>").html("<button>수정");
					updatPosition.children('button').attr("id","updatPosition"+i);
					updatPosition.children('button').attr("onclick","updatPosition(this);");
					let deletePosition = $("<td>").html("<button>삭제");
					deletePosition.children('button').attr("id","deletePosition"+i);
					deletePosition.children('button').attr("onclick","deletePosition(this);");
					table.append(tbody);
					tbody.append(tr2);
					tr2.append(positionCode).append(positionName).append(updatPosition).append(deletePosition);
				}
				
			}
			$("#ajaxTable").html(table);
		}
	});
};


//직급수정
const updatPosition=(e)=>{
	   var positionCode = e.parentElement.parentElement.children[0].children[0].value;
	   $("#modPositionCode").val(positionCode);
	   var positionName = e.parentElement.parentElement.children[1].children[0].value;
	   $("#modPositionName").val(positionName);
	   $("#update-PositionBtn").click();
};



//직급삭제
const deletePosition=(e)=>{
	   var positionCode = e.parentElement.parentElement.children[0].children[0].value;
	   $("#deletePositionCode").val(positionCode);
	   var positionName = e.parentElement.parentElement.children[1].children[0].value;
	   $("#deletePositionName").val(positionName);
	   $("#delete-PositionBtn").click();
	   console.log($(".modal-body").html());
};


//부서수정 부서명 반드시 입력
const update_deptName=()=>{
    if($("#updateDeptName").val().trim().length == 0){
       $("#updateDeptName").focus();
       return false;
    }     
 };
 
 
 
//직급수정 직급명 반드시 입력
const update_positionName=()=>{
    if($("#updatePositionName").val().trim().length == 0){
       $("#updatePositionName").focus();
       return false;
    }     
 };

</script>



<%@ include file="/views/common/footer.jsp"%>
