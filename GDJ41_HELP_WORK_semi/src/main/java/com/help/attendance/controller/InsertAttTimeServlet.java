package com.help.attendance.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.help.attendance.model.service.AttendanceService;
import com.help.attendance.model.vo.Attendance;
import com.help.member.model.vo.Member;

@WebServlet("/attendance/insertAttTime.do")
public class InsertAttTimeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertAttTimeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
		String memberId=loginMember.getMemberId();
	
		//현재날짜
		String attDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yy/MM/dd"));
		
		Attendance a = new AttendanceService().outputAttTime(memberId,attDate);
		String msg="";
		String loc="";
		if(a==null) {
			int result = new AttendanceService().insertAttTime(memberId);
			System.out.println(result);
			if(result>0) {
				a = new AttendanceService().outputAttTime(memberId,attDate);
				msg="출근 성공";
				loc="/member/memberLogin.do";
			} else {
				msg="이미 출근하였습니다.";
				loc="/member/memberLogin.do";
			}	
		} else {
			request.setAttribute("outputAttTime", a);
			loc="/member/memberLogin.do";
		}
	
		//등록되고 하루동안 저장 -> 다시 누르면 이미 출근버튼 클릭하였씁니다.
		//저장된 시간이 09시보다 작으면 '출근' 크면 '지각'
		System.out.println(a);
		System.out.println(memberId);
		System.out.println(attDate);
		request.setAttribute("outputAttTime", a);
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);

	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
