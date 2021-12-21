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

import com.google.gson.Gson;
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
//		String memberId = request.getParameter("memberId");
//		String attTime = request.getParameter("attTime");
//		String attDate = request.getParameter("attDate");
//		System.out.println(attTime+","+attDate);
//		//출근시간
		String attTime = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm"));
//		//현재날짜
		String attDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		//출근,지각 비교시간
		String workingTime = String.valueOf(LocalTime.of(9,  00, 00));
		//출퇴근 상태값
		String attStatus = null;
		String msg="";
//		String loc="";
		//현재날짜 출퇴근 데이터 가져오기
		Attendance a = new AttendanceService().outputAttTime(memberId,attDate);
		if(a==null) { // a가 null이면 아직 출근 등록 전인 상태니까 출근 등록 로직
			if(workingTime.compareTo(attTime)>=0) {
				attStatus ="출근";
			} else {
				attStatus = "지각";
			}
			int result = new AttendanceService().insertAttTime(memberId, attTime,attDate,attStatus);
			if(result>0) {
				msg="출근 성공";
			} else {
				msg="출근 실패";
			}	
			a = new AttendanceService().outputAttTime(memberId,attDate); // 등록하고 다시 조회하기
		} else { //a가 null이 아니면 이미 해당일자는 출근 등록 되어있는 상태 -> 하루 한번만 등록 가능함 중복등록x
			msg="이미 출근하였습니다.";

//			loc="member/memberLogin.do";
		}

		
//		response.setContentType("application/json;charset=utf-8");
//		new Gson().toJson(a,response.getWriter());
		
		
		request.setAttribute("msg", msg);
//		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);

	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
