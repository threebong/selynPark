package com.help.project.schedule.ajaxcontroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.schedule.model.service.ScheduleService;
import com.help.project.schedule.model.vo.ScheComment;

/**
 * Servlet implementation class InsertScheCommentServlet
 */
@WebServlet("/project/sche/insertScheComment.do")
public class InsertScheCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertScheCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			ScheComment sc = ScheComment.builder()
					.scheContentNo(Integer.parseInt(request.getParameter("contentNo")))
					.writerId(request.getParameter("writerId"))
					.scheCommentContent(request.getParameter("commentContent"))
					.build();
			
			new ScheduleService().insertScheCommenet(sc);
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
