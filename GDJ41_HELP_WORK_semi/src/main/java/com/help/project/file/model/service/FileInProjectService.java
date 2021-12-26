package com.help.project.file.model.service;

import static com.help.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.help.project.file.model.dao.FileInProjcetDao;
import com.help.project.file.model.vo.FileInProject;

public class FileInProjectService {
	private FileInProjcetDao dao=new FileInProjcetDao();
	
	public List<FileInProject> findProWorkFile(int proNo){//업무파일
		Connection conn=getConnection();
		List<FileInProject> result=dao.findProWorkFile(conn,proNo);
		close(conn);
		return result;
	}
	public List<FileInProject> findProNormalFile(int proNo){//일반게시글의 파일
		Connection conn=getConnection();
		List<FileInProject> result=dao.findProNormalFile(conn,proNo);
		close(conn);
		return result;
	}
	public List<FileInProject> SelectWorkKeyFile(int proNo,String text){//업무파일명 키워드 검색
		Connection conn=getConnection();
		List<FileInProject> result=dao.SelectWorkKeyFile(conn,proNo,text);
		close(conn);
		return result;
	}
	public List<FileInProject> SelectNormalKeyFile(int proNo,String text){//일반 파일명 키워드 검색
		Connection conn=getConnection();
		List<FileInProject> result=dao.SelectNormalKeyFile(conn,proNo,text);
		close(conn);
		return result;
	}
}
