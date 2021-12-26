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
 * Servlet implementation class SelectNormalFileInProjectServlet
 */
@WebServlet("/project/SelectWorkFileInProjectServlet.do")
public class SelectWorkFileInProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectWorkFileInProjectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
 //업무 파일 키워드로 찾기 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int proNo=Integer.parseInt(request.getParameter("proNo"));
		String text=request.getParameter("text").trim().replace(" ", "");
		
		//업무 파일 키워드로 검색해오기 
		List<FileInProject> result=new FileInProjectService().SelectWorkKeyFile(proNo,text);
		
		
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
