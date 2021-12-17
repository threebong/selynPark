<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<main>

<div><h1>파일함</h1></div>
<div>
<input type="text">
<select name="search-File">
	<option value="">파일명</option>
	<option value="">프로젝트명</option>
	<option value="">확장자</option>
</select>
</div>


<!-- 파일리스트출력 -->

<div>
<table class="table table-sm">
  <thead>
    <tr>
      <th scope="col">No</th>
      <th scope="col">프로젝트명</th>
      <th scope="col">파일 이름.확장자명</th>
    </tr>
  </thead>
  <tbody>
  
    <tr>
      <th scope="row">1</th>
      <td>부자 되는 프로젝트</td>
      <td>money.txt</td>
    </tr>
  
  </tbody>
</table>
</div>



	<script>
		
	</script>

</main>

<%@ include file="/views/common/footer.jsp"%>