package com.help.project.work.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.Project;

import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.Work;

/**
 * Servlet implementation class SelectWorkMainView
 */
@WebServlet("/work/SelectWorkMainView.do")
public class SelectWorkMainView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectWorkMainView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//All Work버튼 누르면 화면전환 
		String logId=request.getParameter("logId");//로그인한 아이디
		System.out.println(logId);
		//로그인한 아이디가 속한 프로젝트 정보들 
		List<Project> pro=new ProjectService().selectJoin(logId);
		request.setAttribute("logProject", pro);//로그인한 아이디가 속한 프로젝트 정보들
		
		//최신 게시글  
		//**페이징처리 아직 안함 몇개보여주지
		HashMap<Integer, List<Work>> works=new WorkService().selectWorkFive(pro);
		request.setAttribute("workInPro", works);//해당 프로젝트의 업무 게시글들 
		
		request.getRequestDispatcher("/views/work/workView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
