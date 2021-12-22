package com.help.project.model.service;

import com.help.member.model.vo.Member;
import com.help.project.model.dao.ProjectDao;
import com.help.project.model.vo.Project;
import com.help.project.model.vo.ProjectAddMember;
import com.help.project.model.vo.ProjectContent;
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

}
