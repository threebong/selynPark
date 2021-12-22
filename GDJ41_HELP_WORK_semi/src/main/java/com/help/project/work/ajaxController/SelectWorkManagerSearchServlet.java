package com.help.project.work.ajaxController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.WorkSelectManagerJoin;

/**
 * Servlet implementation class SelectWorkManagerSearchServlet
 */
@WebServlet("/work/SelectWorkManagerSearchServlet.do")
public class SelectWorkManagerSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectWorkManagerSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//본인업무 조건 선택해서 조회하기 
		String ing=request.getParameter("ing").trim().replace(" ","");//진행상황(요청,진행,피드백,완료,보류)
		String prior=request.getParameter("prior").trim().replace(" ", "");//우선순위(긴급,높음,보통,낮음)
		String h4=request.getParameter("h4").trim().replace(" ", "");
		String logId=request.getParameter("logId");
		
		
		List<WorkSelectManagerJoin> result=new ArrayList<WorkSelectManagerJoin>();
		//if(!ing.equals("진행상황")||!prior.equals("우선순위")) {
			result=new WorkService().searchMine(ing, prior, h4,logId);
			System.out.println("받아?"+result);
		//}
		
		
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(result,response.getWriter());
		//List<WorkSelectManagerJoin> searchMine=new WorkService().serchMine(ing,prior,h4);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
