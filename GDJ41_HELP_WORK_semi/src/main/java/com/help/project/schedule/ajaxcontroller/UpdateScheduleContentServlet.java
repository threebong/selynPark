package com.help.project.schedule.ajaxcontroller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.schedule.model.service.ScheduleService;
import com.help.project.schedule.model.vo.Schedule;

/**
 * Servlet implementation class UpdateScheduleContentServlet
 */
@WebServlet("/project/schedule/updateScheduleContent.do")
public class UpdateScheduleContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateScheduleContentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Schedule s = Schedule.builder()
				.scheTitle(request.getParameter("scheTitle"))
				.scheContent(request.getParameter("scheContent"))
				.scheStartDate(Date.valueOf(request.getParameter("scheStartDate")))
				.scheEndDate(Date.valueOf(request.getParameter("scheEndDate")))
				.build();
		int contentNo = Integer.parseInt(request.getParameter("contentNo"));
		
		new ScheduleService().updateScheContent(s,contentNo);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
