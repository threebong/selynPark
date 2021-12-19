package com.help.attendance.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.help.attendance.model.service.AttendanceService;
import com.help.member.model.vo.Member;

@WebServlet("/attendance/insertLeaveTime.do")
public class InsertLeaveTimeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertLeaveTimeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
		String memberId=loginMember.getMemberId();		
		//현재날짜
		String attDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy/MM/dd"));
		//퇴근시간
//		String leaveTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")); 
		
		//퇴근 등록인데 아이디,날짜 조회해서 null로 들어간 퇴근시간 수정해야함
		int result = new AttendanceService().updateLeaveTime(memberId, attDate);
	
		String msg="";
		String loc="";
		if(result>0) {
			msg="퇴근 성공";
			loc="/";
		} else {
			msg="출근을 먼저 눌러야 합니다.";
			loc="/";
		}
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);

		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
