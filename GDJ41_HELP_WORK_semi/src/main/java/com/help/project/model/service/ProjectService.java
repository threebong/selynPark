package com.help.project.model.service;

import com.help.project.model.dao.ProjectDao;
import com.help.project.model.vo.NormalContent;
import com.help.project.model.vo.Project;
import static com.help.common.JDBCTemplate.getConnection;
import static com.help.common.JDBCTemplate.close;
import static com.help.common.JDBCTemplate.commit;
import static com.help.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;


public class ProjectService {

	
	private ProjectDao dao = new ProjectDao();
	
	public int insertProject(Project p) {
		Connection conn = getConnection();
		int result = dao.insertProject(conn,p);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	public int insertNormalContnet(NormalContent nc) {
		Connection conn = getConnection();
		int result = dao.insertNormalContnet(conn,nc);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	public int insertNormalContentFile(List<Map<String, Object>> fileList) {
		Connection conn = getConnection();
		int result = dao.insertNormalContentFile(conn,fileList);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);

		return result;
	}

	
	
	
}
