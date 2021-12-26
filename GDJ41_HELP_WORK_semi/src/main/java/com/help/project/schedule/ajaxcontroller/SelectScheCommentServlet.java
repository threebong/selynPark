package com.help.project.schedule.ajaxcontroller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.normal.model.service.NormalService;
import com.help.project.normal.model.vo.NormalComment;
import com.help.project.schedule.model.service.ScheduleService;
import com.help.project.schedule.model.vo.ScheComment;

/**
 * Servlet implementation class SelectScheCommentServlet
 */
@WebServlet("/project/sche/selectScheComment.do")
public class SelectScheCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectScheCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int contentNo = Integer.parseInt(request.getParameter("contentNo"));
		
		List<ScheComment> scList = new ScheduleService().selectScheComment(contentNo);
		
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(scList,response.getWriter());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
