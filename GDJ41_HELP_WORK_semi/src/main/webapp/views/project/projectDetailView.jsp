<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<style>
.write-what{
 	background-color:lightgray;
 	border:1px solid ;
 	width:50%;
	height:60px;
	text-align:center;
}
.write-what-in{
	display:inline-block;
	margin:10x;
}
</style>
<main>
	<ul class="nav nav-tabs">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="#">홈</a></li>
		<li class="nav-item"><a class="nav-link" href="#">업무</a></li>
		<li class="nav-item"><a class="nav-link" href="#">캘린더</a></li>
		<li class="nav-item"><a class="nav-link disabled">파일</a></li>
	</ul>

	
	
	
	<div class="write-what">
		<div class="write-what-in">
			<i class="fas fa-pen-nib"></i><a><span>글</span></a>
			<i class="fas fa-clipboard-list"></i><a><span>업무</span></a>
			<i class="far fa-calendar-alt"></i><a><span>일정</span></a>
			<i class="fas fa-check-double"></i><a><span>할일</span></a>
		</div>
		<div></div>
	</div>
	



	<script>
		
	</script>

</main>

<%@ include file="/views/common/footer.jsp"%>