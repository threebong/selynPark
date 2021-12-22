package com.help.project.normal.model.service;

import static com.help.common.JDBCTemplate.close;
import static com.help.common.JDBCTemplate.commit;
import static com.help.common.JDBCTemplate.getConnection;
import static com.help.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.help.project.normal.model.dao.NormalDao;
import com.help.project.normal.model.vo.NormalContent;

public class NormalService {

	private NormalDao dao = new NormalDao();
	
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
	
	public int selectNormalConNo(NormalContent nc) {
		Connection conn = getConnection();

		int normalNo = dao.selectNormalConNo(conn,nc);

		close(conn);

		return normalNo;
	}

	
}
