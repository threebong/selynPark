<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<main>
	<style>
.selecOp {
	width: 400px;
}
</style>
	<div>
		<h1>북마크</h1>
	</div>

	<div>
		<div class="input-group mb-3 selecOp">
			<select name="search-project-op">
				<option value="projectName">프로젝트 이름</option>
				<option value="">제목</option>
				<option value="">작성자</option>
				<option value="">날짜</option>
			</select>
			 <input type="text" class="form-control"
				aria-label="Recipient's username" aria-describedby="button-addon2">
			<button class="btn btn-outline-secondary" type="button"
				id="button-addon2">
				<i class="fas fa-search"></i>
			</button>
		</div>
	</div>

	<div>
	<select class="form-select selecOp" aria-label="Default select example">
  <option selected>Open this select menu</option>
  <option value="1">One</option>
  <option value="2">Two</option>
  <option value="3">Three</option>
</select>
	</div>

	<script>
		
	</script>

</main>

<%@ include file="/views/common/footer.jsp"%>