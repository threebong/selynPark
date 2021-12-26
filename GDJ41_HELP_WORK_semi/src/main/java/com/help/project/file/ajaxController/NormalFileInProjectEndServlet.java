package com.help.project.file.ajaxController;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.file.model.service.FileInProjectService;
import com.help.project.file.model.vo.FileInProject;

/**
 * Servlet implementation class NormalFileInProjectEndServlet
 */
@WebServlet("/project/NormalFileInProjectEndServlet.do")
public class NormalFileInProjectEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NormalFileInProjectEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//ajax로 처리 
		//파일 목록들 띄워줄거야 
			//2) 일반파일 
			int proNo=Integer.parseInt(request.getParameter("proNo"));
			//해당 프로젝트의 모든 파일들 
			List<FileInProject> result=new FileInProjectService().findProNormalFile(proNo);
			
			
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
