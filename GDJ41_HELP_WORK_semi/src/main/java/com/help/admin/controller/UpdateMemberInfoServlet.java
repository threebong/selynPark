package com.help.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.admin.model.service.AdminService;

@WebServlet("/admin/updateMemberInfo.do")
public class UpdateMemberInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateMemberInfoServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId=request.getParameter("memberId");
		String memberName=request.getParameter("memberName");
		String deptCode=request.getParameter("modDeptName2");
		String positionCode=request.getParameter("modPositionName2");
		String memberPhone=request.getParameter("modPhone");
		
		int result = new AdminService().updateInfoMember(memberId, memberName, deptCode, positionCode, memberPhone);
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
