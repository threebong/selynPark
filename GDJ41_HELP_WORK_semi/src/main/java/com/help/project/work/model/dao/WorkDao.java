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
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import static com.help.common.JDBCTemplate.*;
import com.help.project.model.vo.Project;
import com.help.project.work.model.vo.Work;
import com.help.project.work.model.vo.WorkSelectManagerJoin;


public class WorkDao {
	private Properties prop=new Properties();
	public WorkDao() {
		try {
			prop.load(new FileReader(WorkDao.class.getResource("/").getPath()+"sql/project/work/work_sql.properties"));
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
	
	public List<WorkSelectManagerJoin> selectWorkMine(Connection conn,List<Project> pro,String logId){
		//내가 담당자인 업무들만 
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		//HashMap<Integer, List<Work>> works=new HashMap<Integer, List<Work>>();
		List<WorkSelectManagerJoin> works=new ArrayList<WorkSelectManagerJoin>();
		String sql=prop.getProperty("selectWorkMine");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, logId);
			for(Project p:pro) {
				pstmt.setInt(2, p.getProjectNo());
				rs=pstmt.executeQuery();
				while(rs.next()) {
					
					WorkSelectManagerJoin wo=WorkSelectManagerJoin.builder()
							.proName(rs.getString("PRO_NAME"))
							.projectNo(rs.getInt("PROJECT_NO"))
							.workNo(rs.getInt("WORK_NO"))
							.projectNo(rs.getInt("PROJECT_NO"))
							.workIng(rs.getString("WORK_ING"))
							.workRank(rs.getString("WORK_RANK"))
							.workTitle(rs.getString("WORK_TITLE"))
							.memberId(rs.getString("MEMBER_ID"))
							.managerId(rs.getString("MANAGER_ID"))
							.workDate(rs.getDate("WORK_DATE"))
							.build();
					System.out.print(wo);
					works.add(wo);
				}
				//works.put(p.getProjectNo(), w);//플젝번호-해당업무들
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return works;
	}
	
	
	
}
