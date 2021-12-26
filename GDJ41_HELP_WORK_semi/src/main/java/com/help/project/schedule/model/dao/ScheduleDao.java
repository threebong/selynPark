package com.help.project.schedule.model.dao;

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
import java.util.Map;
import java.util.Properties;

import com.help.project.normal.model.vo.NormalComment;
import com.help.project.schedule.model.vo.ScheComment;
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
	public int updateScheContent(Connection conn, Schedule s, int contentNo) {
		//일정 수정
		
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateScheContent");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s.getScheTitle());
			pstmt.setString(2, s.getScheContent());
			pstmt.setDate(3, s.getScheStartDate());
			pstmt.setDate(4, s.getScheEndDate());
			pstmt.setInt(5, contentNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	public int insertScheCommenet(Connection conn, ScheComment sc) {
		//일정 댓글 등록
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertScheCommenet");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sc.getScheContentNo());
			pstmt.setString(2, sc.getWriterId());
			pstmt.setString(3,sc.getScheCommentContent());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;

		
		
	}
	public List<ScheComment> selectScheComment(Connection conn, int contentNo) {

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = prop.getProperty("selectScheComment");
		ScheComment sc = null;
		List<ScheComment> scList = new ArrayList<ScheComment>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, contentNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				sc = ScheComment.builder()
						.scheContentNo(rs.getInt("SCHEDULE_NO"))
						.scheCommentNo(rs.getInt("SCHE_COMMENT_NO"))
						.writerId(rs.getString("MEMBER_ID"))
						.writerName(rs.getString("MEMBER_NAME"))
						.scheCommentContent(rs.getString("SCHE_COMMENT_CONTENT"))
						.commentDate(new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("SCHE_COMMENT_DATE")))
						.build();
				scList.add(sc);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return scList;
	}
	public int deleteScheComment(Connection conn, int contentNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteScheComment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, contentNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
}
