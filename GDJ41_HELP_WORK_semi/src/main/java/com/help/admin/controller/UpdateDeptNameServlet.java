package com.help.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.admin.model.service.AdminService;

@WebServlet("/admin/updateDeptName.do")
public class UpdateDeptNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateDeptNameServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String deptCode = request.getParameter("modDeptCode");
		String deptName = request.getParameter("updateDeptName");
		System.out.println(deptCode);
		System.out.println(deptName);
		int result = new AdminService().updateDeptName(deptCode,deptName);
		if(result>0) {
			System.out.println("업데이트 성공");
			
		} else {
			System.out.println("업데이트 실패");
		}
		request.getRequestDispatcher("/views/admin/deptAndPositionList.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
