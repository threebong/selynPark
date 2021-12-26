<%@page import="java.util.HashMap"%>
<%@page import="com.help.project.model.vo.Project"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<%


//로그인한 사원이 참여중인 모든 프로젝트 리스트
List<Project> join=(List<Project>)request.getAttribute("joinPro");
//키값:플젝번호 밸류:참여자수
HashMap<Integer,Integer> joinNum=(HashMap<Integer,Integer>)request.getAttribute("joinNum");


%>
<style>
#wrapper-Project {
	width: 90%;
	margin: 30px 30px;
	border: 1px solid red;
	display: grid;
}

#project_favor, .project_ing {
	width: 90%;
	margin: 30px 30px;
	border: 1px solid blue;
}

.input-group {
	width: 400px;
}

.project_content_favor {
	width: 20%;
	height: 20%;
	background-color: yellow;
	float: left;
	border: 1px solid black;
	margin: 10px 10px;
}

.project_content_ing {
	width: 200px;
	height: 200px;
	background-color: #87CEEB;
	float: left;
	border: 1px solid black;
	margin: 10px 10px;
}
</style>


<main>
	<div id="wrapper-Project">
		<!-- 내프로젝트를 눌렀을때 보여지는 첫 화면  -->
		<div class="search_Project">
			<h4><%=loginMember.getMemberId()%>님의 프로젝트</h4>
			<div class="input-group mb-3">
				<select name="search-project-op">
					<option value="projectName">프로젝트 이름</option>
					<option value="">프로젝트 생성자</option>
					<option value="">프로젝트 번호</option>
					<option value="">날짜</option>
				</select> <input type="text" class="form-control"
					aria-label="Recipient's username" aria-describedby="button-addon2">
				<button class="btn btn-outline-secondary" type="button"
					id="button-addon2">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>
		<div class="project_ing">
			<h2>참여한 프로젝트</h2>
			<div>
				<!-- 	출력될공간 -->
				<%
				if(join!=null){
				for (Project p:join) {
				%>


				<div class="project_content_ing" style="cursor:pointer;"
				onclick="location.assign('<%=request.getContextPath()%>/project/selectProjectDetailViewToList.do?projectNo=<%=p.getProjectNo() %>')">
					<h4><%=p.getProjectNo() %></h4>
					<h4><%=p.getProName() %></h4>
					<h6><%=p.getProExplain() %></h6>
					<p>작성자: <%=p.getMemberId() %></p>
					
					
					<h6>참여인원 : <%=joinNum.get(p.getProjectNo()) %></h6>
					
				</div>

				<%
				}}
				%>
			</div>
		</div>
	</div>

</main>
<%@ include file="/views/common/footer.jsp"%>