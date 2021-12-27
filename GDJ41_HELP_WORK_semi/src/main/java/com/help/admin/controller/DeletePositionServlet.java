package com.help.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.admin.model.service.AdminService;

@WebServlet("/admin/deletePosition.do")
public class DeletePositionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeletePositionServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String positionCode = request.getParameter("deletePositionCode");
		System.out.println(positionCode);
		int result = new AdminService().deletePosition(positionCode);
		if(result>0) {
			System.out.println("직급 삭제완료");
		} else {
			System.out.println("직급 삭제실패");
		}
		request.getRequestDispatcher("/views/admin/deptAndPositionList.jsp").forward(request, response);

	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
