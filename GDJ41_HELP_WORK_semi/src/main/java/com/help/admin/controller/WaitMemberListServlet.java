package com.help.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.admin.model.service.AdminService;
import com.help.admin.model.vo.AdminListMember;

@WebServlet("/admin/waitMemberListEnd.do")
public class WaitMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public WaitMemberListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<AdminListMember> list = new AdminService().waitMemberAll();
	
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(list,response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
