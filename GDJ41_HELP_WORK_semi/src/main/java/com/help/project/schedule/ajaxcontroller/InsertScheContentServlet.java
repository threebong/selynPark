package com.help.project.schedule.ajaxcontroller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.schedule.model.vo.Schedule;

/**
 * Servlet implementation class InsertScheContentServlet
 */
@WebServlet("/project/sche/insertScheContent.do")
public class InsertScheContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertScheContentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String scheTitle = request.getParameter("scheTitle");
		String scheContent =request.getParameter("scheContent");
		String schePlace = request.getParameter("shce_place_Loadaddr");
		String schePlaceName = request.getParameter("shce_place_name");
		int projectNo= Integer.parseInt(request.getParameter("projectNo"));
		String memberId= request.getParameter("memberId");
		
		
		//날짜,시간 변환
		SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
		
		Date scheStartDate = Date.valueOf(request.getParameter("shceStart"));
		Date scheEndDate = Date.valueOf(request.getParameter("scheEndDate"));
		
		String scheStartTime = request.getParameter("scheStartTime");
		String scheEndTime = request.getParameter("scheEndTime");
		
		
		System.out.println( Date.valueOf(request.getParameter("scheStartTime")));
		
		//Schedule sc = Schedule.builder()
			//	.memberId(memberId)
			//	.projectNo(projectNo)
			//	.scheContent(scheContent)
			//	.scheTitle(scheTitle)
			//	.schePlace(schePlace)
			//	.schePlaceName(schePlaceName)
			//	.scheStartTime(scheStartDate)
			//	.scheStartDate(scheStartTime)
			//	.scheEndDate(scheEndDate)
			//	.scheEndTime(scheEndTime)
				
				
		
		
		
		//일정 참석자는 따로 관리
		String scheAttendMember= request.getParameter("scheAttendMember");

		
		
		
		
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
