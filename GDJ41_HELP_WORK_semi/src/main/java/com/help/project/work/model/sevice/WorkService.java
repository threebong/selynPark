package com.help.project.work.model.sevice;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.help.common.JDBCTemplate.*;
import com.help.project.model.vo.Project;
import com.help.project.work.model.dao.WorkDao;
import com.help.project.work.model.vo.Work;

public class WorkService {
	private WorkDao dao=new WorkDao();
	
	public HashMap<Integer, List<Work>> selectWorkFive(List<Project> pro){
		//해당 프로젝트의 - 업무 게시글들 반환 (키:해당프로젝트번호/밸류:해당프로젝트의 업무게시글list)
		Connection conn = getConnection();
		HashMap<Integer, List<Work>> works=dao.selectWorkFive(conn,pro);
		close(conn);
		return works;
	}

	public int insertWorkContent(Work w) {
		//업무 게시글 작성
		Connection conn = getConnection();
		int result = dao.insertWorkContent(conn,w);
		close(conn);

		return result;
	}

	public int selectWorkNo(Work w) {
		//등록된 업무 게시글 번호 가져오기
		Connection conn = getConnection();
		int workNo = dao.selectWorkNo(conn,w);
		close(conn);

		return workNo;
		
	}

	public int insertWorkFile(List<Map<String, Object>> fileList, int workNo) {
		//업무 파일 추가
		Connection conn = getConnection();

		int result = dao.insertWorkFile(conn, fileList,workNo);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
		
	}

	public int insertWorkManager(List<Map<String, Object>> wmList) {
		//업무 담당자 추가
		Connection conn = getConnection();
		int result = dao.insertWorkManager(conn,wmList);
		
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}
	
	
	
}
