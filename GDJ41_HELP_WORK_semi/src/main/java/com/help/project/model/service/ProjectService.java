package com.help.project.model.service;

import com.help.project.model.dao.ProjectDao;
import com.help.project.model.vo.NormalContent;
import com.help.project.model.vo.Project;
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

	public int insertNormalContnet(NormalContent nc) {
		Connection conn = getConnection();
		int result = dao.insertNormalContnet(conn, nc);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	public int insertNormalContentFile(List<Map<String, Object>> fileList, int normalContNo) {
		Connection conn = getConnection();

		int result = dao.insertNormalContentFile(conn, fileList,normalContNo);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	public Project selectProjectNewinsert() {

		Connection conn = getConnection();

		Project pinfo = dao.selectProjectNewinsert(conn);

		close(conn);

		return pinfo;
	}

	public void insertProMemberCreator(Project pinfo) {
		Connection conn = getConnection();

		int result = dao.insertProMemberCreator(conn, pinfo);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

	}

	public Project selectProjectOne(int projectNo) {
		
		Connection conn = getConnection();

		Project pinfo = dao.selectProjectOne(conn,projectNo);

		close(conn);

		return pinfo;
	}
	

	public int selectNormalConNo(NormalContent nc) {
		Connection conn = getConnection();

		int normalNo = dao.selectNormalConNo(conn,nc);

		close(conn);

		return normalNo;
	}

}
