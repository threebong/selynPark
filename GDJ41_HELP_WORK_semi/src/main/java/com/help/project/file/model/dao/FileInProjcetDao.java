package com.help.project.file.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.help.project.file.model.vo.FileInProject;
import com.help.project.model.dao.ProjectDao;

import static com.help.common.JDBCTemplate.*;

public class FileInProjcetDao {
	private Properties prop= new Properties();
	public FileInProjcetDao() {
		try {
			prop.load(new FileReader(FileInProjcetDao.class.getResource("/").getPath()+"sql/project/file/file_sql.properties"));
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	//업무 work 파일들
	public List<FileInProject> findProWorkFile(Connection conn,int proNo){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<FileInProject> result=new ArrayList<FileInProject>();
		String sql=prop.getProperty("selectWorkFile");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, proNo);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				FileInProject p=FileInProject.builder()
						.projectNo(rs.getInt("PROJECT_NO"))
						.workNo(rs.getInt("WORK_NO"))
						.contentTitle(rs.getString("WORK_TITLE"))
						.workOriFileName(rs.getString("WORK_ORI_FILENAME"))
						.workReFileName(rs.getString("WORK_RE_FILENAME"))
						.workExt(rs.getString("WORK_EXT"))
						.workFileDate(new SimpleDateFormat("YYYY-MM-dd").format(rs.getDate("WORK_FILE_DATE")))
						.workFilePath(rs.getString("WORK_FILE_PATH"))
						.build();
				result.add(p);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	//일반 파일
	public List<FileInProject> findProNormalFile(Connection conn,int proNo){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<FileInProject> result=new ArrayList<FileInProject>();
		String sql=prop.getProperty("selectNormalFile");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, proNo);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				FileInProject p=FileInProject.builder()
						.projectNo(rs.getInt("PROJECT_NO"))
						.normalNo(rs.getInt("NORMAL_CONTENT_NO"))
						.contentTitle(rs.getString("NORMAL_CONTENT_TITLE"))
						.workOriFileName(rs.getString("NORMAL_CON_ORI_FILENAME"))
						.workReFileName(rs.getString("NORMAL_CON_RE_FILENAME"))
						.workExt(rs.getString("NORMAL_CON_EXT"))
						.workFileDate(new SimpleDateFormat("YYYY-MM-dd").format(rs.getDate("NORMAL_CON_DATE")))
						.workFilePath(rs.getString("NORMAL_CON_FILEPATH"))
						.build();
				result.add(p);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	//업무파일 키워드 검색
	public List<FileInProject> SelectWorkKeyFile(Connection conn,int proNo,String text){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<FileInProject> result=new ArrayList<FileInProject>();
		String sql=prop.getProperty("SelectWorkKeyFile");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, proNo);
			pstmt.setString(2, "%"+text+"%");
			rs=pstmt.executeQuery();
			while(rs.next()) {
				FileInProject p=FileInProject.builder()
						.projectNo(rs.getInt("PROJECT_NO"))
						.workNo(rs.getInt("WORK_NO"))
						.contentTitle(rs.getString("WORK_TITLE"))
						.workOriFileName(rs.getString("WORK_ORI_FILENAME"))
						.workReFileName(rs.getString("WORK_RE_FILENAME"))
						.workExt(rs.getString("WORK_EXT"))
						.workFileDate(new SimpleDateFormat("YYYY-MM-dd").format(rs.getDate("WORK_FILE_DATE")))
						.workFilePath(rs.getString("WORK_FILE_PATH"))
						.build();
				result.add(p);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	//일반 파일 키워드 검색
	public List<FileInProject> SelectNormalKeyFile(Connection conn,int proNo,String text){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<FileInProject> result=new ArrayList<FileInProject>();
		String sql=prop.getProperty("SelectNormalKeyFile");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, proNo);
			pstmt.setString(2, "%"+text+"%");
			rs=pstmt.executeQuery();
			while(rs.next()) {
				FileInProject p=FileInProject.builder()
						.projectNo(rs.getInt("PROJECT_NO"))
						.normalNo(rs.getInt("NORMAL_CONTENT_NO"))
						.contentTitle(rs.getString("NORMAL_CONTENT_TITLE"))
						.workOriFileName(rs.getString("NORMAL_CON_ORI_FILENAME"))
						.workReFileName(rs.getString("NORMAL_CON_RE_FILENAME"))
						.workExt(rs.getString("NORMAL_CON_EXT"))
						.workFileDate(new SimpleDateFormat("YYYY-MM-dd").format(rs.getDate("NORMAL_CON_DATE")))
						.workFilePath(rs.getString("NORMAL_CON_FILEPATH"))
						.build();
				result.add(p);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
}
