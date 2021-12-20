package com.help.project.work.ajaxController;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.Project;
import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.Work;
import com.help.project.work.model.vo.WorkSelectManagerJoin;

/**
 * Servlet implementation class SelectWorkManagerViewServlet
 */
@WebServlet("/work/SelectWorkManagerViewServlet.do")
public class SelectWorkManagerViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectWorkManagerViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String logId=request.getParameter("logId");//로그인한아이디
		//System.out.println(logId);
		List<Project> pro=new ProjectService().selectJoin(logId);//로그인한사람이 속한 플젝정보들
		
	//	HashMap<Integer, List<Work>> myworks=new WorkService().selectWorkMine(pro,logId);//플젝번호-해당업무글들
		List<WorkSelectManagerJoin> myworks=new WorkService().selectWorkMine(pro,logId);//플젝번호-해당업무글들
		
		System.out.println(myworks+"잘 가져오니`~~~~~");
		
		
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(myworks,response.getWriter());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
