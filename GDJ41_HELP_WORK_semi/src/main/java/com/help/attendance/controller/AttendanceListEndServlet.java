package com.help.attendance.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.attendance.model.service.AttendanceService;
import com.help.attendance.model.vo.Attendance;

@WebServlet("/attendance/attendanceListEnd.do")
public class AttendanceListEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AttendanceListEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String memberId = request.getParameter("memberId");
		String month =  request.getParameter("month"); 
		// yyyy-mm형태로 조회하면 db의 date타입이랑 모양 안맞아서 정상적으로 출력되지 않음
	    //파라미터는 string이라 date로 변환 후 date 모양 바꿔서 다시 string으로 변환
//		String formatMonth = "";
//	    
//		SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyy-mm");
//		SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-mm");
//		Date tempDate = null;
//			    
//		try {
//			tempDate = beforeFormat.parse(month);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		} catch(NullPointerException e) {
//			e.printStackTrace();
//		}
//			   
//		formatMonth = afterFormat.format(tempDate);

		List<Attendance> list = new AttendanceService().selectAttendanceMonthly(memberId, month);
		

		
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(list,response.getWriter());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
