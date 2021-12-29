package com.help.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.help.member.model.service.MemberService;
import com.help.member.model.vo.Member;

/**
 * Servlet implementation class FindIdServlet
 */
@WebServlet("/member/findMemberIdEnd.do")
public class FindMemberIdEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindMemberIdEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String MemberName=request.getParameter("MemberName");
		String memberPhone=request.getParameter("memberPhone");
		
		String memberId=new MemberService().findMemberId(MemberName,memberPhone);
		
		request.setAttribute("findMemberId", memberId);
		request.getRequestDispatcher("/views/member/findMemberIdResult.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
