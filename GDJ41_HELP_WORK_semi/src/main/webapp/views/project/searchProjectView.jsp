<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<style>
.opSearch {
	width: 200px;
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
					<input type="hidden" name="selectedWork" id="selectedWork" value="$(selectedWork)"/>
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
				<select class="form-select " id="inputGroupSelect02"
					name="search-work-op">
					<option selected>업무 선택</option>
					<option value="1">내 업무</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select> <label class="input-group-text" for="inputGroupSelect02">Options</label>
			</div>
		</div>




	</div>
	
	
	<script>
		
		
	
	</script>

</main>
<%@ include file="/views/common/footer.jsp"%>