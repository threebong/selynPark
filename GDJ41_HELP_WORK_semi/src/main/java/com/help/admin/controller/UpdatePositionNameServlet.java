package com.help.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.admin.model.service.AdminService;

@WebServlet("/admin/updatePositionName.do")
public class UpdatePositionNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdatePositionNameServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String positionCode = request.getParameter("modPositionCode");
		String positionName = request.getParameter("updatePositionName");
		System.out.println(positionCode);
		System.out.println(positionName);
		int result = new AdminService().updatePositionName(positionCode,positionName);
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
