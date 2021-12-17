<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<style>
.see {
	border: 1px solid black;
}

.container {
	margin: 0;
}

.profile-img {
	width: 70px;
	height: 70px;
	border-radius: 70%;
}

.content {
	background-color: lightgray;
	margin: 30px;
	border-radius: 40px;
}
</style>
<main>
<!-- 목록으로 조회 -->
	<%
	for (int i = 0; i < 3; i++) {
	%>
	<div class="container see">
		<div class="row">
			<div class="col-md-6">
				<h1>공지사항</h1>
			</div>
			<div class="col-md-2">
				<i class="fas fa-list"></i>
			</div>
			<div class="col-md-2">
				<i class="far fa-clipboard"></i>
			</div>
		</div>


		<div class="see content">
			<div class="row">
				<div class="col-md-1">
					<img src="<%=request.getContextPath()%>/images/test/ddubi.jpg"
						class="profile-img">
				</div>
				<div class="col-md-1">관리자</div>
				<div class="col-md-2">날짜</div>
				<div class="col-md-2">게시글번호</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<h1>제목</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">글내용</div>
			</div>
			<div class="row">

				<div class="col-md-2">조회수</div>
			</div>
		</div>




	</div>
	<%
	}
	%>

	<div>


<!-- 리스트로 조회 -->
		<table class="table caption-top">
			<caption>List of users</caption>
			<thead>
				<tr>
					<th scope="col">No</th>
					<th scope="col">제목</th>
					<th scope="col">글쓴이</th>
					<th scope="col">조회수</th>
					<th scope="col">작성날짜</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (int i = 0; i < 10; i++) {
				%>
				<tr>
					<th scope="row">1</th>
					<td>여러분께 알립니다.</td>
					<td>관리자</td>
					<td>조회수</td>
					<td>2021-12-17</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<script>
		
	</script>

</main>

<%@ include file="/views/common/footer.jsp"%>>
