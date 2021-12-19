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
	
		//출근시간
		String attTime = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm"));
		//현재날짜
		String attDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		//출근,지각 비교시간
		String workingTime = String.valueOf(LocalTime.of(9,  00, 00));
		//출퇴근 상태값
		String attStatus = null;
		String msg="";
		String loc="";
		//현재날짜 출퇴근 데이터 가져오기
		//현재날짜에 등록된게 없을때
//		if(a==null) { sqlexection 뜸
		if(workingTime.compareTo(attTime)>=0) {
			attStatus ="출근";
		} else {
			attStatus = "지각";
		}
		int result = new AttendanceService().insertAttTime(memberId, attTime,attDate,attStatus);
//		} 
		//출근 등록하고 다시 데이터 가져오기
		Attendance a = new AttendanceService().outputAttTime(memberId,attDate);
		if(result>0) {
			msg="출근 성공";
			loc="/project/selectProjectMain.do";
		} else {
			//이건.....세션에 하루 저장???
			msg="이미 출근하였습니다.";
			loc="/project/selectProjectMain.do";
		}	
		
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		System.out.println(sdf.format(a.getAttTime()));
		
		request.setAttribute("outputAttTime", a);
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);

	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
