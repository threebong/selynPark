package com.help.member.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.help.member.model.service.MemberService;
import com.help.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class UpdateMemberServlet
 */
@WebServlet("/member/updateMember.do")
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(!ServletFileUpload.isMultipartContent(request)) {
			request.setAttribute("msg", "잘못된 요청입니다 관리자에게 문의하세요 HELP");
			request.setAttribute("loc", "/member/updateMember.do");
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
			return;
		}
		String path=request.getServletContext().getRealPath("/upfile/member/");
		int maxSize=1024*1024*20;
		
		MultipartRequest mr=new MultipartRequest(request,path,maxSize,"UTF-8",new DefaultFileRenamePolicy());
		
		Member m=Member.builder()
				.memberId(mr.getParameter("userId"))
				.memberPwd(mr.getParameter("password"))
				.memberName(mr.getParameter("userName"))
				.memberPhone(mr.getParameter("phone"))
				.build();
		
		File f=mr.getFile("upProfile");
		System.out.println(mr.getFilesystemName("upProfile"));
		if(f!=null&&f.length()>0) {
			//이전파일삭제
			File deleteProfile=new File(path+mr.getParameter("oriProfile"));
			deleteProfile.delete();
			m.setMemberProfile(mr.getFilesystemName("upProfile"));
			
		}else {
			//업로드파일이 없음
			m.setMemberProfile(mr.getParameter("oriProfile"));
		}
		
		int result=new MemberService().updateMember(m);
		if(result>0) {
			response.sendRedirect(request.getContextPath()+"/project/selectProjectMain.do");
		}else {			
			request.getRequestDispatcher("/member/viewMember.do").forward(request, response);
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
