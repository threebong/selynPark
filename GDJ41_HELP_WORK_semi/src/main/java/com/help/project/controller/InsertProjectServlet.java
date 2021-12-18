package com.help.project.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.Project;

/**
 * Servlet implementation class InsertProjectServlet
 */
@WebServlet("/project/insertProject.do")
public class InsertProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertProjectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Project p = Project.builder()
					.proName(request.getParameter("proName"))
					.proExplain(request.getParameter("proExplain"))
					.proCommonYn(request.getParameter("proCommonYn")=="on"?"Y":"N")
					.memberId(request.getParameter("memberId")).
					build();
		
		int result = new ProjectService().insertProject(p);
		
		if(result>0) {
			System.out.println("프로젝트 생성 완료");
		}else {
			System.out.println("프로젝트 생성 실패");
		}
		request.getRequestDispatcher("/project/select.do").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
