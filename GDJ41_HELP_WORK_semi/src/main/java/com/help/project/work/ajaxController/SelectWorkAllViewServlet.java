package com.help.project.work.ajaxController;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.model.vo.Project;
import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.WorkSelectManagerJoin;

/**
 * Servlet implementation class SelectWorkAllViewServlet
 */
@WebServlet("/work/SelectWorkAllViewServlet.do")
public class SelectWorkAllViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectWorkAllViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//업무-내가 속한 프로젝트의 - 모든 업무 게시글 출력
		String id=request.getParameter("logId");
		//내가 참가한 프로젝트 번호 가져오자
		List<Integer> proNum=new WorkService().selectProjectNo(id);//로그인한 사원이 참여한 프로젝트 번호를 담은 리스트 
		System.out.println(id+proNum);
		
		List<WorkSelectManagerJoin> result=new WorkService().selectWorkAll(proNum);//해당프로젝트의 모든 업무(담당자제외)
		System.out.println(result);
		
		
		
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(result,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
