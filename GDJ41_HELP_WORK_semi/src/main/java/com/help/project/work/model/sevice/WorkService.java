package com.help.project.work.model.sevice;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;

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
	
	
	
}
