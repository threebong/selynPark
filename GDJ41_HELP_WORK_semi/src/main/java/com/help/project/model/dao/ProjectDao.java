package com.help.project.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

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
	
	
	public List<Project> selectJoin(Connection conn,String memId){
		//로그인한 사원이 참여한 모든 프로젝트
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Project> result=new ArrayList<Project>();
		//Project p=null;
		String sql=prop.getProperty("selectJoinProject");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Project p=Project.builder()
						.projectNo(rs.getInt("PROJECT_NO"))
						.memberId(rs.getString("MEMBER_ID"))
						.proName(rs.getString("PRO_NAME"))
						.proExplain(rs.getString("PRO_EXPLAIN"))
						.proCommonYn(rs.getString("PRO_COMMON_YN"))
						.proIsActive(rs.getString("PRO_ISACTIVE"))
						.proDate(rs.getDate("PRO_DATE"))
						.build();
				System.out.print(p);
				result.add(p);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
//	public int joinProjectNumber(Connection conn,List join,String memId) {
//		//로그인한 사원이 참가한 프로젝트의 총 참여인원
//		PreparedStatement pstmt=null;
//		int joinNum=0;
//		String sql=prop.getProperty("joinProjectNumber");
//		return joinNum;
//	}
	public HashMap<Integer, Integer> selectJoinNumber(Connection conn,HashMap<Integer,Integer> peopleNum){
		//키:프로젝트번호 밸류:해당프로젝트 참가자수 해서 반환함 
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		HashMap<Integer,Integer> result= peopleNum;
		String sql=prop.getProperty("joinProjectNumber");
		try {
			pstmt=conn.prepareStatement(sql);
			for(Entry<Integer, Integer> entry: peopleNum.entrySet()) {
				pstmt.setInt(1, entry.getKey());
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result.put(entry.getKey(), rs.getInt("COUNT(*)"));
				}
			}
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
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



	public int insertNormalContentFile(Connection conn, List<Map<String, Object>> fileList) {

		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertNormalContentFile");

		
		try {
			
			for(int i =0; i<fileList.size();i++) {
				pstmt = conn.prepareStatement(sql);
								
					pstmt.setString(1,(String)fileList.get(i).get("oriName"));
					pstmt.setString(2,(String)fileList.get(i).get("newFileName"));
					pstmt.setString(3,(String)fileList.get(i).get("exts"));
					pstmt.setString(4,(String)fileList.get(i).get("filePath"));
			
				pstmt.executeUpdate();
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		if(result == fileList.size()) {
			return 1;
		}else {
			return 0;	
		}
	}

}
