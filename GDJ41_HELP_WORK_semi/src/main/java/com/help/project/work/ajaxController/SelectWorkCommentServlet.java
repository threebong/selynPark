package com.help.project.work.ajaxController;

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
import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.WorkComment;

/**
 * Servlet implementation class SelectWorkCommentServlet
 */
@WebServlet("/project/work/selectWorkComment.do")
public class SelectWorkCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectWorkCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		int contentNo = Integer.parseInt(request.getParameter("contentNo"));
		
		List<WorkComment> wcList = new WorkService().selectWorkComment(contentNo);
		
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(wcList,response.getWriter());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
