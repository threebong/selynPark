package com.help.project.work.ajaxController;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.Work;

/**
 * Servlet implementation class UpdateWorkContentServlet
 */
@WebServlet("/project/work/updateWorkContent.do")
public class UpdateWorkContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateWorkContentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Work w = Work.builder()
				.workTitle(request.getParameter("workTitle"))
				.workContent(request.getParameter("workContent"))
				.workStartDate(Date.valueOf(request.getParameter("startDate")))
				.workEndDate(Date.valueOf(request.getParameter("endDate")))
				.workRank(request.getParameter("workRank"))
				.workIng(request.getParameter("workIng"))
				.build();
		int contentNo = Integer.parseInt(request.getParameter("contentNo"));
		int result = new WorkService().updateWorkContent(w,contentNo);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
