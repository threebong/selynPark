package com.help.project.ajaxController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.model.service.ProjectService;

/**
 * Servlet implementation class SelectProMemberCountServlet
 */
@WebServlet("/project/SelectProMemberCountServlet.do")
public class SelectProMemberCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectProMemberCountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//해당 프로젝트의 참여자 수를 구해줍니다
		int proNo=Integer.parseInt(request.getParameter("proNo"));//플젝번호
		int result=new ProjectService().proMemberCount(proNo);//해당 프로젝트의 참여자 번호
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(result,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
