<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<style>
	#project-title,#pro-bookmark-star{
		display: inline-block;
		margin-bottom: 20px;
		font-size: 30px;
	}
	#project-title{
		margin-left: 10px;
		font-weight: bold;
	}
	#pro-bookmark-star{
		color:yellow;
	}
	
	#pro_container{
		border: 1px solid black;
		width: 100%;
		min-height:1000px;
		padding: 0px;
		margin: 0px;
		position: relative;
		
	}
	#content_section{
		border: 1px solid black;
		width: 750px;
		padding: 0px;
		margin: 0px;
		position:absolute;
		left: 20%;
		min-height: 300px;
		top:45%;
		
		
	}
	#inputContent_container{
		border: 1px solid black;
		padding-top: 40px;
		margin: 0px;
		width: 750px;
		height: 200px;		
		position:absolute;
		left: 20%;
		top:15%;
		justify-content: center;
	}
	#input-group{
		position: flex;
		justify-content: center;
	}
	#input-group div{
		display: inline-block;
		width: 180px;
		font-size: 30px;
		text-align: center;
	}
	
	#input-group a{
	text-decoration: none;
	color:black;
	}
	#input-group a:hover{
	color:grey;
	}
	
	#menu-container a{
		font-size: 25px;
		font-weight: bold;
		color: gray;
	}
	.nav-link:active {
	color:black;
	}
	.nav-link:hover{
	color:black;
	}
	.nav-item{
	margin-right: 15px;
	}
	
	#title-container{
		margin: 30px;
	}
	#menu-container{
		margin-left: 30px;
	}
</style>
<main>

<div id="title-container">
	<div id="pro-bookmark-star"><i class="fas fa-star"></i></div>
	<div id="project-title"><span>프로젝트명</span></div>
</div>
<div id="menu-container">
	<ul class="nav">
		<li class="nav-item"><a class="nav-link active" aria-current="page" href="#">홈</a></li>
		<li class="nav-item"><a class="nav-link" href="#">업무</a></li>
		<li class="nav-item"><a class="nav-link" href="#">파일</a></li>
	</ul>
</div>
	<hr style="margin-top: 5px;">
<div id="pro_container">
	<div id="inputContent_container">
		<div id="input-group">
			<div id="insertNormal"><a href="#"><span><i class="fas fa-edit"></i></span>&nbsp;글</a></div>
			<div id="insertWork"><a href="#"><span><i class="fas fa-list"></i></span>&nbsp;업무</a></div>
			<div id="insertSche"><a href="#"><span><i class="far fa-calendar"></i></span>&nbsp;일정</a></div>
			<div id="insertTodo"><a href="#"><span><i class="fas fa-check-square"></i></span>&nbsp;할일</a></div>
		</div>
	</div>
	<div id="content_section"></div>
</div>	
</main>
<script>
	
s
</script>

<%@ include file="/views/common/footer.jsp"%>