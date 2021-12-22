package com.help.attendance.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

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

@WebServlet("/attendance/attendanceListEnd.do")
public class AttendanceListEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AttendanceListEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		HttpSession session=request.getSession();
//		Member loginMember=(Member)session.getAttribute("loginMember");
//		String memberId=loginMember.getMemberId();
		
		String memberId = request.getParameter("memberId");
		String month = request.getParameter("month");
//		System.out.println(month.getClass().getName());
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");

		//아이디 정보 가져와서 아이디와 일치하는 출퇴근이력 전체조회 리스트
		//월별로 나와야함 yy/MM형태로 지금은 현재달, 선택한 달의 데이터가 이쪽으로 넘어와야함
		

		List<Attendance> list = new AttendanceService().selectAttendanceMonthly(memberId, month);

		System.out.println("ajax"+list);
		if(list.isEmpty() || list==null) response.getWriter().write("조회된 데이터가 없습니다.");
		
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(list,response.getWriter());
		
//		request.setAttribute("attendanceMonthly", list);
//		request.getRequestDispatcher("/views/attendance/attendanceList.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}