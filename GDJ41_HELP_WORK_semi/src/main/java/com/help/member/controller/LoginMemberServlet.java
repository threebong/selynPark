package com.help.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import com.help.member.model.service.MemberService;
import com.help.member.model.vo.Member;

/**
 * Servlet implementation class LoginMemberServlet
 */
@WebServlet("/member/memberLogin.do")
public class LoginMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인		
		String memberId=request.getParameter("memberId");
		String memberPwd=request.getParameter("memberPwd");
		
		Member m=new MemberService().login(memberId,memberPwd);

		//아이디값 저장하기
		String saveId=request.getParameter("saveId");
		
		if(saveId!=null) {
			Cookie c=new Cookie("saveId",memberId);
			c.setMaxAge(24*60*60*7);
			response.addCookie(c);
		}else {
			Cookie c=new Cookie("saveId",memberId);
			c.setMaxAge(0);
			response.addCookie(c);			
		}
		System.out.println(memberId);
		System.out.println(memberPwd);
		
		if(m!=null) {
			HttpSession session=request.getSession();
			session.setAttribute("loginMember", m);
			response.sendRedirect(request.getContextPath()+"/project/selectProjectMain.do");
		}else {			
			response.sendRedirect(request.getContextPath());
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
