package com.help.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.Project;
import com.help.project.model.vo.ProMemberJoinMember;

/**
 * Servlet implementation class SelectProjectDetailViewToList
 */
@WebServlet("/project/selectProjectDetailViewToList.do")
public class SelectProjectDetailViewToList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectProjectDetailViewToList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int projectNo = Integer.parseInt(request.getParameter("projectNo"));

		Project pinfo = new ProjectService().selectProjectOne(projectNo);
		
		//해당 프로젝트에 참여중인 사원 리스트
		List<ProMemberJoinMember> mList = new ProjectService().selectProjectJoinMemberList(projectNo);
	
		request.setAttribute("ProMemberJoinMember", mList);
		
		request.setAttribute("projectInfo", pinfo);
				
		request.getRequestDispatcher("/views/project/projectDetailView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
