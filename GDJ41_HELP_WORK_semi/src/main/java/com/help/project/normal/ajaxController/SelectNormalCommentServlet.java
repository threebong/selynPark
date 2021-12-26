package com.help.project.normal.ajaxController;

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

/**
 * Servlet implementation class SelectNormalCommentServlet
 */
@WebServlet("/project/normal/selectNormalComment.do")
public class SelectNormalCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectNormalCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int contentNo = Integer.parseInt(request.getParameter("contentNo"));
		
		List<NormalComment> ncList = new NormalService().selectNormalComment(contentNo);
		
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(ncList,response.getWriter());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
