package com.help.attendance.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.attendance.model.service.AttendanceService;

@WebServlet("/attendance/insertAttTime.do")
public class InsertAttTimeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertAttTimeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId = request.getParameter("memberId");
		//현재날짜
		String attDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		//출근시간
		String attTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
		int result = new AttendanceService().insertAttTime(memberId, attTime, attDate);
//		int result = new AttendanceService().insertAttTime(attTime, attDate);
		
		String msg="";
		String loc="";
		if(result>0) {
			msg="출근 성공";
			loc="/";
		} else {
			msg="이미 출근하였습니다.";
			loc="/";
		}
		
		request.getRequestDispatcher("/views/login.jsp").forward(request, response);

	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
