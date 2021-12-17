package com.help.member.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.help.member.model.vo.Member;
import static com.help.common.JDBCTemplate.close;

public class MemberDao {
	
	private Properties prop=new Properties();
	
	public MemberDao() {
		String path=MemberDao.class.getResource("/sql/member/member_sql.properties").getPath();
		try {
			prop.load(new FileReader(path));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public Member login(Connection conn,String userId,String password) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Member m=null;
		String sql=prop.getProperty("selectMember");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, password);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				m=Member.builder()
						.memberId(rs.getString("MEMBER_ID"))
						.deptCode(rs.getString("DEPT_CODE"))
						.positionCode(rs.getString("POSITION_CODE"))
						.memberPwd(rs.getString("MEMBER_PWD"))
						.memberPhone(rs.getString("MEMBER_PHONE"))
						.memberProfile(rs.getString("MEMBER_PROFILE"))
						.memberName(rs.getString("MEMBER_NAME"))
						.memberUseYn(rs.getString("MEMBER_USE_YN"))
						.build();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return m;
	}
}
