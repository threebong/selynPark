package com.help.attendance.controller;

import java.io.IOException;
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

@WebServlet("/attendance/insertAttTime.do")
public class InsertAttTimeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertAttTimeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
		String memberId=loginMember.getMemberId();
		
		
		String attTime = request.getParameter("attTime"); //현재시간

		String attDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")); //현재날짜
		String workingTime = String.valueOf(LocalTime.of(9,  00, 00)); // 출근,지각 비교시간
		String attStatus = null; // 출퇴근 상태값
		//현재날짜 출퇴근 데이터 가져오기
		
		Attendance a=null;
		JSONObject jo = new JSONObject();
		
		try {
			a = new AttendanceService().outputAttTime(memberId,attDate);
			if(a==null) {
				if(workingTime.compareTo(attTime)>=0) {
					attStatus ="출근";
				} else {
					attStatus = "지각";
				}
				int result = new AttendanceService().insertAttTime(memberId, attTime,attDate,attStatus);
				a = new AttendanceService().outputAttTime(memberId,attDate); // 등록하고 다시 조회하기
				jo.put("attTime", a.getAttTime());
				jo.put("attSuccess", "출근 성공");
				
			} else {
				jo.put("attTime", a.getAttTime());
				jo.put("attSuccess", "오늘은 이미 출근을 등록하였습니다.");
			}
		}catch(NullPointerException e) {
			e.printStackTrace();
		}

		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(jo);
		
		

	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
