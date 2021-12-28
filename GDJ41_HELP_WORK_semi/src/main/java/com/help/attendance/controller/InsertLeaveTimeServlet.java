package com.help.attendance.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.help.attendance.model.service.AttendanceService;
import com.help.attendance.model.vo.Attendance;
import com.help.member.model.vo.Member;

@WebServlet("/attendance/insertLeaveTime.do")
public class InsertLeaveTimeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertLeaveTimeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
		String memberId=loginMember.getMemberId();	
		
		String leaveTime = request.getParameter("leaveTime"); //퇴근시간, 등록하고 나서 시간나오고 이미 등록했을때는 등록했던 시간 나오게
		String attDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy/MM/dd")); //현재날짜
		String workTime = String.valueOf( LocalTime.of(18,  00, 00)); // 퇴근,조퇴 비교
		String attStatus = null;
		JSONObject jo = new JSONObject();

		if(leaveTime.compareTo(workTime)>=0) {
			attStatus=" / 퇴근";
		} else {
			attStatus = " / 조퇴";
		}
		int result;
		Attendance a=null;
		try {
			a = new AttendanceService().outputAttTime(memberId,attDate);
			if(a.getLeaveTime().equals("퇴근 정보가 없습니다")) {
				result = new AttendanceService().updateLeaveTime(memberId, leaveTime, attDate, attStatus);
				a = new AttendanceService().outputAttTime(memberId,attDate);
				jo.put("leaveSuccess", "퇴근 성공");
				
			} else {
				jo.put("leaveSuccess", "이미 퇴근 상태입니다.");
				
			}
			
			jo.put("leaveTime", a.getLeaveTime());
			
		} catch(NullPointerException e) {
			//업데이트, 조회가 되지 않으니 아직 해당일자 출근 데이터 없는 상태
			jo.put("leaveSuccess", "출근 전 상태입니다. 출근을 먼저 등록해주세요");
		} 
		
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(jo);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
