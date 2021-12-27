<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.help.project.work.model.vo.Work"%>
<%@page import="com.help.project.model.vo.Project"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet"> <!-- 테이블내용폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet"> 

<%
//로그인한 아이디가 속한 프로젝트들 	
List<Project> project = (List<Project>) request.getAttribute("logProject");



//최신 게시글 5개만가져옴
HashMap<Integer, List<Work>> works = (HashMap<Integer, List<Work>>) request.getAttribute("workInPro");
%>
<style>
	.opSearch {
		width: 600px;
		font-family: 'Jua';
	}
	
	.table tr { /* 글 목록 누르면 상세페이지 */
		cursor: pointer;
	}
	.main-container{
		margin: 40px;
	}
	.container-fluid,.navbar-brand{
		font-family: 'Jua';
		font-size:25px;
	}
	#filterWork{
		background-color:rgba(249, 232, 6, 0.82);
		border-radius: 7px 7px;
	}
	#filterWork:hover{
		background-color:rgba(119, 140, 233, 0.94);
		transition:background-color 0.9s;
		border-radius: 7px 7px;
	}
	
	#deleteTable{/*전체 내용물 */
		display:flex;
		flex-direction:column;
		justify-content: center;
		align-item:center;
		margin:35px;
	}
	.table{/*테이블 내용 */ 
		font-family: 'Do Hyeon';
		text-align:center;
	}
	.tableDefault{/*테이블 프로젝트이름*/
		font-family: 'Jua';
		background-color:rgba(113, 106, 210, 0.4);
		font-size:40px;
		margin:15px;
		padding:6px;
		width:400px;
		display:table-cell;
		vertical-align:middle;
		border-radius: 3px 3px;
		text-align:center;
		height:40px;
	}
	.tableDefault-a{
		display:flex;
		text-align:center;
		
	}
	.projectTitle{
		margin:0px;
		color:#503979;
	}
	#deleteTable-con{
		margin:20px;
	}
	.tableWork{/*테이블내용 */
		background-color:rgba(183, 191, 225,0.2);
		border-radius: 15px 15px;
	}
	.myWorkTitle{/*나의업무*/
		background-color
	}
	.searchMyWork{/*s나의 업무 조회*/
		background-color:rgba(223, 182, 246, 0.55);
		border-radius: 15px 15px;
	}
	.searchAllWork{/*전체업무*/
		background-color:rgba(169, 160, 243, 0.49);
		border-radius: 15px 15px;
	}
	#pageBar{
		
		color:#02081d;
	}
	.workTitle:hover {/*전체업무 제목 */
		color:rgba(173, 46, 99, 0.83);
	}
	.workTitlem:hover{/*나의 업무 제목*/
		color:rgba(47, 139, 24, 0.83);
	}
	.tableSearch{/*조회테이블 폰트*/
		font-size:17px;
	}
	/*상세화면*/
	#WorkTitle_All_View{
		font-size:30px;
	}
	.offcanvas{/*오픈캔버스*/
		padding:40px;
		background-color:rgba(0, 0, 0, 0.28);
		font-family: 'Jua';
	}
	.btn-close{
		background-color:rgba(216, 146, 198, 0.7);
	}
	
	#ProjectName_All_View{
		/*background-color:rgba(106, 110, 160, 1);*/
		border-radius: 5px 5px;
		padding:3px;
		color:white;
		font-weight:400;
	
	}
	#WorkNo_All_View{
		/*background-color:#f2787e;*/
		border-radius: 7px 7px;
		padding:3px;
		margin:0px;
		color:rgba(226, 192, 226, 0.94);
	}
	#WorkTitle_All_View{
		background-color:rgba(66, 69, 103, 1);
		border-radius: 15px 15px;
		margin:10px;
		padding:5px;
		color:rgba(221, 222, 233, 1);
	
	}
	.offcanvas-body{
		background-color:rgba(223, 224, 241, 1);
		border-radius: 20px 20px;
		margin:10px;
	
	}
	
	/*상세화면 본문*/
	#WorkWriter_All_View{
		color:rgba(88, 109, 132, 1);
	}
	#WorkManager_All_View{
		color:rgba(86, 70, 149, 1);
	}
	.DayView{
		text-align:right;
	}
	#StartDay_All_View{
		color:rgba(35, 43, 52, 1);
	}
	#EndDay_All_View{
		color:rgba(235, 36, 46, 1);
	}
	.WorkStateView{
		text-align:right;
		margin:9px;
	}
	#Working_All_View{
		border:2px solid rgba(11, 92, 177, 0.86);
		padding:5px;
		border-radius:20px 20px;
	}
	#WorkRank_All_View{
		border:2px solid rgba(165, 59, 121, 0.86);
		padding:5px;
		border-radius:20px 20px;
	}
	#WorkContent_All_View{
		border-top:2px solid rgba(186, 178, 245, 1);
	}
	.WorkConView{
		background-color:rgba(247, 246, 254, 1);
		margin:4px;
		padding:8px;
		height:500px;
		border-radius:10px 10px;
	}
</style>


<main>
	<div>
		<div>
			<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
				<div class="container-fluid">
					<a class="navbar-brand" href="#">업무</a>
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
										<li><a class="dropdown-item" id="mywork"
											onclick="myWorkPaging();">내 업무</a></li>
										<li><a class="dropdown-item" id="allwork"
											onclick="workAllPaging();">전체 업무</a></li>
									</ul></li>
							</ul>
						</form>

					</div>
				</div>
			</nav>
			<div class="main-container">
				<div>
					<div class="input-group mb-3 opSearch" id="searchOption">
						<select class="form-select " id="working" name="working">
							<option selected>진행 상황</option>
							<option value="요청">요청</option>
							<option value="진행">진행</option>
							<option value="피드백">피드백</option>
							<option value="완료">완료</option>
							<option value="보류">보류</option>
						</select> <label class="input-group-text" for="inputGroupSelect02">진행상황</label>

						<select class="form-select " id="priority" name="priority">
							<option selected>우선순위</option>
							<option value="긴급">긴급</option>
							<option value="높음">높음</option>
							<option value="보통">보통</option>
							<option value="낮음">낮음</option>
						</select> <label class="input-group-text" for="inputGroupSelect02">우선순위</label>
						<button id="filterWork" onclick="workMinePaging();"
							style="display: none;">검색</button>
						<button id="filterWorkAll" onclick="workSearchPaging();"
							style="display: none;">검색</button>
					</div>
				</div>

				<!-- default -->
				<div id="deleteTable">
							<%
							for (Project p : project) {
							%>
					<div id="deleteTable-con">
						<table class="table tableWork">
							<div class="tableDefault-a"><div class="tableDefault" ><h4 class="projectTitle"><%=p.getProName()%><h4></div></div>
							
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col">상태</th>
									<th scope="col">우선순위</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
							<tbody>
								<%
						for (Entry<Integer, List<Work>> entry : works.entrySet()) {
							if (entry.getKey() == p.getProjectNo()) {
								for (Work w : entry.getValue()) {
										%>
								<tr>
									<th scope="row"><%=w.getWorkNo()%></th>
									<td><%=w.getWorkIng()%></td>
									<td><%=w.getWorkRank()%></td>
									<td><%=w.getWorkTitle()%></td>
									<td><%=w.getMemberId()%></td>
									<td><%=w.getWorkDate()%></td>
								</tr>
										<%
										}
										}
										}
										%>
							</tbody>
						</table>
						
					</div>
										<%
										}
										%>
				</div>

				<!--ajax로 테이블 변경할 구역-->
				<div id="writeTable"></div>
				<!-- 나의 전체 업무 조회 -->



				<button class="btn btn-primary" type="button" id="AllWorkViewBtn"
					style="display: none;" data-bs-toggle="offcanvas"
					data-bs-target="#AllWorkContentView"
					aria-controls="offcanvasScrolling">업무 글 상세화면</button>
					
				<div class="offcanvas offcanvas-end" style="width: 40%;"
					data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1"
					id="AllWorkContentView" aria-labelledby="offcanvasScrollingLabel">
						<div class="offcanvas-header">
							<button type="button" class="btn-close text-reset"
								data-bs-dismiss="offcanvas" aria-label="Close"></button>
						</div>
						
						<div class="offcanvas-title"
							style="border-bottom: 3px solid lightgray">
							<span id="ProjectName_All_View" style="font-size: 23px; "></span> 
							<span id="WorkNo_All_View" style="font-size: 15px;  margin-left: 10px;"></span>
							<div id="WorkTitle_All_View" style="margin-top: 20px;"></div>
						</div>

						<div class="offcanvas-body" id="contentBody">
							<div id="WorkWriter_All_View"></div>
							<div id="WorkManager_All_View"></div>
							<div class="DayView">
								<span id="StartDay_All_View"></span> <span id="EndDay_All_View"></span>
							</div>
							<div class="WorkStateView">
								<span id="Working_All_View"></span> <span id="WorkRank_All_View"></span>
							</div>
							<div class="WorkConView">
								<div id="WorkContent_All_View"></div>
							</div>
						</div>
				</div>

			</div>

		</div>
	</div>
	<script>
	window.onload=function(){
		$("#searchOption").hide();
		
	}
	
	//All Work -->내 업무 (전체 조회)
	function myWorkPaging(cPage){
			const logId="<%=loginMember.getMemberId()%>";
			$("#deleteTable").hide();
			$("#writeTable").show();	
			$("#filterWorkAll").hide();
			$("#filterWork").show();
			$("#searchOption").show();
			$.ajax({
				url : "<%=request.getContextPath()%>/work/SelectWorkManagerViewServlet.do",
				type : 'post',
				data: {"logId":logId, "cPage":cPage },
				dataType : 'json',
				success : data=>{
					const workList=data["list"];
					const pageBar=data["pageBar"];
					
					let table=$("<table>");
					
					let h4=$("<h4>").html("나의 업무");
					let tr=$("<tr>");
					let td=$("<th>").html("No");
					let td8=$("<th>").html("프로젝트");
					let td9=$("<th>").html("업무No");
					let td1=$("<th>").html("상태");
					let td2=$("<th>").html("우선순위");
					let td3=$("<th>").html("제목");
					let td4=$("<th>").html("작성자");
					let td5=$("<th>").html("담당자");
					let td6=$("<th>").html("등록일");
					tr.append(td).append(td8).append(td9).append(td1).append(td2).append(td3).append(td4).append(td5).append(td6);
					
					table.append(h4);
					table.append(tr);
					//let tbody=$("<tbody>");
					for(let i=0;i<workList.length;i++){
						let tr2=$("<tr scope='row' onclick='contentView(this);'>").addClass('tableSearch');//상세페이지하는중 
						let proNo=$("<td>").html(workList[i]["projectNo"]);
						let proName=$("<td>").html(workList[i]["proName"]);
						let workNo=$("<td>").html(workList[i]["workNo"]);
						let working=$("<td>").html(workList[i]["workIng"]);
						let rank=$("<td>").html(workList[i]["workRank"]);
						let title=$("<td>").addClass('workTitlem').html(workList[i]["workTitle"]);
						let memId=$("<td>").html(workList[i]["memberId"]);
						let manaId=$("<td>").html(workList[i]["managerId"]);
						let date=$("<td>").html(workList[i]["workDate"]);
					    tr2.append(proNo).append(proName).append(workNo).append(working).append(rank).append(title).append(memId).append(manaId).append(date);
					    table.append(tr2);
					}
					
					const div=$("<div>").attr("id","pageBar").html(pageBar);
					table.append(div);
					
					$("#writeTable").html(table);
					
					/*속성추가*/
					$("table").addClass('table');
					$("table").addClass('searchMyWork');
					$("th").attr("scope","col");
					$("h4").addClass('myWorkTitle');
					
				//	$("table thead th").attr('scope','col');
				//	$("table tbody th").attr('scope','col');
				}
			});//id값 보내
	 		}
	//	});
		
		
		////All Work -->내 업무 (전체 조회)-->글제목 누르면 상세화면 ** (오프캔버스)
 function contentView(e){
	let val = $(e).children();//이벤트발생한곳의 자식들
	let proNo = val.eq(0).text();//project No 가져와
	let workNo= val.eq(2).text();//workNo 가져와
	console.log("버튼을 누르면:" + proNo+workNo)
	$.ajax({
		url:"<%=request.getContextPath()%>/project/SelectDetailWorkViewServlet.do",
		type: "post",
		data : {"proNo":proNo,"workNo":workNo },
		dataType: "json",
		success: data => {
			let proName=data["proName"];
			let proDate=data["proDate"];
			let workTitle=data["workTitle"];
			let workContent=data["workContent"];
			let startDate=data["startDate"];
			let endDate=data["endDate"];
			let workIng=data["workIng"];
			let workRank=data["workRank"];
			let workName=data["workName"];
			let workManager=data["workManager"];//배열임 
			console.log(proName+proDate+workTitle+workContent+startDate+workIng+workRank+workName+workManager);
			console.log(data["workManager"][0]);
			
	   		
	   		
			$("#ProjectName_All_View").html(data["proName"]);//프로젝트 이름
			$("#WorkNo_All_View").html("No."+data["workNo"]);//업무 번호
			$("#WorkTitle_All_View").html(data["workTitle"]);//업무제목
			$("#WorkWriter_All_View").html("[글쓴이]   "+data["workName"]);//업무작성자
			$("#WorkManager_All_View").html("[담당자]    ");
			for(let i=0;i<data["workManager"].length;i++){//업무담당자
				let span=$("<span>");
				span.html(data["workManager"][i]+" ");
				$("#WorkManager_All_View").append(span);
			}
			$("#StartDay_All_View").html(data["startDate"]+" ~ ");//기간 시작
			$("#EndDay_All_View").html(data["endDate"]);//기간마감
			$("#Working_All_View").html(data["workIng"]);//업무 상태
			$("#WorkRank_All_View").html(data["workRank"]);//업무우선순위
			$("#WorkContent_All_View").html(data["workContent"]);//업무내용
			
			$("#AllWorkViewBtn").click();
		}
	});
		
		
	}		 
	
		//All Work --> 나의 업무 --> 검색1/2 
		//본인 업무 조회 (조건 선택 )  --- 페이징 
	function workMinePaging(cPage){//==>본인업무 조건 선택 : 페이징 완료 
		let ing=$("#working").val();//진행상황
		let prior=$("#priority").val();//우선순위
		let h4=$("table h4").text();//나의 업무
		const logId="<%=loginMember.getMemberId()%>";
		
		
		$.ajax({
			url: "<%=request.getContextPath()%>/work/SelectWorkManagerSearchServlet.do",
			type : 'post',
			data: {"ing":ing, "prior":prior, "h4":h4 , "logId":logId, "cPage":cPage},
			dataType : 'json',
			success : data=>{   
				const workList=data["list"];
				const pageBar=data["pageBar"];
				console.log(workList);
				let h4=$("<h4>").html("나의 업무");//'나의업무'문구 변경 금지 (다중조회와 관련)
				let table=$("<table>");
				let tr=$("<tr>");
				let td=$("<th>").html("No");
				let td8=$("<th>").html("프로젝트");
				let td9=$("<th>").html("업무No");
				let td1=$("<th>").html("상태");
				let td2=$("<th>").html("우선순위");
				let td3=$("<th>").html("제목");
				let td4=$("<th>").html("작성자");
				let td5=$("<th>").html("담당자");
				let td6=$("<th>").html("등록일");
				tr.append(td).append(td8).append(td9).append(td1).append(td2).append(td3).append(td4).append(td5).append(td6);
				table.append(h4);
				table.append(tr);
				
				if(data.workList==0){//조회결과 X 
					let nottr=$("<tr>");
					let notth=$("<td>").html("조회결과가 없습니다.");
					nottr.append(notth);
					table.append(nottr);
					
					notth.attr("colspan","9");
					nottr.css("text-align","center");
				}else{//조회 결과 O 
					alert("결과가있단다");
					for(let i=0;i<workList.length;i++){
					let tr2=$("<tr scope='row' onclick='contentView(this);'>").addClass('tableSearch');
					let proNo=$("<td>").html(workList[i]["projectNo"]);
					let proName=$("<td>").html(workList[i]["proName"]);
					let workNo=$("<td>").html(workList[i]["workNo"]);
					let working=$("<td>").html(workList[i]["workIng"]);
					let rank=$("<td>").html(workList[i]["workRank"]);
					let title=$("<td>").addClass('workTitlem').html(workList[i]["workTitle"]);
					let memId=$("<td>").html(workList[i]["memberId"]);
					let manaId=$("<td>").html(workList[i]["managerId"]);
					let date=$("<td>").html(workList[i]["workDate"]);
					let td7=$("<td>");
				    tr2.append(proNo).append(proName).append(workNo).append(working).append(rank).append(title).append(memId).append(manaId).append(date).append(td7);
				    
				    table.append(tr2);
					}
				}
				const div=$("<div>").attr("id","pageBar").html(pageBar);
				table.append(div);
				
				$("#writeTable").html(table);
				
					
				/*속성추가*/
				$("table").addClass('table searchMyWork');
				$("table th").attr('scope','col');
			}
		});
		}
	
	//All work ->전체업무 
	function workAllPaging(cPage){//전체업무조회 (내가 참여한 프로젝트의) 리스트 페이징처리까지 완료 
	$("#deleteTable").hide();//default테이블 
	$("#writeTable").show();//새로 보여줄 테이블	
	$("#filterWorkAll").show();
	$("#filterWork").hide();
	$("#searchOption").show();
	
	const logId="<%=loginMember.getMemberId()%>";//로그인한 아이디
	 	$.ajax({
			url : "<%=request.getContextPath()%>/work/SelectWorkAllViewServlet.do",
			type : 'post',
			data: {"logId":logId,"cPage":cPage},
			dataType : 'json',
			success : data=>{
				const workList=data["list"];
				const pageBar=data["pageBar"];
				
				let table=$("<table>");
				let h4=$("<h4>").html("전체 업무");//내가 참여한 모든 프로젝트의 업무 //이름바꾸면안됨
				let tr=$("<tr>");
				let td=$("<th>").html("No");
				let td8=$("<th>").html("프로젝트");
				let td9=$("<th>").html("업무No");
				let td1=$("<th>").html("상태");
				let td2=$("<th>").html("우선순위");
				let td3=$("<th>").html("제목");
				let td4=$("<th>").html("작성자");
				let td6=$("<th>").html("등록일");
				tr.append(td).append(td8).append(td9).append(td1).append(td2).append(td3).append(td4).append(td6);
				table.append(h4);
				table.append(tr);
				
				for(let i=0;i<workList.length;i++){
				let tr2=$("<tr scope='row' onclick='contentView(this);'>").addClass('tableSearch');
				let proNo=$("<td>").html(workList[i]["projectNo"]);
				let proName=$("<td>").html(workList[i]["proName"]);
				let workNo=$("<td>").html(workList[i]["workNo"]);
				let working=$("<td>").html(workList[i]["workIng"]);
				let rank=$("<td>").html(workList[i]["workRank"]);
				let title=$("<td>").addClass('workTitle').html(workList[i]["workTitle"]);
				let memId=$("<td>").html(workList[i]["memberId"]);
				let date=$("<td>").html(workList[i]["workDate"]);
			    tr2.append(proNo).append(proName).append(workNo).append(working).append(rank).append(title).append(memId).append(date);
			    table.append(tr2);
				}
				
				//페이징처리---
				const div=$("<div>").attr("id","pageBar").html(pageBar);
				//$("#container").append(table).append(div);
				table.append(div);
				
				$("#writeTable").html(table);
				/*속성추가*/
				$("table").addClass('table paginated searchAllWork');
				$("table thead th").attr('scope','col');
				$("table tbody th").attr('scope','col');
			}
		});//id값 보내
	}
	
//All Work -> 전체업무 -> 검색조건1/2
	function workSearchPaging(cPage){
		let ing=$("#working").val();//진행상황
		let prior=$("#priority").val();//우선순위
		let h4=$("table h4").text();// 전체업무
		const logId="<%=loginMember.getMemberId()%>";
			$.ajax({
				url: "<%=request.getContextPath()%>/work/SelectWorkAllSearchServlet.do",
				type : 'post',
				data: {"ing":ing, "prior":prior, "h4":h4 , "logId":logId, "cPage":cPage},
				dataType : 'json',
				success : data=>{   
					
					const workList=data["list"];
					const pageBar=data["pageBar"];
					
					let table=$("<table>");
					let h14=$("<h4>").html("전체 업무");//문구 변경 금지 (다중조회와 관련)
					let thead=$("<thead>");
					let tr=$("<tr>");
					let td=$("<th>").html("No");
					let td8=$("<th>").html("프로젝트");
					let td9=$("<th>").html("업무No");
					let td1=$("<th>").html("상태");
					let td2=$("<th>").html("우선순위");
					let td3=$("<th>").html("제목");
					let td4=$("<th>").html("작성자");
					let td6=$("<th>").html("등록일");
					tr.append(td).append(td8).append(td9).append(td1).append(td2).append(td3).append(td4).append(td6);
					table.append(h14);
					table.append(tr);
					
					if(data.workList==0){//조회결과 X 
						let nottr=$("<tr scope='row'>");
						let notth=$("<td>").html("조회결과가 없습니다.");
						nottr.append(notth);
						table.append(nottr);
						notth.attr("colspan","9");
						nottr.css("text-align","center");
					}else{//조회 결과 O 
						for(let i=0;i<workList.length;i++){
						let tr2=$("<tr scope='row' onclick='contentView(this);'>").addClass('tableSearch');
						let proNo=$("<td>").html(workList[i]["projectNo"]);
						let proName=$("<td>").html(workList[i]["proName"]);
						let workNo=$("<td>").html(workList[i]["workNo"]);
						let working=$("<td>").html(workList[i]["workIng"]);
						let rank=$("<td>").html(workList[i]["workRank"]);
						let title=$("<td>").addClass('workTitle').html(workList[i]["workTitle"]);
						let memId=$("<td>").html(workList[i]["memberId"]);
						let date=$("<td>").html(workList[i]["workDate"]);
						let td7=$("<td>");
					    tr2.append(proNo).append(proName).append(workNo).append(working).append(rank).append(title).append(memId).append(date).append(td7);
					    table.append(tr2);
						}
					}
					
					const div=$("<div>").attr("id","pageBar").html(pageBar);
					table.append(div);
					$("#writeTable").html(table);
					
					/*속성추가*/
					$("table").addClass('table searchAllWork');
					$("table th").attr('scope','col');
				}
			});//id값 보내
		}
	//});
	
		
	
	</script>

</main>
<%@ include file="/views/common/footer.jsp"%>