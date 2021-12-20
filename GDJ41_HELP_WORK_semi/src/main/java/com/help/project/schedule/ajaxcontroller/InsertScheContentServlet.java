package com.help.project.schedule.ajaxcontroller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.schedule.model.service.ScheduleService;
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
		
		Date scheStartDate = Date.valueOf(request.getParameter("shceStart"));
		Date scheEndDate = Date.valueOf(request.getParameter("scheEndDate"));
		
		Schedule sc = Schedule.builder()
				.memberId(memberId)
				.projectNo(projectNo)
				.scheContent(scheContent)
				.scheTitle(scheTitle)
				.schePlace(schePlace)
				.schePlaceName(schePlaceName)
				.scheStartDate(scheStartDate)
				.scheEndDate(scheEndDate).build();
				
		int result = new ScheduleService().insertSchedule(sc);
		
		
		
		if(result>0) {
			//등록된 일정 번호 가져오기
			int scheduleNo = new ScheduleService().selectScheduleNo(sc);
			
			//일정 참석자는 따로 관리
			String[] scheAttendMember= request.getParameterValues("scheAttendMember");
		
			List<Map<String, Object>> saList = new ArrayList<Map<String,Object>>();
			Map<String,Object> saMap = null;
			
			for(int i=0;i<scheAttendMember.length;i++) {
				saMap =new HashMap<String,Object>();
				saMap.put("scheduleNo", scheduleNo);
				saMap.put("memberId", scheAttendMember[i]);
				
				saList.add(saMap);
			}
			
			int saResult = new ScheduleService().insertScheduleAttend(saList);
			
			if(saResult>0) {
				response.getWriter().write("게시글 작성 성공");	
			}else {
				response.getWriter().write("게시글 작성 실패");	
			}
			
		}else {
			response.getWriter().write("게시글 작성 실패");
		}
		
		
		

		
		
		
		
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
