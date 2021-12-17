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


<!-- 일반게시글 작성 모달 -->
<button style="display:none;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal1" id="insertNormal_">글작성</button>
<form action="" method="post" enctype="mutipart/form-data">
<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">게시물 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" name="title">
        <textarea class="form-control" placeholder="내용을 입력하세요" id="floatingTextarea2"  style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"
		  name ="proExplain"></textarea>
		  <div class="mb-3">
 		<label for="formFile" class="form-label"></label>
  		<input class="form-control" type="file" id="formFile">
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">등록</button>
      </div>
    </div>
  </div>
</div>
</form>


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
	$("#insertNormal").click(e=>{
		$("#insertNormal_").click();
		
	});
s
</script>

<%@ include file="/views/common/footer.jsp"%>