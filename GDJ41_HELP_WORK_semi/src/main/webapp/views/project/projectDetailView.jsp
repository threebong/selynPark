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
%>
<style>
   .form-select{
      width: 120px;
   }
</style>
<script>
$(document).ready(()=>{
   contentListAjax();
   proInMemberList();
   
});

function contentListAjax(cPage){
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
         const thead = "<thead><tr><th scope='col'>구분</th><th scope='col'>제목</th><th scope='col'>작성자</th><th scope='col'>작성일</th><th scope='col'>상태</th><th scope='col'>순위</th></tr></thead>";
         table.append(thead);
         
         for(let i = 0; i< memberList.length;i++){
            
            const tr = $("<tr scope='row' onclick='contentView(this);'>");
            const dist = $("<td>").html(memberList[i]['dist']);
            const contentTitle = $("<td style='cursor: pointer;'>").html(memberList[i]["contentTitle"]);
            const memberName = $("<td>").html(memberList[i]["memberName"]);
            const writeDate = $("<td>").html(memberList[i]["writeDate"]);
            const workIng = $("<td>").html(memberList[i]["workIng"]);
            const workRank = $("<td>").html(memberList[i]["workRank"]);
            const memberId = $("<td style='display:none;'>").html(memberList[i]["memberId"]);
            const contentNo = $("<td style='display:none;'>").html(memberList[i]["contentNo"]);
            
            
            tr.append(dist).append(contentTitle).append(memberName).append(writeDate).append(workIng).append(workRank).append(memberId).append(contentNo);
            table.append(tr);
         }
         
         const div=$("<div>").attr("id","pageBar").html(data["pageBar"]);
         $("#contentArea").append(table).append(div);
         
      }
      
   });
}



//프로젝트 검색 게시글 가져오기
function searchListAjax(cPage){
   let dist = $("input[name=selectContentRadio]:checked").val();
   let projectNo = $("#projectNo").val();
   let searchType = $("#searchConSelect").val();
   let keyword = $("#searchConKeyword").val();
   
   $.ajax({
      url: "<%=request.getContextPath()%>/project/searchAllContent.do",
      dataType:"json",
      data:{keyword:keyword
         ,searchType:searchType
         ,projectNo:projectNo,
         dist:dist,
         cPage:cPage},
      success:data=>{
         
         $("#contentArea").html("");
         
         const memberList = data["pList"];
         
         const table = $("<table class='table' style='text-align:center;'>");
         const thead = "<thead><tr><th scope='col'>구분</th><th scope='col'>제목</th><th scope='col'>작성자</th><th scope='col'>작성일</th><th scope='col'>상태</th><th scope='col'>순위</th></tr></thead>";
         table.append(thead);
         
         for(let i = 0; i< memberList.length;i++){
            
            const tr = $("<tr scope='row' onclick='contentView(this);'>");
            const dist = $("<td>").html(memberList[i]['dist']);
            const contentTitle = $("<td style='cursor: pointer;' >").html(memberList[i]["contentTitle"]);
            const memberName = $("<td>").html(memberList[i]["memberName"]);
            const writeDate = $("<td>").html(memberList[i]["writeDate"]);
            const workIng = $("<td>").html(memberList[i]["workIng"]);
            const workRank = $("<td>").html(memberList[i]["workRank"]);
            const memberId = $("<td style='display:none;'>").html(memberList[i]["memberId"]);
            const contentNo = $("<td style='display:none;'>").html(memberList[i]["contentNo"]);
            
            
            tr.append(dist).append(contentTitle).append(memberName).append(writeDate).append(workIng).append(workRank).append(memberId).append(contentNo);
            table.append(tr);
         }
         
         const div=$("<div>").attr("id","pageBar").html(data["pageBar"]);
         $("#contentArea").append(table).append(div);
         
      }
      
   });
}


//프로젝트 참여자 리스트 가져오기
function proInMemberList(){
   let projectNo = $("#projectNo").val();
   $.ajax({
      url : "<%=request.getContextPath()%>/project/selectProjectInMember.do",
      type:"post",
      data : {"projectNo":projectNo},
      dataType:"json",
      success:data=>{
         
         const creatorId = data["creatorId"];
         $("#proCreator").html("<h3>"+creatorId+"</h3>");
         
         $("#proAttend").html("");
         for(let i=0;i<data["proMemberList"].length;i++){
            if(creatorId != data['proMemberList'][i]['memberId']){
            const h3 =$("<h5>").html(data["proMemberList"][i]["memberName"]);
            $("#proAttend").append(h3);
            }      
         }
         
      }
   });      
}



function contentView(e){
   
   let val = $(e).children();   
   let dist = val.eq(0).text();
   let contentNo = val.eq(7).text();

   //프로젝트 생성자, 글 쓴 사람, 로그인 한사람
   let loginMember ="<%=loginMember.getMemberId()%>";
   let contentWriterId = val.eq(6).text();
   let projectCreator = "<%=p.getMemberId()%>";

   $(".updateBtnContainer").css("display","none");
   //글 쓴 사람이랑 로그인 한 사람 아이디가 같으면? 보임
   //로그인 한 사람이 프로젝트 만든 사람이면? 보임
   if(loginMember == contentWriterId || loginMember == projectCreator){
      $(".updateBtnContainer").css("display","block");
   }
   
   
   $.ajax({
      url:"<%=request.getContextPath()%>/project/selectContentView.do",
      type:"post",
      data : {"dist":dist,"contentNo":contentNo},
      traditional : true,
      datatype:"json",
      success:data=>{
         const mfile = data["mFile"];
         const pc = data["pc"];
         const memberNameList = data["memberNameList"];
         console.log(pc);
         switch(dist){
            case '게시글' : 
               
               $("#writerName").html(pc["memberName"]);
               $("#writeDate").html(pc["writeDate"]);
               $("#contentTitleView").html(pc["contentTitle"]);
               $("#contentBody").html(pc["content"]);
               $("#normalContentNo").html(pc["contentNo"]);
               $("#normalContentDist").html(pc["dist"]);
               $("#normalOriFileName").children().remove();
               $("#normalReFileName").children().remove();
               for(let i =0;i<mfile.length;i++){
                  const h5 =$("<h5>");
                  const h6 = $("<h6>");
                  h5.html("<a href='javascript:fn_normalFileDownload();'>"+mfile[i]["normalOriFileName"]+"</a>");
                  h6.html(mfile[i]["normalReFileName"]);
                  $("#normalOriFileName").append(h5)
                  $("#normalReFileName").append(h6);
               }
               $("#viewBtn").click();
               
            break;
            case '업무' :
                 
                  $("#workWriterName").html(pc["memberName"]);
                     $("#workWriteDate").html(pc["writeDate"]);
                     $("#workContentTitleView").html(pc["contentTitle"]);
                     
                     $("#workIngView").html(pc["workIng"]);
                     
                     $("#workManager").children().remove();
                     for(let i=0;i<memberNameList.length;i++){
                           const span = $("<span>");
                           span.html(memberNameList[i]["managerName"]);
                           $("#workManager").append(span);   
                     }
                     
                     $("#workStartDate_view").html(pc["startDate"]);
                     $("#workEndDate_view").html(pc["endDate"]);
                     $("#workRank_view").html(pc["workRank"])
                     $("#workContent_view").html(pc["content"]);
                     $("#workContentNo").html(pc["contentNo"]);
                     $("#workdist").html(pc["dist"]);
                     
                     $("#workOriFileName").children().remove();
                  $("#workReFileName").children().remove();
                  for(let i =0;i<mfile.length;i++){
                     const h5 =$("<h5>");
                     const h6 = $("<h6>");
                     h5.html("<a href='javascript:fn_workFileDownload();'>"+mfile[i]["workOriFileName"]+"</a>");
                     h6.html(mfile[i]["workReFileName"]);
                     $("#workOriFileName").append(h5)
                     $("#workReFileName").append(h6);
                  }

               
               $("#workViewBtn").click();
            break;
            case '일정' : 
               
                $("#scheWriterName").html(pc["memberName"]);
                     $("#scheWriteDate").html(pc["writeDate"]);
                     $("#scheContentTitleView").html(pc["contentTitle"]);
                     $("#scheContentNo").html(pc["contentNo"]);
                     $("#schedist").html(pc["dist"]);
                     
                     $("#scheAttendPeople").children().remove();
                     for(let i=0;i<memberNameList.length;i++){
                        const span = $("<span>");
                        span.html(memberNameList[i]["memberName"]);
                        $("#scheAttendPeople").append(span);
                     }
                     
                     $("#scheStartDate_view").html(pc["startDate"]);
                     $("#scheEndDate_view").html(pc["endDate"]);
                     $("#schePlaceName").html(pc["placeName"]);
                     $("#schePlaceAddr").html(pc["address"]);
                     $("#scheContent_view").html(pc["content"]);
                     $("#scheViewBtn").click();
            break;
         }
      }
   });
}

const fn_workFileDownload=()=>{
   let workOriFileName = $("#workOriFileName").text(); 
   let workReFileName = $("#workReFileName").text();
   
    const url = "<%=request.getContextPath()%>/project/workfileDownload.do";
    const encode = encodeURIComponent(workOriFileName);
    location.assign(url+"?workOriFileName="+encode+"&&workReFileName="+workReFileName);
}

const fn_normalFileDownload=()=>{
   
   let normalOriFileName = $("#normalOriFileName").text(); 
   let normalReFileName = $("#normalReFileName").text();
   
    const url = "<%=request.getContextPath()%>/project/normalfileDownload.do";
    const encode = encodeURIComponent(normalOriFileName);
    location.assign(url+"?normalOriFileName="+encode+"&&normalReFileName="+normalReFileName);
}


</script>
<link rel ="stylesheet" href="<%=request.getContextPath()%>/css/projectDetailView.css" type="text/css">
<style>
#contentView{
   cursor: pointer;
}
</style>
<main>

<!-- 일반 게시글 상세화면 -->
<button class="btn btn-primary" type="button" id="viewBtn" style="display:none;" data-bs-toggle="offcanvas" data-bs-target="#contentView" aria-controls="offcanvasScrolling"></button>
<div class="offcanvas offcanvas-end" style="width: 40%;" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1"  id="contentView" aria-labelledby="offcanvasScrollingLabel">
  <div class="offcanvas-header"> 
  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close" id="normal_close_btn"></button>
  </div>
   <div class="offcanvas-title" style="border-bottom: 1px solid lightgray">
         <span id="normalContentNo" style="display:none;"></span>
         <span id="normalContentDist" style="display:none;"></span>
         <span id="writerName" style="font-size: 18px; font-weight: bold;"></span>
         <span id="writeDate"style="font-size: 18px; font-weight: bold; margin-left: 15px;"></span>
         <h4 id="contentTitleView" style="margin-top: 20px;"></h4>
   </div>   
  <div class="offcanvas-body" id="contentBody"></div>
  <hr>
  <div class="offcanvas-body" id="contentfooter">
     <div id="normalFileContainer">
        <div id="normalOriFileName"></div>
        <div id="normalReFileName" style="display: none;"></div>
     </div>
     <div class="updateBtnContainer" style="display:none;">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#normal_update" id="normal_update_btn">수정</button>
        <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#normal-delete">삭제</button>
     </div>
  </div>
</div>

<!-- 업무 게시글 상세화면 -->

<button class="btn btn-primary"  id="workViewBtn" type="button" style="display:none;" data-bs-toggle="offcanvas" data-bs-target="#workContentView" aria-controls="offcanvasScrolling"></button>
<div class="offcanvas offcanvas-end" style="width: 40%;" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1"  id="workContentView" aria-labelledby="offcanvasScrollingLabel">
  <div class="offcanvas-header"> 
  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close" id="work_close_btn"></button>
  </div>
   <div class="offcanvas-title" style="border-bottom: 1px solid lightgray">
         
         <span id="workWriterName" style="font-size: 18px; font-weight: bold;"></span>
         <span id="workWriteDate"style="font-size: 18px; font-weight: bold; margin-left: 15px;"></span>
         <h4 id="workContentTitleView" style="margin-top: 20px;"></h4>
   </div>
  <div class="offcanvas-body" id="contentBody">
        <div id="workIngView"></div>
        <div id="workManager"></div>
        <div id="workStartDate_view"></div>
        <div id="workEndDate_view"></div>
        <div id="workRank_view"></div>
        <div id="workContent_view"></div>
        <div id="workContentNo" style="display:none;"></div>
        <div id="workdist" style="display:none;"></div>
  </div>
  <div class="offcanvas-body" id="contentfooter">
     <div id="workFileContainer">
        <div id="workOriFileName"></div>
        <div id="workReFileName" style="display:none;"></div>
     </div>
     <div class="updateBtnContainer" style="display: none;">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateWorkModal" id="updateWork_">수정</button>
        <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#work-delete" id="del_btn2">삭제</button>
     </div>
  </div>
</div>

<!-- 일정 게시글 상세화면 -->

<button class="btn btn-primary"  id="scheViewBtn" type="button" style="display:none;" data-bs-toggle="offcanvas" data-bs-target="#scheContentView" aria-controls="offcanvasScrolling"></button>
<div class="offcanvas offcanvas-end" style="width: 40%;" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1"  id="scheContentView" aria-labelledby="offcanvasScrollingLabel">
  <div class="offcanvas-header"> 
  <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close" id="sche_close_btn"></button>
  </div>
   <div class="offcanvas-title" style="border-bottom: 1px solid lightgray">
         
         <span id="scheWriterName" style="font-size: 18px; font-weight: bold;"></span>
         <span id="scheWriteDate"style="font-size: 18px; font-weight: bold; margin-left: 15px;"></span>
         <h4 id="scheContentTitleView" style="margin-top: 20px;"></h4>
   </div>
  <div class="offcanvas-body" id="contentBody">
        <div id="scheAttendPeople"></div>
        <div id="scheStartDate_view"></div>
        <div id="scheEndDate_view"></div>
        <div id="schePlaceName"></div>
        <div id="schePlaceAddr"></div>
        <div id="scheContent_view"></div>
        <div id="scheContentNo"style="display:none;"></div>
        <div id="schedist"style="display:none;"></div>
  </div>
   <div class="offcanvas-body" id="contentfooter">
        <div class="updateBtnContainer" style="display:none;">
           <button type="button" class="btn btn-outline-secondary" id="sche_update">수정</button>
           <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#sche-delete" id="del_btn3">삭제</button>
        </div>
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

<!-- 일반게시글 수정 모달 -->

<div class="modal fade" id="normal_update" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">게시물 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" id="normal_update_title_" name="normal_update_title">
      <span id="titleResult_"></span>
        <textarea class="form-control" placeholder="내용을 입력하세요" id="normal_update_Content" style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"></textarea>
      <!--  <div class="mb-3">
       <label for="formFile" class="form-label"></label>
        <input class="form-control" type="file" id="upload_update_Normal" name="normal_upfile" multiple>
      </div>
      -->
      <div id="fileNameList_update"></div>
      <div id="fileReNameList_update" style="display:none;"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="normal_update_close">닫기</button>
        <button type="button" class="btn btn-primary" id="normal_updateSubmit_Btn">등록</button>
      </div>
    </div>
  </div>
</div>
<script>
//일반 게시글 수정.. 파일은..못해..
   $("#normal_update_btn").click(e=>{
      let contentNo = $("#normalContentNo").text();
      let dist = $("#normalContentDist").text();
      $.ajax({
         url:"<%=request.getContextPath()%>/project/selectContentView.do",
         type:"post",
         data : {"dist":dist,"contentNo":contentNo},
         traditional : true,
         datatype:"json",
         success:data=>{
            const mfile = data["mFile"];
            const pc = data["pc"];
            const memberNameList = data["memberNameList"];
            console.log(pc);
            switch(dist){
               case '게시글' : 
                  $("#normal_update_title_").val(pc["contentTitle"]);
                  $("#normal_update_Content").val(pc["content"]);
                  $("#fileNameList_update").children().remove();
                  $("#fileReNameList_update").children().remove();
                  for(let i =0;i<mfile.length;i++){
                     const h5 =$("<h5>");
                     const h6 = $("<h6>");
                     h5.html(mfile[i]["normalOriFileName"]);
                     h6.html(mfile[i]["normalReFileName"]);
                     $("#fileNameList_update").append(h5)
                     $("#fileReNameList_update").append(h6);
                  }
            }
         }
      });

      
   });
   
   $("#normal_updateSubmit_Btn").click(e=>{
      let normalTitle = $("#normal_update_title_").val();
      let normalContent = $("#normal_update_Content").val();
      let contentNo = $("#normalContentNo").text();
      console.log()
         
      $.ajax({
         url : "<%=request.getContextPath()%>/project/normal/updateNormalContent.do",
         type:"post",
         data:{normalTitle:normalTitle,normalContent:normalContent,contentNo:contentNo},
         success:data=>{   
            $("#normal_update_close").click();
            contentListAjax();   
            $("#normal_close_btn").click();
         },
         error:(a)=>{
            alert("실팽");
         }
      });
   });
</script>

<!-- 업무게시글 작성 모달 -->

<button style="display:none;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#insertWork_modal" id="insertWork_">업무작성</button>
<div class="modal fade" id="insertWork_modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
      <input type="hidden" id="memberId" value="<%=loginMember.getMemberId()%>">
      <input type="hidden" id="projectNo" value="<%=p.getProjectNo() %>">
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close_work_content">닫기</button>
        <button type="button" class="btn btn-primary" id="work_submit_Btn">등록</button>
      </div>
    </div>
  </div>
</div>
<!-- 업무 게시글 수정 모달 -->
<div class="modal fade" id="updateWorkModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">업무 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" id="workTitle_update">
      <span id="work_titleResult"></span>
      <div id="work_Ing_container">
         <span><i class="fas fa-history"></i></span>
         <input type="radio" value="요청" id="call" name="work_ing_update"><label for="call">요청</label>
         <input type="radio" value="진행" id="ing" name="work_ing_update"><label for="ing">진행</label>
        <input type="radio" value="피드백" id="feedback" name="work_ing_update"><label for="feedback">피드백</label>
         <input type="radio" value="보류" id="hold" name="work_ing_update"><label for="hold">보류</label>
         <input type="radio"value="완료" id="complete" name="work_ing_update"><label for="complete">완료</label>
      </div>
      <div id="work_addMember_container">
         <span><i class="fas fa-user"></i></span>
         <div><select class="form-select" id="work_addMember_update"></select></div>
         <div id="work_addMember_area_update"></div>
      </div>
      <div id="workStart_container">
         <span><i class="fas fa-calendar-plus"></i></span>
         <input type="date" id="workStart_update">
      </div>
      <div id="workEnd_container">
         <span><i class="fas fa-calendar-check"></i></span>
         <input type="date" id="workEnd_update">
      </div>
      <div id="workRank_container_update">
         <span><i class="fas fa-flag"></i></span>
          <input type="radio" value="보통" id="normal" name="work_rank_update"><label for="normal">보통</label>
          <input type="radio" value="낮음" id="row" name="work_rank_update"><label for="row">낮음</label>
          <input type="radio" value="긴급" id="emergency" name="work_rank_update"><label for="emergency">긴급</label>
          <input type="radio" value="높음" id="high" name="work_rank_update"><label for="high">높음</label>
      </div>
      
        <textarea class="form-control" placeholder="내용을 입력하세요" id="workContent_update" style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"></textarea>
      <!-- <div class="mb-3">
          <label for="formFile" class="form-label"></label>
           <input class="form-control" type="file" id="uploadWorkfile_" name="uploadWorkfile" multiple>
      </div>
       -->
      <div id="workFileNameContainer"></div>
      <input type="hidden" id="memberId" value="<%=loginMember.getMemberId()%>">
      <input type="hidden" id="projectNo" value="<%=p.getProjectNo() %>">
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close_work_content_update">닫기</button>
        <button type="button" class="btn btn-primary" id="work_update_Btn">등록</button>
      </div>
    </div>
  </div>
</div>

<script>
//업무 게시글 업데이트
//기존 값 받아오기 -> 화면에 출력해주기 -> 업무 담당자 추가 삭제
$("#updateWork_").click(e=>{
   let contentNo = $("#workContentNo").text();
   let dist = $("#workdist").text(); 

   $.ajax({
      url:"<%=request.getContextPath()%>/project/selectContentView.do",
      type:"post",
      data : {"dist":dist,"contentNo":contentNo},
      traditional : true,
      datatype:"json",
      success:data=>{
         const mfile = data["mFile"];
         const pc = data["pc"];
         const memberNameList = data["memberNameList"];
         console.log(pc);
         switch(dist){
            case '업무' : 
               $("#workTitle_update").val(pc["contentTitle"]);
               $("#workContent_update").val(pc["content"]);
               
         }
      }
   });

   
   
});


</script>


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
      <input type="hidden" id="projectNo" value="<%=p.getProjectNo()%>">
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close_sche_content">닫기</button>
        <button type="button" class="btn btn-primary" id="sche_submit_Btn">등록</button>
      </div>
    </div>
  </div>
</div>

<!-- 일정 게시글 수정 모달 -->





    
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
      <li class="nav-item"><a class="nav-link" href="#" onclick="location.assign('<%=request.getContextPath()%>/project/FileInProjectServlet.do?projectNo=<%=p.getProjectNo()%>')">파일</a></li>
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
   <div style="display: inline-block;">
      <div class="input-group mb-3"  style="width: 400px;">
            <div>
               <select class="form-select" aria-label="Default select example" style="width: 100px;" id="searchConSelect">
                  <option value="MEMBER_NAME">작성자명</option>
                  <option value="CONTENT_TITLE">게시글명</option>
               </select>
            </div>        
            <input type="text" class="form-control" placeholder="keyword" aria-label="Recipient's username" aria-describedby="button-addon2" id="searchConKeyword">
            <button class="btn btn-outline-secondary" type="button" id="searchConBtn">검색</button>
      </div>
   </div>
      <div id="filterDist" style="display: inline-block; margin-left: 5px;">
         <div class="dropdown" style="margin-left: 5px;">
              <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-filter"></i></button>
              <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                   <li>
                      <div class="form-check" style="margin-left: 8px;">
                         <input class="form-check-input" type="radio" name="selectContentRadio" checked value="게시글" id="normal_radio">
                          <label class="form-check-label" for="normal_radio">게시글</label>
                     </div>
                  </li>
                  <li>
                     <div class="form-check" style="margin-left: 8px;">
                          <input class="form-check-input" type="radio" name="selectContentRadio"  value="업무" id="work_radio">
                          <label class="form-check-label" for="work_radio">업무</label>
                     </div>
                  </li>
                  <li>
                     <div class="form-check" style="margin-left: 8px;">
                          <input class="form-check-input" type="radio" name="selectContentRadio" value="일정" id="sche_radio">
                          <label class="form-check-label" for="sche_radio">일정</label>
                     </div>
                  </li>
              </ul>
         </div>
      </div>
      <div style="display: inline-block; margin-left: 5px;">
         <button type="button" class="btn" onclick="contentListAjax();">전체보기</button>
      </div>
      
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

<!-- 게시글 삭제 모달 -->
<div class="modal fade" id="normal-delete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body">
       <div style="text-align: center;"> 정말 삭제 하시겠습니까?</div>
      </div>
      <div class="modal-footer" style="height: 50px; padding-top: 5px;padding-right: 10px; ">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" id="normal_ck_close_btn">닫기</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="normal_delComplete();">삭제</button>
      </div>
    </div>
  </div>
</div>
<!-- 업무 삭제 모달 -->
<div class="modal fade" id="work-delete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body">
       <div style="text-align: center;"> 정말 삭제 하시겠습니까?</div>
      </div>
      <div class="modal-footer" style="height: 50px; padding-top: 5px;padding-right: 10px; ">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" id="work_close_ck_btn">닫기</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="work_delComplete();">삭제</button>
      </div>
    </div>
  </div>
</div>

<!-- 일정 삭제 모달 -->
<div class="modal fade" id="sche-delete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body">
       <div style="text-align: center;"> 정말 삭제 하시겠습니까?</div>
      </div>
      <div class="modal-footer" style="height: 50px; padding-top: 5px;padding-right: 10px; ">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" id="sche_close_ck_btn">닫기</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="sche_delComplete();">삭제</button>
      </div>
    </div>
  </div>
</div>

</main>

<script>



//일정 삭제
function sche_delComplete(){
   let scheContentNo = $("#scheContentNo").text();
   $.ajax({
      url : "<%=request.getContextPath()%>/project/deleteScheContent.do",
      type:"post",
      data:{scheContentNo:scheContentNo},
      success:data=>{
         $("#sche_close_ck_btn").click();
         contentListAjax();
         $("#sche_close_btn").click();
      }
   });
}

//업무 삭제
function work_delComplete(){
   let workContentNo = $("#workContentNo").text();
   let fileArr = [];
   $("#workReFileName").find("h6").each(function(i,v){
      fileArr.push($(this).text());
   });
   
   $.ajax({
      url : "<%=request.getContextPath()%>/project/deleteWorkContent.do",
      traditional : true,
      type:"post",
      data:{workContentNo:workContentNo,fileArr:fileArr},
      success:data=>{
         $("#work_close_ck_btn").click();
         contentListAjax();
         $("#work_close_btn").click();
      }
   });
}

//게시글 삭제
function normal_delComplete(){
   let normalContentNo = $("#normalContentNo").text();
   let fileArr = [];
   $("#normalReFileName").find("h6").each(function(i,v){
      fileArr.push($(this).text());
   });
   
   
   $.ajax({
      url : "<%=request.getContextPath()%>/project/deleteNormalContent.do",
      type:"post",
      traditional : true,
      data:{normalContentNo:normalContentNo
         ,fileArr:fileArr},
      success:data=>{
         $("#normal_ck_close_btn").click();
         contentListAjax();
         $("#normal_close_btn").click();
      }
   });
}



//게시글 검색 기능
$("#searchConBtn").click(e=>{
   searchListAjax();
});


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
            contentListAjax();   
         },
         error:(a)=>{
            alert("실팽");
         }
         
      });

      }
         
   });
   
   /* 2.업무 게시글 작성 로직 */
   
   let selectedMember; //최종 선택된 멤버 이름
   let selectedManagerId; //최종 선택된 멤버 아이디
   let memberName;//현재 프로젝트에 참여중인 멤버 이름
   let managerId;// 현재 프로젝트에 참여중인 멤버 아이디
   let creatorPro = "<%=p.getMemberId()%>"; //프로젝트 생성자
   let select;
   let ophead;
   function selectAddWorkMember(){
      let projectNo = $("#projectNo").val();
      $.ajax({
         
         url : "<%=request.getContextPath()%>/project/selectAddWorkMember.do",
         type:"post",
         dataType:"json",
         data:{projectNo:projectNo},
         success:data=>{
            memberName = new Array();//현재 프로젝트에 참여중인 멤버 이름
            managerId = new Array();// 현재 프로젝트에 참여중인 멤버 아이디
            select = $("#work_addMember");
            
            ophead = $("<option>").text("담당자 추가");
            select.children().remove();
            select.append(ophead);
            
            for(let i=0;i<data.length;i++){
               memberName.push(data[i]["memberName"]);
               managerId.push(data[i]["memberId"]);
               const option = $("<option>");
               option.text(memberName[i]);
               option.val(managerId[i]);
               select.append(option);
            }
         }
      });
   }
    //일정 참석자 리스트
    let selectSche;
    let opheadSche;
   function selectAddscheMember(){
      let projectNo = $("#projectNo").val();
      $.ajax({
         
         url : "<%=request.getContextPath()%>/project/selectAddWorkMember.do",
         type:"post",
         dataType:"json",
         data:{projectNo:projectNo},
         success:data=>{
            
            memberName = new Array();//현재 프로젝트에 참여중인 멤버 이름
            managerId = new Array();// 현재 프로젝트에 참여중인 멤버 아이디
            
             selectSche = $("#sche_addMember");
            opheadSche = $("<option>").text("참석자 추가");
            
            selectSche.children().remove();
            selectSche.append(opheadSche);
            
            for(let i=0;i<data.length;i++){
               memberName.push(data[i]["memberName"]);
               managerId.push(data[i]["memberId"]);
               const option = $("<option>");
               option.text(memberName[i]);
               option.val(managerId[i]);
               selectSche.append(option);
            }
         }
      });
   }
   
   //해당 업무 관리자 리스트 .. 업무 작성시
   
   
   $("#insertWork").click(e=>{
      $("#insertWork_").click();
      selectedMember = new Array();
      selectedManagerId = new Array();
      selectAddWorkMember();
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

      $("#work_addMember").change(e=>{
         //선택된 유저 아이디 span으로 보여줌
         console.log(select.val());
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
               $("#work_addMember").find('option:first').attr('selected', 'selected');
               $("#workTitle").val("");
               $("#workStart").val("");
               $("#workEnd").val("");
               $("input[name=work_ing]").prop('checked',false);
               $("input[name=work_rank]").prop('checked',false);
               $("#workContent").val("");
               $("input[name=uploadWorkfile]").val("");   
               $("#workFileNameContainer").find("p").remove();
               $("#work_addMember_area").find("span").remove();
               workStart = document.getElementById('workStart').value= new Date().toISOString().substring(0, 10);
               workEnd = document.getElementById('workEnd').value= new Date().toISOString().substring(0, 10);
               $("#close_work_content").click();
               contentListAjax();   
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
      selectedMember = new Array();
      selectedManagerId = new Array();
      selectAddscheMember();
   });
   
   $("#sche_addMember").change(e=>{
      
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
      if($("#sche_addMember_area").find("span").text =="참석자 추가"){
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
   let scheStartDate = document.getElementById('scheStartDate').value= new Date().toISOString().substring(0, 10);
   let scheEndDate = document.getElementById('scheEndDate').value= new Date().toISOString().substring(0, 10);
   
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
               $("#searchKeyword").val("");
               $("#scheContent").val("");
               $("#sche_addMember").find('option:first').attr('selected', 'selected');
               $("#sche_addMember_area").find("span").remove();
               $("#searchResultContainer").find("p").remove();
               $("#close_sche_content").click();
               
               scheStartDate = document.getElementById('scheStartDate').value= new Date().toISOString().substring(0, 10);
               scheEndDate = document.getElementById('scheEndDate').value= new Date().toISOString().substring(0, 10);
               contentListAjax();   
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