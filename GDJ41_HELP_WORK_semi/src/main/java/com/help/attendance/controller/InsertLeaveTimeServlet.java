package com.help.attendance.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		//퇴근시간
		String leaveTime = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm"));
		//현재날짜
		String attDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy/MM/dd"));
		//퇴근, 조퇴 비교시간
		String workTime = String.valueOf( LocalTime.of(18,  00, 00));
		String attStatus = null;
		
		if(leaveTime.compareTo(workTime)>=0) {
			attStatus=" / 퇴근";
		} else {
			attStatus = " / 조퇴";
		}
		int result = new AttendanceService().updateLeaveTime(memberId, leaveTime, attDate, attStatus);
		
		//현재날짜 출퇴근데이터 가져오기
		Attendance a = new AttendanceService().outputAttTime(memberId,attDate);
		
	
		String msg="";
		String loc="";
		if(result>0) {
			msg="퇴근 성공"; 
			loc="/member/memberLogin.do";
		} else { 
			msg="이미 퇴근 상태 입니다.";
			loc="/member/memberLogin.do";
		} //다시 클릭했을때 메시지는 정상출력되나 SQLException 나옴...

	
		request.setAttribute("outputleaveTime", a);
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);

		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
