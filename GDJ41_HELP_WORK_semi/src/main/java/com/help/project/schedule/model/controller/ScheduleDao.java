package com.help.project.schedule.model.controller;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.help.project.schedule.model.vo.Schedule;
import com.help.project.work.model.dao.WorkDao;
import static com.help.common.JDBCTemplate.*;

public class ScheduleDao {

	private Properties prop=new Properties();
	public ScheduleDao() {
		try {
			prop.load(new FileReader(WorkDao.class.getResource("/").getPath()+"sql/project/schedule/schedule_sql.properties"));
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
	
	}
	public int insertSchedule(Connection conn, Schedule sc) {
		//일정 등록
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertSchedule");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sc.getProjectNo());
			pstmt.setString(2, sc.getMemberId());
			pstmt.setString(3, sc.getScheTitle());
			pstmt.setString(4, sc.getScheContent());
			pstmt.setDate(5, sc.getScheStartDate());
			pstmt.setDate(6, sc.getScheEndDate());
			pstmt.setString(7, sc.getSchePlace());
			pstmt.setString(8,sc.getSchePlaceName());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	public int selectScheduleNo(Connection conn, Schedule sc) {
		//일정 글번호 가져오기
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		int scheduleNo = 0;
		
		String sql = prop.getProperty("selectScheduleNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,sc.getProjectNo());
			pstmt.setString(2, sc.getMemberId());
			pstmt.setString(3, sc.getScheTitle());
			pstmt.setString(4, sc.getScheContent());
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				scheduleNo = rs.getInt(1);
			}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return scheduleNo;
	}
	public int insertScheduleAttend(Connection conn, List<Map<String, Object>> saList) {
		//일정 참석자 등록
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertScheduleAttend");
		
		try {
			for(int i=0;i<saList.size();i++) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, (int)saList.get(i).get("scheduleNo"));	
				pstmt.setString(2, (String)saList.get(i).get("memberId"));
				result = pstmt.executeUpdate();
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
}
