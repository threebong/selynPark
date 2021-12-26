package com.help.project.ajaxController;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.ProjectContent;

/**
 * Servlet implementation class SearchAllContentServlet
 */
@WebServlet("/project/searchAllContent.do")
public class SearchAllContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchAllContentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String dist = request.getParameter("dist");
		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("keyword");
		int projectNo = Integer.parseInt(request.getParameter("projectNo"));
		
		int cPage;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			cPage =1;
		}
	
		int numPerPage = 20;
		
		List<ProjectContent> pList = new ProjectService().selectSearchProjectContent(projectNo,cPage,numPerPage,searchType,keyword,dist);	
		
		int totalData = new ProjectService().selectSearchProjectContentCount(projectNo,searchType,keyword,dist);
		
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);
		
		int pageBarSize = 5;
		
		int pageNo = ((cPage-1)/pageBarSize)*pageBarSize+1;
		
		int pageEnd = pageNo+pageBarSize-1;
		
		String pageBar ="";
		
		if(pageNo==1) {//첫번째 페이지면? 이전 버튼이 눌리지 않음
			pageBar ="<span>[이전]</span>";
		}else {
			pageBar = "<a href='javascript:searchListAjax("+(pageNo-1)+");'>[이전]</a>";
		}
		
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(cPage==pageNo) {
				pageBar+="<span>"+pageNo+"</span>"; //내가 현재 보고 있는 페이지기때문에 굳이 누를 필요가 없음
			}else {
				pageBar+="<a href='javascript:searchListAjax("+(pageNo)+");'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
		if(pageNo>totalPage) {
			pageBar+="<span>[다음]</span>";
		}else {
			pageBar+="<a href='javascript:searchListAjax("+(pageNo)+");'>[다음]</a>";
		}
		

		response.setContentType("application/json; charset=utf-8");
		Map<String, Object> param = Map.of("pageBar",pageBar,"pList",pList);
		new Gson().toJson(param,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
