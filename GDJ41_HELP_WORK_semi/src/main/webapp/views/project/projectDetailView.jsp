<%@page import="com.help.project.model.vo.ProjectAddMember"%>
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
	//List<ProjectAddMember> memberList = (List)request.getAttribute("memberList");
	
	
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


function memberListAjax(cPage){
	let projectNo = $("#projectNo").val();
	//프로젝트 게시글 가져오기
	$.ajax({
		url : "<%=request.getContextPath()%>/project/selectAllProjcetContent.do",
		type:"post",
		data:{"projectNo":projectNo,"cPage":cPage},
		dataType:"json",
		success:data=>{
			
			$("#contentArea").html("");
			
			const memberList = data["pList"];
			
			const table = $("<table class='table' style='text-align:center;'>");
			const thead = "<thead><tr><th scope='col'>구분</th><th scope='col'>제목</th><th scope='col'>작성자</th><th scope='col'>작성일</th><th scope='col'>상태</th></tr></thead>";
			table.append(thead);
			
			for(let i = 0; i< memberList.length;i++){
				
				const tr = $("<tr scope='row' onclick='contentView(this);'>");
				const dist = $("<td>").html(memberList[i]['dist']);
				const contentTitle = $("<td style='cursor: pointer;'>").html(memberList[i]["contentTitle"]);
				const memberName = $("<td>").html(memberList[i]["memberName"]);
				const writeDate = $("<td>").html(memberList[i]["writeDate"]);
				const workIng = $("<td>").html(memberList[i]["workIng"]);
				const memberId = $("<td style='display:none;'>").html(memberList[i]["memberId"]);
				const contentNo = $("<td style='display:none;'>").html(memberList[i]["contentNo"]);
				
				tr.append(dist).append(contentTitle).append(memberName).append(writeDate).append(workIng).append(memberId).append(contentNo);
				table.append(tr);
			}
			
			const div=$("<div>").attr("id","pageBar").html(data["pageBar"]);
			$("#contentArea").append(table).append(div);
			
		}
		
	});
}




function proInMemberList(){
	let projectNo = $("#projectNo").val();
	$.ajax({
		url : "<%=request.getContextPath()%>/project/selectProjectInMember.do",
		type:"post",
		data : {"projectNo":projectNo},
		dataType:"json",
		success:data=>{
			console.log(data);
			const creatorId = data["creatorId"];
			$("#proCreator").html("<h3>"+creatorId+"</h3>");
			
			for(let i=0;i<data["proMemberList"].length;i++){
				if(creatorId != data['proMemberList'][i]['memberId']){
				const h3 =$("<h5>").html(data["proMemberList"][i]["memberName"]);
				$("#proAttend").append(h3);
				}		
			}
		}
	});		
}


$(document).ready(()=>{
	memberListAjax();
	proInMemberList();
});

function contentView(e){
	let contentInfoArr = [];
	let str = "";
	
	let val = $(e).children();
	val.each(function(i){
		contentInfoArr.push(val.eq(i).text());
	});
	
	//정보 받아와서 배열에 저장했으니까..이거 그대로 검색해서 조회 결과 가져오기..
	$.ajax({
	
	});
	

}


</script>
<link rel ="stylesheet" href="<%=request.getContextPath()%>/css/projectDetailView.css" type="text/css">
<style>
#contentView{
	cursor: pointer;
}
</style>
<main>


<div class="offcanvas offcanvas-end" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1"  id='contentView'  aria-labelledby="offcanvasScrollingLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasScrollingLabel">게시글 제목</h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    내용내용내용
  </div>
</div>



<!-- 프로젝트 초대 모달 -->
<div class="modal fade" id="addProjectMemberModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">사원 목록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div>
		<div>
			<div id="searchType_Member">
			<select class="form-select" aria-label=".form-select-sm example" id="searchType_select">
					  
					  <option value="M.MEMBER_NAME">사원명</option>
					  <option value="D.DEPT_NAME">부서명</option>
					  <option value="P.POSITION_NAME">직급명</option>
				</select>
			</div>
				<div class="input-group mb-3">
					<input type="text" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2" id="searchKeyword_Member">
					<button class="btn btn-outline-secondary" type="button" id="search_Member_btn">검색</button>
				</div>
		</div>
		
      </div>
      <div class="modal-body">
       	<div id="addProjectMemberListContainer">
       		<table class="table table-hover" style="text-align: center;">
       			
       		</table>
       	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="proAddMember_close">Close</button>
        <button type="button" class="btn btn-primary" id="proAddMember_submit">추가</button>
      </div>
    </div>
  </div>
</div>

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
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" id="normalTitle" name="title">
      <span id="titleResult"></span>
        <textarea class="form-control" placeholder="내용을 입력하세요" id="normalContent" style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"></textarea>
		  <div class="mb-3">
 		<label for="formFile" class="form-label"></label>
  		<input class="form-control" type="file" id="uploadNormal" name="upfile" multiple>
		</div>
		<div id="fileNameList">
			
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

<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
      	<div><select class="form-select" id="work_addMember"></select></div>
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
		<div id="workFileNameContainer"></div>
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

<div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" id="scheTitle">
      <span id="sche_titleResult"></span>
      <div id="sche_addMember_container">
      	<span><i class="fas fa-user"></i></span>
      	<div><select class="form-select" id="sche_addMember">
      	</select></div>
      	<div id="sche_addMember_area"></div>
      </div>
      <div id="scheStart_container">
      	<span><i class="fas fa-calendar-plus"></i></span>
      	<input type="date" id="scheStartDate">
      </div>
      <div id="scheEnd_container">
      	<span><i class="fas fa-calendar-check"></i></span>
      	<input type="date" id="scheEndDate">
      </div>

		<div>
	  		<button type="button" class="btn" id="sche_place_btn"><i class="fas fa-map-marker-alt"></i>장소검색</button>
	  			<div id="test" style="display:none;">
	  				<input type="text" id="searchKeyword">
	  				<button id="searchBtn">검색</button>
	  			</div>
	 	</div>
	 	<div id="searchContainer" style="display:none; width: 100%; height: 500px;">
			 <div class="map_wrap">
				 <div id="map" style="width: 100%;height: 100%;position: relative;overflow: hidden; background: url(https://t1.daumcdn.net/mapjsapi/images/bg_tile.png);"></div>
				 <div id="menu_wrap" class="bg_white">
				 <ul id="placeList"></ul>
				 <div id="pagination"></div>
	 			</div>
    		</div>
		</div>
		<div id="searchResultContainer">
		</div>

    <textarea class="form-control" placeholder="내용을 입력하세요" id="scheContent" style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"></textarea>
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
	//지도 API 사용
	
	//검색한 주소 가져오는 함수
	
	let shce_place_name;
	let shce_place_Loadaddr;
	
	function getAddress(){
	 shce_place_name = $("#shce_place_name").text();
	 shce_place_Loadaddr = $("#shce_place_Loadaddr").text();
	//화면 출력 꺼지게 하기
	$("#searchContainer").hide();
	
	$("#searchResultContainer").append("<p> 장소명 : "+shce_place_name+"</p>").append("<p> 주소 : "+shce_place_Loadaddr+"</p>");
	 
	}
	
	
$("#sche_place_btn").click(e=>{
	$("#test").show();
});

	$("#searchBtn").click(e=>{
		
		$("#searchContainer").show(e=>{
			 
			let keyword = $("#searchKeyword").val();
			//마커를 담을 배열입니다
			var markers = [];

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };  

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 

			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();  

			// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});

			 ps.keywordSearch( keyword, placesSearchCB); 
			
			// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
			function placesSearchCB(data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {
			        // 정상적으로 검색이 완료됐으면
			        // 검색 목록과 마커를 표출합니다
			        displayPlaces(data);

			        // 페이지 번호를 표출합니다
			        displayPagination(pagination);

			    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

			        alert('검색 결과가 존재하지 않습니다.');
			        return;

			    } else if (status === kakao.maps.services.Status.ERROR) {

			        alert('검색 결과 중 오류가 발생했습니다.');
			        return;

			    }
			}

			// 검색 결과 목록과 마커를 표출하는 함수입니다
			function displayPlaces(places) {

			    var listEl = document.getElementById('placeList'), 
			    menuEl = document.getElementById('menu_wrap'),
			    fragment = document.createDocumentFragment(), 
			    bounds = new kakao.maps.LatLngBounds(), 
			    listStr = '';
			    
			    // 검색 결과 목록에 추가된 항목들을 제거합니다
			    removeAllChildNods(listEl);

			    // 지도에 표시되고 있는 마커를 제거합니다
			    removeMarker();
			    
			    for ( var i=0; i<places.length; i++ ) {

			        // 마커를 생성하고 지도에 표시합니다
			        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
			            marker = addMarker(placePosition, i), 
			            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        bounds.extend(placePosition);

			        // 마커와 검색결과 항목에 mouseover 했을때
			        // 해당 장소에 인포윈도우에 장소명을 표시합니다
			        // mouseout 했을 때는 인포윈도우를 닫습니다
			        (function(marker, title) {
			            kakao.maps.event.addListener(marker, 'mouseover', function() {
			                displayInfowindow(marker, title);
			            });

			            kakao.maps.event.addListener(marker, 'mouseout', function() {
			                infowindow.close();
			            });

			            itemEl.onmouseover =  function () {
			                displayInfowindow(marker, title);
			            };

			            itemEl.onmouseout =  function () {
			                infowindow.close();
			            };
			        })(marker, places[i].place_name);

			        fragment.appendChild(itemEl);
			    }

			    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
			    listEl.appendChild(fragment);
			    menuEl.scrollTop = 0;

			    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			    map.setBounds(bounds);
			}

			// 검색결과 항목을 Element로 반환하는 함수입니다
			function getListItem(index, places) {

			    var el = document.createElement('li'),
			    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
			                '<div onclick="getAddress();" style="cursor:pointer;" class="info">' +
			                '   <h5 id="shce_place_name" style="font-weight:bold; font-size:15px;">' + places.place_name + '</h5>';

			    if (places.road_address_name) {
			        itemStr += '    <h4 id="shce_place_Loadaddr">' + places.road_address_name + '</h4>' +
			                    '   <h5 class="jibun gray">' +  places.address_name  + '</h5>';
			    } else {
			        itemStr += '    <span>' +  places.address_name  + '</span>'; 
			    }
			                 
			      itemStr += '  <h5 class="tel">' +"tel : "+ places.phone  + '</h5><hr>' +
			                '</div>';           

			    el.innerHTML = itemStr;
			    el.className = 'item';
			    
			   
				 
			    return el;
			}
			

			// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
			function addMarker(position, idx, title) {
			    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
			        imgOptions =  {
			            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
			        },
			        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
			            marker = new kakao.maps.Marker({
			            position: position, // 마커의 위치
			            image: markerImage 
			        });

			    marker.setMap(map); // 지도 위에 마커를 표출합니다
			    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

			    return marker;
			}

			// 지도 위에 표시되고 있는 마커를 모두 제거합니다
			function removeMarker() {
			    for ( var i = 0; i < markers.length; i++ ) {
			        markers[i].setMap(null);
			    }   
			    markers = [];
			}

			// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
			function displayPagination(pagination) {
			    var paginationEl = document.getElementById('pagination'),
			        fragment = document.createDocumentFragment(),
			        i; 

			    // 기존에 추가된 페이지번호를 삭제합니다
			    while (paginationEl.hasChildNodes()) {
			        paginationEl.removeChild (paginationEl.lastChild);
			    }

			    for (i=1; i<=pagination.last; i++) {
			        var el = document.createElement('a');
			        el.href = "#";
			        el.innerHTML = i;

			        if (i===pagination.current) {
			            el.className = 'on';
			        } else {
			            el.onclick = (function(i) {
			                return function() {
			                    pagination.gotoPage(i);
			                }
			            })(i);
			        }

			        fragment.appendChild(el);
			    }
			    paginationEl.appendChild(fragment);
			}

			// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
			// 인포윈도우에 장소명을 표시합니다
			function displayInfowindow(marker, title) {
			    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

			    infowindow.setContent(content);
			    infowindow.open(map, marker);
			}

			 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
			function removeAllChildNods(el) {   
			    while (el.hasChildNodes()) {
			        el.removeChild (el.lastChild);
			    }
			}
			 
			
			
		});
	});
</script>


<div id="title-container">
	<div id="pro-bookmark-star"><i class="fas fa-star"></i></div>
	<div id="project-title"><span><%=p.getProName() %></span></div>
	<div style="float:right;">
	<%if(loginMember.getMemberId().equals(p.getMemberId())){ %> <!-- 현재 로그인된 멤버와, 프로젝트 생성자 아이디가 같으면 초대 버튼 활성화 -->
	<button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#addProjectMemberModal" id="add_btn">사원 추가</button>
	<%} %>
	</div>
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
	<div id="inner_pro_container">
	<div id="inputContent_container">
		<div id="input-group">
			<div id="insertNormal"><a href="#"><span><i class="fas fa-edit"></i></span>&nbsp;글</a></div>
			<div id="insertWork"><a href="#"><span><i class="fas fa-list"></i></span>&nbsp;업무</a></div>
			<div id="insertSche"><a href="#"><span><i class="far fa-calendar"></i></span>&nbsp;일정</a></div>
		</div>
	</div>
	
	<div id="contentContainer">
		<div id ="contentArea">
		

		</div>
	</div>
	
	</div>
	<div id="proMemberViewContainer">
		<div id="innder_proMemberViewContainer">
			<h4>프로젝트 생성자</h4>
				<div id="proCreator"></div>
			<hr>
			<h4>참여자</h4>
			<div id="proAttend"></div>
		</div>
	</div>
</div>

</main>

<script>
	
	//프로젝트에 참여중인 사원 목록

//사원 프로젝트 초대
$("#add_btn").click(e=>{
	let projectNo = $("#projectNo").val();
	$.ajax({
		url: "<%=request.getContextPath()%>/project/selectAllMember.do",
		dataType:"json",
		data:{"projectNo":projectNo},
		success : data=>{
		
			$("#addProjectMemberListContainer").find("table").remove();
			const table = $("<table class='table' style='text-align:center;'>");
			table.html("<thead><tr><th scope='col'>이름</th><th scope='col'>부서명</th><th scope='col'>직급</th><th scope='col'>선택</th></tr></thead>");
			for(let i=0;i<data.length;i++){
			const tr = $("<tr scope='row'>");
			const memberName = $("<td>").html(data[i]["memberName"]);
			const deptName = $("<td>").html(data[i]["deptName"]);
			const positionName = $("<td>").html(data[i]["positionName"]);
			const check = $("<td>");
			check.html("<input type='checkbox' name='proAddMember_Ck' value='"+data[i]["memberId"]+"'>");
			tr.append(memberName).append(deptName).append(positionName).append(check);
			table.append(tr);
			}
			$("#addProjectMemberListContainer").append(table);
		}
		
	});
});


$("#proAddMember_submit").click(e=>{
	let addMemberArr = new Array();
	let projectNo = $("#projectNo").val();
	
	//체크박스로 선택된 사원 아이디 가져와서 배열에 저장함
	$("input[name=proAddMember_Ck]:checked").each(function(){
		let temp = $(this).val();
		addMemberArr.push(temp);
	});
	//tb_pro_member 테이블에 보내줘야함.
	
	$.ajax({
		url : "<%=request.getContextPath()%>/project/addProjectMember.do",
		type:"post",
		data : {"addMemberArr":addMemberArr,
				"projectNo":projectNo},
		success: data=>{
			proInMemberList();
			$("#proAddMember_close").click();
		},
		error: a=>{
			alert("시일패에..");
		}
	});
});

//사원 초대에서 검색 기능
$("#search_Member_btn").click(e=>{
	let searchType =  $("#searchType_select").val();
	let searchKeyword = $("#searchKeyword_Member").val();
	let projectNo = $("#projectNo").val();
	
	$.ajax({
		url : "<%=request.getContextPath()%>/project/searchAddMember.do",
		data : {"searchType":searchType,"searchKeyword":searchKeyword,"projectNo":projectNo},
		dataType:"json",
		success : data=>{
			$("#addProjectMemberListContainer").find("table").remove();
			const table = $("<table class='table' style='text-align:center;'>");
			table.html("<thead><tr><th scope='col'>이름</th><th scope='col'>부서명</th><th scope='col'>직급</th><th scope='col'>선택</th></tr></thead>");
			for(let i=0;i<data.length;i++){
			const tr = $("<tr scope='row'>");
			const memberName = $("<td>").html(data[i]["memberName"]);
			const deptName = $("<td>").html(data[i]["deptName"]);
			const positionName = $("<td>").html(data[i]["positionName"]);
			const check = $("<td>");
			check.html("<input type='checkbox' name='proAddMember_Ck' value='"+data[i]["memberId"]+"'>");
			tr.append(memberName).append(deptName).append(positionName).append(check);
			table.append(tr);
			}
			$("#addProjectMemberListContainer").append(table);				
		}
	});
	
});

	
	/* 1.일반 게시글 작성 로직 */
	$("#insertNormal").click(e=>{
		$("#insertNormal_").click();
	});		
	
	$("#uploadNormal").change(e=>{
		if($("#fileNameList").find("p").length>0){
			$("#fileNameList").find("p").remove();
		}
		
		let fileName = $("input[name=upfile]");
			for(let i=0;i<fileName.length;i++){
				if(fileName[i].files.length>0){
					for(let j =0;j<fileName[i].files.length;j++){
						let p = $("<p>");
					p.text(fileName[i].files[j].name);
					$("#fileNameList").append(p);
					}
				}
			}
	});
	
	
	$("#normal_submit_Btn").click(e=>{
		//제목 반드시 입력
		let title = $("input[name=title]").val();
		if(title.trim().length == 0){
			$("input[name=title]").focus();
			$("#titleResult").text("제목을 입력하세요").css("color","red");
		}else{
			
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
				$("#normalTitle").val("");
				$("#normalContent").val("");
				$("#uploadNormal").val("");
				$("#fileNameList").find("p").remove();			
				$("#close_content").click();
				memberListAjax();	
			},
			error:(a)=>{
				alert("실팽");
			}
			
		});

		}
			
	});
	
	/* 2.업무 게시글 작성 로직 */
	
	
	$("#insertWork").click(e=>{
		$("#insertWork_").click();	
	});
	
	$("#uploadWorkfile_").change(e=>{
		if($("#workFileNameContainer").find("p").length>0){
			$("#workFileNameContainer").find("p").remove();
		}
		
		let fileName = $("input[name=uploadWorkfile]");
			for(let i=0;i<fileName.length;i++){
				if(fileName[i].files.length>0){
					for(let j =0;j<fileName[i].files.length;j++){
						let p = $("<p>");
					p.text(fileName[i].files[j].name);
					$("#workFileNameContainer").append(p);
					}
				}
			}
	});

		//해당 업무 관리자 리스트 .. 업무 작성시
		const select = $("#work_addMember");
		const ophead = $("<option>").text("담당자 추가");
		
		select.append(ophead);
		
		let memberName = new Array();
		let managerId = new Array();
		
		let selectedMember = new Array(); //최종 선택된 멤버 이름
		let selectedManagerId = new Array(); //최종 선택된 멤버 아이디
		
		memberName = "<%=Arrays.toString(memberName)%>";
		memberName = memberName.substring(1,memberName.length-1);
		memberName = memberName.split(","); //프로젝트에 참가한 사람 이름 다 가지고있음
		
		managerId ="<%=Arrays.toString(managerId)%>";
		managerId = managerId.substring(1,managerId.length-1);
		managerId = managerId.split(",");//프로젝트에 참가한 사람 아이디 다 가지고 있음
		

		
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
			span.val(selectManaId);
			
			
			//선택된 유저id 배열에 넣어주기
			for(let i =0; i<memberName.length;i++){
				if(!selectedManagerId.includes(selectManaId)){
					selectedManagerId.push(selectManaId);
					$("#work_addMember_area").append(span);	
					break;
				}
				
			}
			
			
			
			if($("#work_addMember_area").find("span").length > memberName.length){
				span.remove();
			}
			
			//span에서 삭제하면 배열에서도 삭제해주기
			span.click(e=>{
				
				for(let i=0;i<memberName.length;i++){
					if(selectedManagerId.includes(span.val())){
						selectedManagerId.splice(selectedManagerId.indexOf(span.val()),1);
						break;
					}
					
				}
				span.remove();
				
			});
			//최종 값 selectedManagerId에 있음
			
		});
		
		//기본 날짜 설정
		
	let workStart = document.getElementById('workStart').value= new Date().toISOString().substring(0, 10);
	let workEnd = document.getElementById('workEnd').value= new Date().toISOString().substring(0, 10);	
		//시작 날짜 
		$("#workStart").change(e=>{
			workStart = $("#workStart").val();
		});		
		
		//마감 날짜
		
		$("#workEnd").change(e=>{
			workEnd = $("#workEnd").val();
			
		});
		
		//저장 버튼
		$("#work_submit_Btn").click(e=>{	
			//제목 가져오기
			let workTitle = $("#workTitle").val();
			
			if(workTitle.trim().length == 0){
				$("#workTitle").focus();
				$("#work_titleResult").text("제목을 입력하세요").css("color","red");
			}else if(!$("input[name=work_ing]").is(":checked")){
				$("#call").prop("checked",true);
			}else if(!$("input[name=work_rank]").is(":checked")){
				$("#normal").prop("checked",true);
			}else if(selectedManagerId.length == 0){
				alert("담당자를 추가하세용");
				return false;
			}else {
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
					$("#workFileNameContainer").find("p").remove();
					$("#work_addMember_area").find("span").remove();
					$("#close_work_content").click();
					memberListAjax();	
				},
				error:(a)=>{
					alert("실팽");
				}
				
			});
			
			}
		});  

	//일정 작성
	$("#insertSche").click(e=>{
		$("#insertSche_").click();
	});
	
	 //일정 참석자 리스트
	 const selectSche = $("#sche_addMember");
	 const opheadSche = $("<option>").text("참석자 추가");
	 selectSche.append(opheadSche);
	
					
	for(let i=0; i<memberName.length;i++){
		const option = $("<option>");
		option.text(memberName[i].trim());
		option.val(managerId[i].trim());
		selectSche.append(option);
	}
	
	$(selectSche).change(e=>{
		
		
		let span = $("<span>");
		let selectMemberName = $("#sche_addMember option:selected").text();		
		let selectManaId = selectSche.val();
		span.text(selectMemberName);
		span.val(selectManaId);	
		
		//선택된 유저id 배열에 넣어주기
		for(let i =0; i<memberName.length;i++){
			if(!selectedManagerId.includes(selectManaId)){
				selectedManagerId.push(selectManaId);
				$("#sche_addMember_area").append(span);
				break;
			}
		}
		
	
		if($("#sche_addMember_area").find("span").length > memberName.length){
			span.remove();
		}
		
		
		//span에서 삭제하면 배열에서도 삭제해주기
		span.click(e=>{
			for(let i=0;i<memberName.length;i++){
				if(selectedManagerId.includes(span.val())){
					selectedManagerId.splice(selectedManagerId.indexOf(span.val()),1);
					break;
				}
				
			}
			span.remove();
			
		}); 
		//최종 값 selectedManagerId에 있음
	
	});
	
	//일정 기본 날짜
	let = scheStartDate = document.getElementById('scheStartDate').value= new Date().toISOString().substring(0, 10);
	let = scheEndDate = document.getElementById('scheEndDate').value= new Date().toISOString().substring(0, 10);
	
	//일정등록
	$("#sche_submit_Btn").click(e=>{
		
		let scheTitle = $("#scheTitle").val();
		
		if(scheTitle.trim().length == 0){
			$("#scheTitle").focus();
			$("#sche_titleResult").text("제목을 입력하세요").css("color","red");
		}else{
			
			//일정 시작 날짜
			
			$("#scheStartDate").change(e=>{
				scheStartDate = $("#scheStartDate").val();
			});
			
			//일정 마감 날짜
			
			$("#scheEndDate").change(e=>{
				scheEndDate = $("#scheEndDate").val();
			});
			
			let projectNo = $("#projectNo").val();
			let memberId = $("#memberId").val();
			let scheContent = $("#scheContent").val();

			
			//데이터 보내기
			$.ajax({
				url : "<%=request.getContextPath()%>/project/sche/insertScheContent.do",
				type:"POST",
				traditional : true,		
				data:{"scheTitle":scheTitle,
					"scheContent":scheContent,
					"shce_place_name":shce_place_name,
					"shce_place_Loadaddr":shce_place_Loadaddr,
					"shceStart":scheStartDate,
					"scheEndDate":scheEndDate,
					"projectNo":projectNo,
					"memberId":memberId,
					"scheAttendMember":selectedManagerId
				},
				success:data=>{
					$("#scheTitle").val("");
					$("#sche_addMember").val("");
					$("#searchKeyword").val("");
					$("#scheContent").val("");
					$("sche_addMember_area").find("span").remove();
					$("#searchResultContainer").find("p").remove();
					$("#close_sche_content").click();
					memberListAjax();	
				},
				error:(a)=>{
					alert("실팽");
					$("#close_sche_content").click();
				}
				
			});
		}
	});
</script>
     




<%@ include file="/views/common/footer.jsp"%>