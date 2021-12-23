package com.help.admin.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.help.admin.model.vo.AdminListMember;
import static com.help.common.JDBCTemplate.close;


public class AdminDao {
	
	private Properties prop = new Properties();

		public AdminDao() {
		
		try {
			String path=AdminDao.class.getResource("/sql/admin/admin_sql.properties").getPath();
			prop.load(new FileReader(path));
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
		
		
	public List<AdminListMember> memberAll(Connection conn, int cPage, int numPerPage){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AdminListMember> list = new ArrayList();
		
		try {
			pstmt = conn.prepareStatement(prop.getProperty("memberAll"));
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				AdminListMember alm = AdminListMember.builder()
						.memberName(rs.getString("MEMBER_NAME"))
						.memberId(rs.getString("MEMBER_ID"))
						.deptName(rs.getString("DEPT_NAME"))
						.positionName(rs.getString("POSITION_NAME"))
						.memberPhone(rs.getString("MEMBER_PHONE"))
						.build();
				list.add(alm);
			}
			
			
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
		
	}
	
	
	
	public int MemberAllCount(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		String sql = prop.getProperty("memberAllCount");
		
		try {
			
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
			
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			
		} return result;

	}
	

}
