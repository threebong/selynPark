package com.help.project.ajaxController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.Project;

/**
 * Servlet implementation class SelectProjectNameMainViewServlet
 */
@WebServlet("/project/SelectProjectNameMainViewServlet.do")
public class SelectProjectNameMainViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectProjectNameMainViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//프로젝트 메인 화면에서 검색하는 기능입니다
		String memId=(String)request.getParameter("memId");//로그인한 아이디
		String searchText=(String)request.getParameter("searchText").trim().replace(" ", "");//입력한 검색어
		String searchKey=(String)request.getParameter("searchKey");//찾을 카테고리
		List<Project> result=new ArrayList<Project>();
		if(searchKey.equals("projectTitle")) {//프로젝트이름 으로 검색
			result=new ProjectService().selectSearchProName(memId,searchText);
		}else if(searchKey.equals("ProjectMember")) {//프로젝트 생성자
			result=new ProjectService().selectSearchProMemberName(memId,searchText);
		}else if(searchKey.equals("ProjectNo")) {//프로젝트 번호
			result=new ProjectService().selectSearchProNumber(memId,searchText);
		}
		System.out.println(result);
		System.out.print(memId+"입력글자"+searchText+searchKey);
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
