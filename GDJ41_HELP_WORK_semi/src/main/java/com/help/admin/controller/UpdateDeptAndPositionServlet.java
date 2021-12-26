package com.help.admin.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.admin.model.service.AdminService;
import com.help.admin.model.vo.DeptAndPosition;

@WebServlet("/admin/updateDeptAndPosition.do")
public class UpdateDeptAndPositionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateDeptAndPositionServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<DeptAndPosition> deptList = new AdminService().deptAllList();
		List<DeptAndPosition> positionList = new AdminService().positionAllList();
		
		Map<Object, Object> param = Map.of("deptList",deptList,"positionList",positionList);
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(param,response.getWriter());
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
