<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>

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
	width: 20%;
	height: 20%;
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
			<h4>내 프로젝트</h4>
			<div class="input-group mb-3">
				<select name="search-project-op">
					<option value="projectName">프로젝트 이름</option>
					<option value="">프로젝트 생성자</option>
					<option value="">글쓴이</option>
					<option value="">업무번호</option>
					<option value="">날짜</option>
				</select> <input type="text" class="form-control"
					aria-label="Recipient's username" aria-describedby="button-addon2">
				<button class="btn btn-outline-secondary" type="button"
					id="button-addon2">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</div>


		<div id="project_favor">
			<h2>즐겨찾기</h2>
			<div>
				<!-- 	출력될공간 -->
				<%
				for (int i = 0; i < 10; i++) {
				%>

				<div class="project_content_favor">
					<h4>프로젝트명</h4>
					<h6>프로젝트 설명</h6>
					<p>프로젝트 생성자</p>
					<h6>참여인원</h6>
				</div>

				<%
				}
				%>
			</div>
		</div>


		<div class="project_ing">
			<h2>참여한 프로젝트</h2>
			<div>
				<!-- 	출력될공간 -->
				<%
				for (int i = 0; i < 22; i++) {
				%>

				<div class="project_content_ing">
					<h4>프로젝트명</h4>
					<h6>프로젝트 설명</h6>
					<p>프로젝트 생성자</p>
					<h6>참여인원</h6>
				</div>

				<%
				}
				%>
			</div>
		</div>




	</div>








</main>
<%@ include file="/views/common/footer.jsp"%>