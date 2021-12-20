<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.help.project.work.model.vo.Work"%>
<%@page import="com.help.project.model.vo.Project"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<%
//로그인한 아이디가 속한 프로젝트들 	
List<Project> project = (List<Project>) request.getAttribute("logProject");



//최신 게시글 5개만가져옴
HashMap<Integer, List<Work>> works = (HashMap<Integer, List<Work>>) request.getAttribute("workInPro");
%>
<style>
.opSearch {
	width: 500px;
}
</style>
<main>
	<div>
		<h3>전체 업무</h3>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<div class="container-fluid">
				<a class="navbar-brand" href="#">전체 업무</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNavDarkDropdown"
					aria-controls="navbarNavDarkDropdown" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
					<form id="" name="" method="post">
						<input type="hidden" name="selectedWork" id="selectedWork"
							value="$(selectedWork)" />
						<ul class="navbar-nav">
							<li class="nav-item dropdown"><a
								class="nav-link dropdown-toggle" href="#"
								id="navbarDarkDropdownMenuLink" role="button"
								data-bs-toggle="dropdown" aria-expanded="false"> 업무 선택 </a>
								<ul class="dropdown-menu dropdown-menu-dark"
									aria-labelledby="navbarDarkDropdownMenuLink">
									<li><a class="dropdown-item" id="mywork">내 업무</a></li>
									<li><a class="dropdown-item" id="allwork">전체
											업무</a></li>
								</ul></li>
						</ul>
					</form>

				</div>
			</div>
		</nav>

		<div>
			<div class="input-group mb-3 opSearch">
				<select class="form-select " id="working" name="working">
					<option selected>진행 상황</option>
					<option value="요청">요청</option>
					<option value="진행">진행</option>
					<option value="피드백">피드백</option>
					<option value="완료">완료</option>
					<option value="보류">보류</option>
				</select> <label class="input-group-text" for="inputGroupSelect02">검색조건1</label>

				<select class="form-select " id="priority" name="priority">
					<option selected>우선순위</option>
					<option value="긴급">긴급</option>
					<option value="높음">높음</option>
					<option value="보통">보통</option>
					<option value="낮음">낮음</option>
				</select> <label class="input-group-text" for="inputGroupSelect02">검색조건2</label>
				<button id="filterWork">검색</button>
			</div>
		</div>

		<!-- 출력란 -->
		<div id="deleteTable">
			<%
			for (Project p : project) {
			%>
			<div>
				<table class="table">
					<h4><%=p.getProName()%>
					</h4>
					<thead>
						<tr>
							<th scope="col">No</th>
							<th scope="col">상태</th>
							<th scope="col">우선순위</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일?수정일?</th>
						</tr>
					</thead>
					<tbody >
						<%
						for (Entry<Integer, List<Work>> entry : works.entrySet()) {
							if (entry.getKey() == p.getProjectNo()) {
								for (Work w : entry.getValue()) {
						%>
						<tr>
							<th scope="row"><%=w.getWorkNo()%></th>
							<td><%=w.getWorkIng()%></td>
							<td><%=w.getWorkRank()%></td>
							<td><%=w.getWorkTitle()%></td>
							<td><%=w.getMemberId()%></td>
							<td><%=w.getWorkDate()%></td>
						</tr>
						<%
						}
						}
						}
						%>
					</tbody>
				</table>


			</div>
			<%
			}
			%>
		</div>
		
		
		<div id="writeTable">
		</div>

	


	</div>


	<script>
		//const allWork=()=>{//전체업무 조회하기 
			$(document).on('click','#mywork',function(){
			//$("#deleteTable").remove();//비워줘
			const logId="<%=loginMember.getMemberId()%>";
					$("#deleteTable").hide();
					$("#writeTable").show();	
			$.ajax({
				url : "<%=request.getContextPath()%>/work/SelectWorkManagerViewServlet.do",
				type : 'post',
				data: {"logId":logId},
				dataType : 'json',
				success : data=>{
					console.log(data);
					console.log(data.length);
					console.log(data[0]);
					console.log(data[0]["projectNo"]);
					let str="";
					
					
					let table=$("<table>");
					let h4=$("<h4>").html("나의 업무");
					let thead=$("<thead>");
					let tr=$("<tr>");
					let td=$("<th>").html("No");
					let td8=$("<th>").html("프로젝트");
					let td9=$("<th>").html("업무No");
					let td1=$("<th>").html("상태");
					let td2=$("<th>").html("우선순위");
					let td3=$("<th>").html("제목");
					let td4=$("<th>").html("작성자");
					let td5=$("<th>").html("담당자");
					let td6=$("<th>").html("등록일");
					table.append(h4).append(thead).append(tr).append(td).append(td8).append(td9).append(td1).append(td2).append(td3).append(td4).append(td5).append(td6);
					
					let tbody=$("<tbody>");
					for(let i=0;i<data.length;i++){
					let tr2=$("<tr>");
					let proNo=$("<th>").html(data[i]["projectNo"]);
					let proName=$("<td>").html(data[i]["proName"]);
					let workNo=$("<td>").html(data[i]["workNo"]);
					let working=$("<td>").html(data[i]["workIng"]);
					let rank=$("<td>").html(data[i]["workRank"]);
					let title=$("<td>").html(data[i]["workTitle"]);
					let memId=$("<td>").html(data[i]["memberId"]);
					let manaId=$("<td>").html(data[i]["managerId"]);
					let date=$("<td>").html(data[i]["workDate"]);
					let td7=$("<td>");
				    tbody.append(tr2).append(proNo).append(proName).append(workNo).append(working).append(rank).append(title).append(memId).append(manaId).append(date).append(td7);
				    table.append(tbody);
					}
					$("#writeTable").html(table);
					
					
					/*속성추가*/
					$("table").addClass('table');
					$("table thead th").attr('scope','col');
					$("table tbody th").attr('scope','col');
				
				}
			});//id값 보내
			
			
			
			
		});
		
		
		$(document).on('click','#allwork',function(){
			
			$("#deleteTable").show();
			$("#writeTable").hide();	
		});
	
		
		//검색조건 
		$("#filterWork").click(e=>{
			let ing=$("#working").val();
			console.log(ing);
			
			let prior=$("#priority").val();
			console.log(prior);
			
			let h4=$("table h4").text();
			console.log(h4);
			
			$.ajax({
				url: "<%=request.getContextPath()%>/work/SelectWorkManagerSearchServlet.do",
				type : 'post',
				data: {"ing":ing, "prior":prior},
				dataType : 'json',
				success : data=>{   
					alert("성공");
				
				}
			
			
			});
			
			
		});
	
	</script>

</main>
<%@ include file="/views/common/footer.jsp"%>