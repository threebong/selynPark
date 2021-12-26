package com.help.project.normal.ajaxController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.normal.model.service.NormalService;
import com.help.project.normal.model.vo.NormalComment;

/**
 * Servlet implementation class InsertNormalCommentServlet
 */
@WebServlet("/project/normal/insertNormalComment.do")
public class InsertNormalCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertNormalCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		NormalComment nc = NormalComment.builder()
				.normalContentNo(Integer.parseInt(request.getParameter("contentNo")))
				.writerId(request.getParameter("writerId"))
				.normalCommentContent(request.getParameter("commentContent"))
				.build();
		
		int result = new NormalService().insertNormalComment(nc);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
