package com.help.project.normal.model.dao;

import static com.help.common.JDBCTemplate.close;

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

import com.help.project.model.dao.ProjectDao;
import com.help.project.normal.model.vo.NormalComment;
import com.help.project.normal.model.vo.NormalContent;

public class NormalDao {

private Properties prop = new Properties();
	
	public NormalDao() {
		try {
			prop.load(new FileReader(ProjectDao.class.getResource("/").getPath()+"sql/project/normal/normal_sql.properties"));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int insertNormalContnet(Connection conn, NormalContent nc) {
		//일반 게시글 작성
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



	public int insertNormalContentFile(Connection conn, List<Map<String, Object>> fileList, int normalContNo) {

		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertNormalContentFile");

		
		try {
			
			for(int i =0; i<fileList.size();i++) {
				pstmt = conn.prepareStatement(sql);
								
					pstmt.setInt(1, normalContNo);
					pstmt.setString(2,(String)fileList.get(i).get("oriName"));
					pstmt.setString(3,(String)fileList.get(i).get("newFileName"));
					pstmt.setString(4,(String)fileList.get(i).get("exts"));
					pstmt.setString(5,(String)fileList.get(i).get("filePath"));
				
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

	public int selectNormalConNo(Connection conn, NormalContent nc) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = prop.getProperty("selectNormalConNo");
		int normalNo = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nc.getProjectNo());
			pstmt.setString(2, nc.getMemberId());
			pstmt.setString(3,nc.getNormalContentTitle());
			pstmt.setString(4, nc.getNormalContentContent());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				normalNo = rs.getInt("NORMAL_CONTENT_NO");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return normalNo;
	}

	public int updateNormalContnet(Connection conn, int contentNo, NormalContent nc) {

		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateNormalContnet");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nc.getNormalContentTitle());
			pstmt.setString(2, nc.getNormalContentContent());
			pstmt.setInt(3, contentNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int insertNormalComment(Connection conn, NormalComment nc) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertNormalComment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nc.getNormalContentNo());
			pstmt.setString(2, nc.getWriterId());
			pstmt.setString(3,nc.getNormalCommentContent() );
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public List<NormalComment> selectNormalComment(Connection conn,int contentNo) {

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = prop.getProperty("selectNormalComment");
		NormalComment nc = null;
		List<NormalComment> ncList = new ArrayList<NormalComment>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, contentNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				nc = NormalComment.builder()
						.normalContentNo(rs.getInt("NORMAL_CONTENT_NO"))
						.normalCommentNo(rs.getInt("CONTENT_COMMENT_NO"))
						.writerId(rs.getString("MEMBER_ID"))
						.writerName(rs.getString("MEMBER_NAME"))
						.normalCommentContent(rs.getString("CONTENT_COMMENT_CONTENT"))
						.commentDate(new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("CONTENT_COMMENT_DATE")))
						.build();
				ncList.add(nc);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return ncList;
	}

	public int deleteNormalComment(Connection conn, int contentNo) {

		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteNormalComment");
		
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
