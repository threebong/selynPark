package com.help.project.work.model.dao;

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
import java.util.Map.Entry;
import java.util.Properties;

import static com.help.common.JDBCTemplate.*;
import com.help.project.model.vo.Project;
import com.help.project.work.model.vo.Work;


public class WorkDao {
	private Properties prop=new Properties();
	public WorkDao() {
		try {
			prop.load(new FileReader(WorkDao.class.getResource("/").getPath()+"sql/work/work_sql.properties"));
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	public HashMap<Integer, List<Work>> selectWorkFive(Connection conn,List<Project> pro){
		//키값: 해당 사원이 참여하고 있는 프로젝트 번호 
		//밸류: 그 프로젝트번호에 해당하는 업무 게시글 list
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		HashMap<Integer, List<Work>> worksAll=new HashMap<Integer, List<Work>>();
		String sql=prop.getProperty("selectWorkFive");
		try {
			pstmt=conn.prepareStatement(sql);
			for(Project p: pro) {
				pstmt.setInt(1, p.getProjectNo());
				//System.out.println(p.getProjectNo());
				rs=pstmt.executeQuery();
				List<Work> works=new ArrayList<Work>();
				while(rs.next()) {
					Work w=Work.builder()
							.workNo(rs.getInt("WORK_NO"))
							.projectNo(rs.getInt("PROJECT_NO"))
							.memberId(rs.getString("MEMBER_ID"))
							.workTitle(rs.getString("WORK_TITLE"))
							.workContent(rs.getString("WORK_CONTENT"))
							.workStartDate(rs.getDate("WORK_START_DATE"))
							.workEndDate(rs.getDate("WORK_END_DATE"))
							.workIng(rs.getString("WORK_ING"))
							.workRank(rs.getString("WORK_RANK"))
							.workReadcount(rs.getInt("WORK_READCOUNT"))
							.workDate(rs.getDate("WORK_DATE"))
							.build();
					works.add(w);
				}
				worksAll.put(p.getProjectNo(), works);
				
			
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			
			close(rs);
			close(pstmt);
		}return worksAll;
	}
	
	
	
	
}
