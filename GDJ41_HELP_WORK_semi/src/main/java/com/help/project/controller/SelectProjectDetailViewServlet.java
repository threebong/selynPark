package com.help.project.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.model.vo.Project;

/**
 * Servlet implementation class SelectProjectDetailViewServlet
 */
@WebServlet("/project/selectProjectDetailView.do")
public class SelectProjectDetailViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectProjectDetailViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//프로젝트 상세화면으로 보내 
		Project pinfo =  (Project)request.getAttribute("projectInfo");
		request.setAttribute("projectInfo", pinfo);
		request.getRequestDispatcher("/views/project/projectDetailView.jsp?projectNo="+pinfo.getProjectNo()).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
