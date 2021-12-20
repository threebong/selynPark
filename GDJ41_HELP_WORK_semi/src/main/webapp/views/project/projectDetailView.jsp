<%@page import="java.util.Arrays"%>
<%@page import="com.help.project.model.vo.ProMemberJoinMember"%>
<%@page import="java.util.List"%>
<%@page import="com.help.project.model.vo.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2117f58ed9ba4b4e13a9bca2bc216232&&APIKEY&libraries=services"></script>
<%
	Project p = (Project)request.getAttribute("projectInfo");
	List<ProMemberJoinMember> pMember = (List)request.getAttribute("ProMemberJoinMember");
	
	String[] memberName = new String[pMember.size()];
	String[] managerId = new String[pMember.size()];
	
	for(int i =0; i<pMember.size();i++){
		String nameTemp = (String)pMember.get(i).getMemberName();
		String idTemp = (String)pMember.get(i).getMemberId();
		memberName[i] = nameTemp;
		managerId[i] = idTemp;
	}
%>
<script>

</script>
<link rel ="stylesheet" href="<%=request.getContextPath()%>/css/projectDetailView.css" type="text/css">
<style>
.form-select{
		width: 150px;
		
	}
	
</style>
<main>

<!-- 프로젝트정보 -->

<input type="hidden" id="memberId" value="<%=loginMember.getMemberId()%>">
<input type="hidden" id="projectNo" value="<%=p.getProjectNo()%>">

<!-- 일반게시글 작성 모달 -->
<button style="display:none;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal1" id="insertNormal_">글작성</button>
<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" onsubmit="return checkContent();">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">게시물 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" name="title">
      <span id="titleResult"></span>
        <textarea class="form-control" placeholder="내용을 입력하세요" id="normalContent" style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"></textarea>
		  <div class="mb-3">
 		<label for="formFile" class="form-label"></label>
  		<input class="form-control" type="file" id="uploadNormal" name="upfile" multiple>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close_content">닫기</button>
        <button type="button" class="btn btn-primary" id="normal_submit_Btn">등록</button>
      </div>
    </div>
  </div>
</div>

<!-- 업무게시글 작성 모달 -->
<button style="display:none;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal2" id="insertWork_">글작성</button>

<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" onsubmit="return checkWorkContent();">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">업무 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" id="workTitle">
      <span id="work_titleResult"></span>
      <div id="work_Ing_container">
      	<span><i class="fas fa-history"></i></span>
      	<input type="radio" value="요청" id="call" name="work_ing"><label for="call">요청</label>
      	<input type="radio" value="진행" id="ing" name="work_ing"><label for="ing">진행</label>
        <input type="radio" value="피드백" id="feedback" name="work_ing"><label for="feedback">피드백</label>
      	<input type="radio" value="보류" id="hold" name="work_ing"><label for="hold">보류</label>
      	<input type="radio"value="완료" id="complete" name="work_ing"><label for="complete">완료</label>
      </div>
      <div id="work_addMember_container">
      	<span><i class="fas fa-user"></i></span>
      	<div><select class="form-select" id="work_addMember">
      		
      	</select></div>
      	<div id="work_addMember_area"></div>
      </div>
      <div id="workStart_container">
      	<span><i class="fas fa-calendar-plus"></i></span>
      	<input type="date" id="workStart">
      </div>
      <div id="workEnd_container">
      	<span><i class="fas fa-calendar-check"></i></span>
      	<input type="date" id="workEnd">
      </div>
      <div id="workRank_container">
     	 <span><i class="fas fa-flag"></i></span>
      	 <input type="radio" value="보통" id="normal" name="work_rank"><label for="normal">보통</label>
      	 <input type="radio" value="낮음" id="row" name="work_rank"><label for="row">낮음</label>
      	 <input type="radio" value="긴급" id="emergency" name="work_rank"><label for="emergency">긴급</label>
      	 <input type="radio" value="높음" id="high" name="work_rank"><label for="high">높음</label>
      </div>
      
        <textarea class="form-control" placeholder="내용을 입력하세요" id="workContent" style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"></textarea>
		  <div class="mb-3">
 		<label for="formFile" class="form-label"></label>
  		<input class="form-control" type="file" id="uploadWorkfile_" name="uploadWorkfile" multiple>
		</div>
		<input type="hidden" id="memberId" value="admin">
		<input type="hidden" id="projectNo" value="3">
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close_work_content">닫기</button>
        <button type="button" class="btn btn-primary" id="work_submit_Btn">등록</button>
      </div>
    </div>
  </div>
</div>

<!-- 일정게시글 작성 모달 -->
<button style="display:none;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal3" id="insertSche_">일정작성</button>

<div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" onsubmit="return checkScheContent();">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" id="scheTitle">
      <span id="work_titleResult"></span>
      <div id="work_addMember_container">
      	<span><i class="fas fa-user"></i></span>
      	<div><select class="form-select" id="sche_addMember">
      	</select></div>
      	<div id=sche_addMember_area"></div>
      </div>
      <div id="scheStart_container">
      	<span><i class="fas fa-calendar-plus"></i></span>
      	<input type="date" id="scheStartDate">
      	<input type="time" id="scheStartTime">
      </div>
      <div id="scheEnd_container">
      	<span><i class="fas fa-calendar-check"></i></span>
      	<input type="date" id="scheEndDate">
      	<input type="time" id="scheEndTime">
      </div>
	 <div>
	  <button type="button" class="btn" id="sche_place_btn"><i class="fas fa-map-marker-alt"></i>장소검색</button>
	  <div id="searchPlace_Container" style="display:none"><input type="text" id="searchPlace_keyword" name="searchPlace_keyword_">
	  <button id="search">검색</button>
	  </div>
	 </div>
	 <div id="test" style="display:none;">
	 <div id="sche_place_container" style="width:100%;height:400px;"></div>
    </div>
    <textarea class="form-control" placeholder="내용을 입력하세요" id="workContent" style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"></textarea>
		<input type="hidden" id="memberId" value="<%=loginMember.getMemberId() %>">
		<input type="hidden" id="projectNo" value="3">
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close_sche_content">닫기</button>
        <button type="button" class="btn btn-primary" id="sche_submit_Btn">등록</button>
      </div>
    </div>
  </div>
</div>

<script>

		$("#sche_place_btn").click(e=>{
			$("#searchPlace_Container").show();
				});
		
		$("#search").click(e=>{
			let searchKeyword = $("#searchPlace_keyword").val();
			searchMap(searchKeyword);
		});
		
		const searchMap=(searchKeyword)=>{
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});
			var container = document.getElementById("sche_place_container"); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level: 4 //지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴	
		var ps = new kakao.maps.services.Places(); 
		ps.keywordSearch(searchKeyword, placesSearchCB); 
		
		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}

		// 지도에 마커를 표시하는 함수입니다
		
		function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
    });
}
		

		function relayout() {    
		    
		    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
		    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
		    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
		    map.relayout();
		}
			$("#test").show(e=>{
				relayout();
			});
		}
		
		
</script>	


<div id="title-container">
	<div id="pro-bookmark-star"><i class="fas fa-star"></i></div>
	<div id="project-title"><span><%=p.getProName() %></span></div>
</div>
<div id="menu-container">
	<ul class="nav">
		<li class="nav-item"><a class="nav-link active" aria-current="page" href="#">홈</a></li>
		<li class="nav-item"><a class="nav-link" href="#">업무</a></li>
		<li class="nav-item"><a class="nav-link" href="#">파일</a></li>
		<%if(loginMember.getMemberId().equals(p.getMemberId())){ %> <!-- 현재 로그인된 멤버와, 프로젝트 생성자 아이디가 같으면 초대 버튼 활성화 -->
		<li class="nav-item"><a class="nav-link" href="#">초대</a></li>
		<%} %>
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
	/* 1.일반 게시글 작성 로직 */
	$("#insertNormal").click(e=>{
		$("#insertNormal_").click();
		
	});
	
	const checkContent=()=>{
		let title = $("input[name=title]").val();
		if(title.trim().length == 0){
			$("input[name=title]").focus();
			$("#titleResult").text("제목을 입력하세요").css("color","red");
			return false;
		}
	}
	
	$("#normal_submit_Btn").click(e=>{
	
		const frm = new FormData();
		const fileInput = $("input[name=upfile]");
		for(let i=0; i<fileInput[0].files.length;i++){
			frm.append("upfile"+i,fileInput[0].files[i]);
			
		}
		frm.append("title", $("input[name=title]").val());
		frm.append("content", $("#normalContent").val());
		frm.append("memberId",$("#memberId").val());
		frm.append("projectNo", $("#projectNo").val());
	
		
		$.ajax({
			url : "<%=request.getContextPath()%>/project/normal/insertNormalContent.do",
			type:"post",
			data:frm,
			processData:false,
			contentType:false,
			success:data=>{
				$("#close_content").click();
			},
			error:(a)=>{
				alert("실팽");
			}
			
		});
		
	});
	
	/* 2.업무 게시글 작성 로직 */
	
	
	$("#insertWork").click(e=>{
		$("#insertWork_").click();	
	});
	
	const checkWorkContent=()=>{
		let worktitle = $("#workTitle").val();
		if(title.trim().length == 0){
			$("#workTitle").focus();
			$("#work_titleResult").text("제목을 입력하세요").css("color","red");
			return false;
		}
	}
		
		//해당 업무 관리자 리스트 .. 업무 작성시
		const select = $("#work_addMember");
		const ophead = $("<option>").text("담당자 추가").prop("disabled",true);
		select.append(ophead);
		
		let memberName = new Array();
		let managerId = new Array();
		
		let selectedMember = new Array();
		let selectedManagerId = new Array();
		
		memberName = "<%=Arrays.toString(memberName)%>";
		memberName = memberName.substring(1,memberName.length-1);
		memberName = memberName.split(",");
		
		managerId ="<%=Arrays.toString(managerId)%>";
		managerId = managerId.substring(1,managerId.length-1);
		managerId = managerId.split(",");
		
		console.log(memberName);//ok
		console.log(managerId);//ok
		
		//업무 관리자 ID값으로 옵션에 value 넣어주기
						
		for(let i=0; i<memberName.length;i++){
			const option = $("<option>");
			option.text(memberName[i].trim());
			option.val(managerId[i].trim());
			select.append(option);
		}
		
		$(select).change(e=>{
				
			//선택된 유저 아이디 span으로 보여줌
			let span = $("<span>");
			let selectMemberName = $("#work_addMember option:selected").text();		
			let selectManaId = select.val();
	
			span.text(selectMemberName);

			//선택된 유저id 배열에 넣어주기
			for(let i =0; i<memberName.length;i++){
				if(!selectedManagerId.includes(selectManaId)){
					selectedManagerId.push(selectManaId);
					break;
				}
				
			}
			
			
			$("#work_addMember_area").append(span);	
			
			span.click(e=>{
				span.remove();
				
				for(let i=0;i<memberName.length;i++){
					if(selectedMember.includes(span.text())){
						let spanVal = span.text();
						selectedMember.splice(selectedMember.indexOf(spanVal),1);
						break;
					}
				}
				console.log(selectedMember);
			});
			//최종 값 selectedManagerId에 있음
			
		});
		
		//시작 날짜 
		let workStart;
		$("#workStart").change(e=>{
			workStart = $("#workStart").val();
			
		});				
		//마감 날짜
		let workEnd;
		$("#workEnd").change(e=>{
			workEnd = $("#workEnd").val();
			
		});
		
		//저장 버튼
		$("#work_submit_Btn").click(e=>{	
			//업무 제목
			let workTitle = $("#workTitle").val();
			
			//업무 진행상황 값 가져오기
			let workIngVal  = $("input[name=work_ing]:checked").val();
			
			//순위
			let workRank = $("input[name=work_rank]:checked").val();
			
			//내용
			let workContent = $("#workContent").val();
			
			//파일업로드
			const frm = new FormData();
			const fileInput = $("input[name=uploadWorkfile]");
			for(let i=0; i<fileInput[0].files.length;i++){
				frm.append("upfile"+i,fileInput[0].files[i]);
				
			}
			
			frm.append("workTitle", workTitle);
			frm.append("workIng", workIngVal);
			frm.append("workManagers",selectedManagerId);
			frm.append("workStart", workStart);
			frm.append("workEnd", workEnd);
			frm.append("workRank", workRank);
			frm.append("workContent", workContent);
			frm.append("projectNo", $("#projectNo").val());
			frm.append("memberId",$("#memberId").val()); //업무작성자
			
			
			//데이터 보내기
			$.ajax({
				url : "<%=request.getContextPath()%>/project/work/insertWorkContent.do",
				type:"post",
				data:frm,
				processData:false,
				contentType:false,
				success:data=>{
					$("#work_addMember").prop("selected", true);
					$("#workTitle").val("");
					$("#workStart").val("");
					$("#workEnd").val("");
					$("input[name=work_ing]").prop('checked',false);
					$("input[name=work_rank]").prop('checked',false);
					$("#workContent").val("");
					$("input[name=uploadWorkfile]").val("");
					
					$("#close_work_content").click();
					
				},
				error:(a)=>{
					alert("실팽");
				}
				
			});
			
			
		});  

	//일정 작성
	$("#insertSche").click(e=>{
		$("#insertSche_").click();
	});
	

</script>
     


<%@ include file="/views/common/footer.jsp"%>