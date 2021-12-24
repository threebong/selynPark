package com.help.admin.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.admin.model.service.AdminService;
import com.help.admin.model.vo.AdminAttendance;

@WebServlet("/admin/memberAttendanceList.do")
public class MemberAttendanceListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberAttendanceListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//최초 현재 날짜 데이터를 보여주기 위함
		String day=LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		
		List<AdminAttendance> list = new AdminService().adminAttendanceFirst(day);
		System.out.println(day);
		System.out.println(list);
		
		request.setAttribute("attendanceDay", list);
		request.getRequestDispatcher("/views/admin/memberAttendanceList.jsp").forward(request, response);
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
