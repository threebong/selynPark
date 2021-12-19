<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.help.work.model.vo.Work"%>
<%@page import="com.help.project.model.vo.Project"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<%
//로그인한 아이디가 속한 프로젝트들 	
List<Project> project = (List<Project>) request.getAttribute("logProject");
//최신 게시글 5개만가져옴
HashMap<Integer,List<Work>> works=(HashMap<Integer,List<Work>>)request.getAttribute("workInPro");
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
									<li><a class="dropdown-item" href="#">내 업무</a></li>
									<li><a class="dropdown-item" href="#">전체 업무</a></li>
								</ul></li>
						</ul>
					</form>

				</div>
			</div>
		</nav>

		<div>
			<div class="input-group mb-3 opSearch">
				<select class="form-select " id="working" name="search-work-op">
					<option selected>진행 상황</option>
					<option value="request">요청</option>
					<option value="ing">진행</option>
					<option value="feedback">피드백</option>
					<option value="done">완료</option>
					<option value="hold">보류</option>
				</select> <label class="input-group-text" for="inputGroupSelect02">검색조건1</label>

				<select class="form-select " id="priority" name="search-work-op">
					<option selected>우선순위</option>
					<option value="1">긴급</option>
					<option value="2">높음</option>
					<option value="3">보통</option>
					<option value="4">낮음</option>
				</select> <label class="input-group-text" for="inputGroupSelect02">검색조건2</label>

			</div>
		</div>

		<!-- 출력란 -->
		<div>
		<% for(Project p:project){%>
			<div>
				<table class="table">
					<h4><%=p.getProName() %>
					</h4>
					<thead>
						<tr>
							<th scope="col">No</th>
							<th scope="col">상태</th>
							<th scope="col">우선순위</th>
							<th scope="col">제목</th>
							<th scope="col">담당자</th>
							<th scope="col">등록일?수정일?</th>
						</tr>
					</thead>
					<tbody>
					<%for (Entry<Integer, List<Work>> entry: works.entrySet()){
						if(entry.getKey()==p.getProjectNo()){
							for(Work w: entry.getValue()){
						%>
						<tr>
							<th scope="row"><%=w.getWorkNo() %></th>
							<td><%=w.getWorkIng() %></td>
							<td><%=w.getWorkRank() %></td>
							<td><%=w.getWorkTitle() %></td>
							<td><%=w.getMemberId() %></td>
							<td><%=w.getWorkDate() %></td>
						</tr>
					<%} }}%>
					</tbody>
				</table>


			</div>
			<%} %>
		</div>




	</div>


	<script>
		
	</script>

</main>
<%@ include file="/views/common/footer.jsp"%>