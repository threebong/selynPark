package com.help.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.admin.model.service.AdminService;

@WebServlet("/admin/updateMemberAttendance.do")
public class UpdateMemberAttendanceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateMemberAttendanceServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String memberName=request.getParameter("memberName");
		String memberId=request.getParameter("memberId");
		String attTime=request.getParameter("attTime");
		String leaveTime=request.getParameter("leaveTime");
		String attStatus=request.getParameter("attStatus");
		String attDate=request.getParameter("attDate");
		
		String msg ="";
		String loc ="";
		int result = new AdminService().updateAttendance(attTime, leaveTime, attStatus, memberId, attDate);
		if(result>0) {
			System.out.println("업데이트 성공");
			
		} else {
			System.out.println("업데이트 실패");
		}
		request.getRequestDispatcher("/views/admin/memberAttendanceList.jsp").forward(request, response);
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
