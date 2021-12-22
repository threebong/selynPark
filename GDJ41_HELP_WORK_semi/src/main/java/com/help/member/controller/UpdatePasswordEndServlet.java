package com.help.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.member.model.service.MemberService;
import com.help.member.model.vo.Member;

/**
 * Servlet implementation class UpdatePasswordEndServlet
 */
@WebServlet("/member/updatePasswordEnd.do")
public class UpdatePasswordEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePasswordEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String userId=request.getParameter("userId");
		String curPassword=request.getParameter("password");
		
		//현재 비밀번호가 맞는지 확인
		Member m=new MemberService().login(userId,curPassword);
		String msg="";
		String loc="";
		if(m!=null) {
			String newPassword=request.getParameter("password_new");
			//현재 비밀번호가 일치
			int result=new MemberService().updatePassword(userId,newPassword);
			if(result>0) {
				msg="비밀번호 변경 완료";
				request.setAttribute("script", "opener.location.href='"+request.getContextPath()+"/member/logoutMember.do';close();");
			}else {
				msg="비밀번호 변경 실패";
				loc="/member/updatePassword.do?userId="+userId;
			}
		}else {
			msg="현재 비밀번호가 일치하지 않습니다.";
			loc="/member/updatePassword.do?userId="+userId;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/views/common/msg.jsp")
		.forward(request, response);
	
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
