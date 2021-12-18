//package com.help.attendance.controller;
//
//import java.io.IOException;
//import java.util.Date;
//import java.util.List;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.help.attendance.model.service.AttendanceService;
//import com.help.attendance.model.vo.Attendance;
//
//@WebServlet("/attendance/attendanceList.do")
//public class AttendanceListServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    public AttendanceListServlet() {
//        super();
//    }
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String userId = request.getParameter("userId"); //아이디값 가져오고
////		Date attendance = request.getParameter("attendance"); 
////		Date leaveWork = request.getParameter("leaveWork"); //얘네는 출,퇴근버튼 누를때 보내야겠군...
////		
////		List<Attendance> result = new AttendanceService().selectAttendanceAll(userId);
//		//근태관리 객체 생성 -> 근태관리서비스의 근태관리조회 메서드(아이디를 매개변수로)
//		
//		//월별로 나와야함.... 조회는 전체를 다 가져오고 화면에서 월별 클릭시 출력되게끔?
//		//이거도 페이징처리니까?
////		request.setAttribute("attendanceList", result); //key값 만들어주고 jsp에 전달
//		
//		
//		request.getRequestDispatcher("/views/attendance/attendanceList.jsp").forward(request, response);
//	
//	}
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		doGet(request, response);
//	}
//
//}
