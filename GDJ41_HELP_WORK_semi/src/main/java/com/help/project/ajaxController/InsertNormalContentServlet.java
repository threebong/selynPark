package com.help.project.ajaxController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.NormalContent;

/**
 * Servlet implementation class InsertNormalContentServlet
 */
@WebServlet("/project/insertNormalContent.do")
public class InsertNormalContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertNormalContentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String memberId = request.getParameter("memberId");
		int projectNo = Integer.parseInt(request.getParameter("projectNo"));
		
		NormalContent nc = NormalContent.builder()
				.normalContentTitle(title)
				.memberId(memberId)
				.normalContentContent(content)
				.projectNo(projectNo).build();
		
		int result = new ProjectService().insertNormalContnet(nc);
			
		if(result>0) {
			response.getWriter().write("게시글 작성 성공");
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
