package com.help.project.model.service;

import com.help.member.model.vo.Member;
import com.help.project.model.dao.ProjectDao;
import com.help.project.model.vo.Project;
import com.help.project.model.vo.ProjectAddMember;
import com.help.project.model.vo.ProjectContent;
import com.help.project.model.vo.ScheAttendName;
import com.help.project.model.vo.WorkFile;
import com.help.project.model.vo.WorkManagerName;
import com.help.project.schedule.model.vo.ScheduleAttend;
import com.help.project.work.model.vo.WorkManager;
import com.help.project.model.vo.NormalFile;
import com.help.project.model.vo.ProMemberJoinMember;

import static com.help.common.JDBCTemplate.getConnection;
import static com.help.common.JDBCTemplate.close;
import static com.help.common.JDBCTemplate.commit;
import static com.help.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;

import java.util.Map;

public class ProjectService {

	private ProjectDao dao = new ProjectDao();

	public int insertProject(Project p) {
		Connection conn = getConnection();
		int result = dao.insertProject(conn, p);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	public List<Project> selectJoin(String memId) {// 로그인한 사원이 참여한 모든 프로젝트
		Connection conn = getConnection();
		List<Project> join = dao.selectJoin(conn, memId);
		close(conn);
		return join;
	}

	public HashMap<Integer, Integer> selectJoinNumber(HashMap peopleNum){
		//프로젝트 번호랑..임의의값 넘겨서 찾아올거임 .. 참가자수를
		Connection conn=getConnection();
		HashMap<Integer,Integer> result=dao.selectJoinNumber(conn,peopleNum);
		close(conn);
		return result;

	}

	

	public Project selectProjectNewinsert() {

		Connection conn = getConnection();

		Project pinfo = dao.selectProjectNewinsert(conn);

		close(conn);

		return pinfo;
	}

	public int insertProMemberCreator(Project pinfo) {
		Connection conn = getConnection();

		int result = dao.insertProMemberCreator(conn, pinfo);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public Project selectProjectOne(int projectNo) {
		
		Connection conn = getConnection();

		Project pinfo = dao.selectProjectOne(conn,projectNo);

		close(conn);

		return pinfo;
	}
	

	

	public List<ProMemberJoinMember> selectProjectJoinMemberList(int projectNo) {
		
		Connection conn = getConnection();
		List<ProMemberJoinMember> mList= dao.selectProjectJoinMemberList(conn,projectNo);
		close(conn);
		return mList;
	}

	public int selectProjectNo(Project pinfo) {
		
		Connection conn = getConnection();
		int projectNo = dao.selectProjectNo(conn,pinfo);
		close(conn);
		return projectNo;
	}

	public List<ProjectAddMember> selectAllMember() {
		Connection conn = getConnection();
		List <ProjectAddMember> mAllList = dao.selectAllMember(conn);
		close(conn);
		
		return mAllList;
	}

	public int insertProMember(List<Map<String, Object>> mList) {
		//프로젝트 사원 초대
		Connection conn = getConnection();

		int result = dao.insertProMember(conn, mList);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public List<ProjectAddMember> selectSearchMember(String searchType, String keyword) {
		Connection conn = getConnection();
		List <ProjectAddMember> searchMemberList = dao.selectSearchMember(conn,searchType,keyword);
		close(conn);
		
		return searchMemberList;
	}

	public List<ProjectContent> selectAllProjectContent(int projectNo, int cPage, int numPerPage) {
		

		Connection conn = getConnection();
		List <ProjectContent> ProjectContentList = dao.selectAllProjectContent(conn,projectNo,cPage,numPerPage);
		close(conn);
		
		return ProjectContentList;
		
	}

	public int selectAllProjectContentCount(int projectNo) {
		Connection conn = getConnection();
		int result = dao.selectAllProjectContentCount(conn,projectNo);
		close(conn);
		return result;
	}

	public ProjectContent selectContentOne(String dist, int contentNo,boolean isRead) {
		
		Connection conn = getConnection();
		ProjectContent pc = dao.selectContentOne(conn,dist,contentNo);
		
		if(pc != null  && !isRead) {
			int result =0;
			if(dist.equals("게시글")){
				result = dao.insertNormalReadCount(conn,contentNo);	
			}else if(dist.equals("업무")) {
				result = dao.insertWorkReadCount(conn,contentNo);
			}else {
				result = dao.insertScheReadCount(conn,contentNo);
			}
			
			if (result > 0) {
				commit(conn);
				pc = dao.selectContentOne(conn,dist,contentNo);
			} else {
				rollback(conn);
			}
		}
		
		close(conn);
		return pc;
	}

	public List<WorkManagerName> selectWorkManager(int contentNo) {
		// 업무 담당자 가져오기
		Connection conn = getConnection();
		List <WorkManagerName> wmList = dao.selectWorkManager(conn,contentNo);
		close(conn);
		
		return wmList;
	}

	public List<ScheAttendName> selectScheAttendName(int contentNo) {
		Connection conn = getConnection();
		List <ScheAttendName> saList = dao.selectScheAttendName(conn,contentNo);
		close(conn);
		
		return saList;
	}

	public List<ProjectContent> selectSearchProjectContent(int projectNo, int cPage, int numPerPage, String searchType,String keyword,String dist) {
		
		Connection conn = getConnection();
		List <ProjectContent> pList = dao.selectSearchProjectContent(conn,projectNo,cPage,numPerPage,searchType,keyword,dist);
		close(conn);
		
		return pList;
	}

	public int selectSearchProjectContentCount(int projectNo,String searchType,String keyword,String dist) {
		Connection conn = getConnection();
		int result = dao.selectSearchProjectContentCount(conn,projectNo,searchType,keyword,dist);
		close(conn);
		return result;
	}

	public List<NormalFile> selectNormalFile(int contentNo, String dist) {
		//일반 게시글 파일명 가져오기
		Connection conn = getConnection();
		List<NormalFile> mFile = dao.selectNormalFile(conn,contentNo,dist);
		close(conn);
		return mFile;
	}

	public List<WorkFile> selectWorklFile(int contentNo, String dist) {
		//업무 게시글 파일명 가져오기
			Connection conn = getConnection();
			List<WorkFile> wFile = dao.selectWorklFile(conn,contentNo,dist);
			close(conn);
			return wFile;
	}

	public int deleteNormalContent(int normalContentNo) {
		// 일반 게시글 삭제
		Connection conn = getConnection();
		int result = dao.deleteNormalContent(conn,normalContentNo);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int deleteWorkContent(int workContentNo) {
		// 업무 게시글 삭제
				Connection conn = getConnection();
				int result = dao.deleteWorkContent(conn,workContentNo);
				if (result > 0) {
					commit(conn);
				} else {
					rollback(conn);
				}
				close(conn);
				
				return result;
	}

	public int deleteScheContent(int scheContentNo) {
		// 일정 게시글 삭제
		Connection conn = getConnection();
		int result = dao.deleteScheContent(conn,scheContentNo);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	/*
	 * public void insertNormalReadCount(int contentNo) { //일반 게시글 조회수 Connection
	 * conn = getConnection(); int result =
	 * dao.insertNormalReadCount(conn,contentNo);
	 * 
	 * if (result > 0) { commit(conn); } else { rollback(conn); } close(conn);
	 * 
	 * }
	 */
	
}
