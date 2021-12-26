package com.help.project.work.ajaxController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.WorkComment;

/**
 * Servlet implementation class InsertWorkCommentServlet
 */
@WebServlet("/project/work/insertWorkComment.do")
public class InsertWorkCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertWorkCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//업무 댓글 등록
		WorkComment wc = WorkComment.builder()
				.workNo(Integer.parseInt(request.getParameter("contentNo")))
				.writerId(request.getParameter("writerId"))
				.workCommentContent(request.getParameter("commentContent"))
				.build();
		new WorkService().insertWorkComment(wc);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
