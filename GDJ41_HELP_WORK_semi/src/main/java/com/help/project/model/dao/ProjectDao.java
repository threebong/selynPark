package com.help.project.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import static com.help.common.JDBCTemplate.close;

import com.help.project.model.vo.NormalContent;
import com.help.project.model.vo.Project;

public class ProjectDao {

	private Properties prop = new Properties();
	
	public ProjectDao() {
		try {
			prop.load(new FileReader(ProjectDao.class.getResource("/").getPath()+"sql/project/project_sql.properties"));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		
	
	
	public int insertProject(Connection conn, Project p) {

		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertProject");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p.getMemberId());
			pstmt.setString(2, p.getProName());
			pstmt.setString(3, p.getProExplain());
			pstmt.setString(4, p.getProCommonYn());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
		
	}



	public int insertNormalContnet(Connection conn, NormalContent nc) {

		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertNormalContnet");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, nc.getProjectNo());
			pstmt.setString(2, nc.getMemberId());
			pstmt.setString(3, nc.getNormalContentTitle());
			pstmt.setString(4, nc.getNormalContentContent());
			
			result =pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

}
