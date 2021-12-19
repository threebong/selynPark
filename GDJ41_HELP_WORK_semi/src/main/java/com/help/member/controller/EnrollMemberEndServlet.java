package com.help.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.help.member.model.service.MemberService;
import com.help.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class EnrollMemberEndServlet
 */
@WebServlet("/member/enrollMemberEnd.do")
public class EnrollMemberEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnrollMemberEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(!ServletFileUpload.isMultipartContent(request)) {
			request.setAttribute("msg", "잘못된 요청입니다 관리자에게 문의하세요 HELP");
			request.setAttribute("loc", "/member/enrollMember.do");
			request.getRequestDispatcher("views/common/msg.jsp").forward(request, response);
			return;
		}
		
		String path=request.getServletContext().getRealPath("/upload/member");
		int maxSize=1024*1024*20;
		String encode="UTF-8";
		
		MultipartRequest mr=new MultipartRequest(request,path,maxSize,encode,new DefaultFileRenamePolicy());
		
		Member m=Member.builder()
				.memberId(mr.getParameter("userId"))
				.memberPwd(mr.getParameter("password"))
				.memberName(mr.getParameter("userName"))
				.memberPhone(mr.getParameter("phone"))
				.memberProfile(mr.getFilesystemName("upProfile"))
				.build();
		
		int result=new MemberService().insertMember(m);
		String msg="";
		String loc="";
		if(result>0) {
			msg="회원가입이 완료되었습니다.";
			loc="/";
		}else {
			msg="회원가입이 실패했습니다";
			loc="/member/enrollMember.do";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
