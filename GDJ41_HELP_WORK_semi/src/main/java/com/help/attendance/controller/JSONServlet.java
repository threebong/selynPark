package com.help.attendance.controller;

import static com.help.common.JDBCTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.help.attendance.model.dao.AttendanceDao;
import com.help.attendance.model.vo.Attendance;
import com.help.member.model.vo.Member;


@WebServlet("/JSONServlet")
public class JSONServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JSONServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		HttpSession session=request.getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
		String memberId=loginMember.getMemberId();
		
		
		String month = request.getParameter("selectMonth");
		Connection conn = getConnection();
		response.getWriter().write(getJSON(conn,memberId,month));
		System.out.println(memberId);
		System.out.println(month);
		
	}
	
	public String getJSON(Connection conn, String memberId, String month) {
		
		if(memberId == null) memberId="";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		AttendanceDao dao = new AttendanceDao();
		List<Attendance> list = dao.selectAttendanceMonthly(conn, memberId, month);
		for(int i=0; i<list.size(); i++) {
			result.append("[{\"value\":\""+list.get(i).getAttDate()+"\"},");
			result.append("[{\"value\":\""+list.get(i).getAttTime()+"\"},");
			result.append("[{\"value\":\""+list.get(i).getLeaveTime()+"\"},");
			result.append("[{\"value\":\""+list.get(i).getAttStatus()+"\"},");
		}
		result.append("]}");
		return result.toString();
	}
	

}
