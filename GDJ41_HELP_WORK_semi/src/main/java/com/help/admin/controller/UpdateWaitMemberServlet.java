package com.help.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.admin.model.service.AdminService;

@WebServlet("/admin/updateWaitMember.do")
public class UpdateWaitMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateWaitMemberServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId=request.getParameter("memberId");
		String deptCode=request.getParameter("modDeptName");
		String positionCode=request.getParameter("modPositionName");
	
		int result = new AdminService().updateWaitMember(memberId, deptCode, positionCode);
		if(result>0) {
			System.out.println("업데이트 성공");
			
		} else {
			System.out.println("업데이트 실패");
		}
		request.getRequestDispatcher("/views/admin/memberListAll.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
