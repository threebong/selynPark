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
 * Servlet implementation class SelectAllProjectContentServlet
 */
@WebServlet("/project/selectAllProjcetContent.do")
public class SelectAllProjectContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectAllProjectContentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//페이징
		
		int cPage;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			cPage =1;
		}
	
		int numPerPage = 20;
		int projectNo = Integer.parseInt(request.getParameter("projectNo"));
		
		
		
		List<ProjectContent> pList = new ProjectService().selectAllProjectContent(projectNo,cPage,numPerPage);	
		
		int totalData = new ProjectService().selectAllProjectContentCount(projectNo);
		
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);
		
		int pageBarSize = 5;
		
		int pageNo = ((cPage-1)/pageBarSize)*pageBarSize+1;
		
		int pageEnd = pageNo+pageBarSize-1;
		
		String pageBar ="<nav aria-label=\"Page navigation example\">\r\n"
				+ "  <ul class=\"pagination\">\r\n"
				+ "    <li class=\"page-item\">";
		
		if(pageNo==1) {//첫번째 페이지면? 이전 버튼이 눌리지 않음
			pageBar +=" <a class=\"page-link\" href=\"#\" aria-label=\"Previous\">\r\n"
					+ "        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "      </a></li>";
		}else {
			pageBar += "<a class=\"page-link\" aria-label=\"Previous\" href='javascript:contentListAjax("+(pageNo-1)+");'><span aria-hidden=\"true\">[이전]</span></a></li>";
		}
		
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(cPage==pageNo) {
				pageBar+=" <li class=\"page-item\"><a class=\"page-link\" href=\"#\">"+pageNo+"</a></li>"; //내가 현재 보고 있는 페이지기때문에 굳이 누를 필요가 없음
			}else {
				pageBar+="<li class=\"page-item\"><a class=\"page-link\" href='javascript:contentListAjax("+(pageNo)+");'>"+pageNo+"</a></li>";
			}
			pageNo++;
		}
		
		if(pageNo>totalPage) {
			pageBar+="<li class=\"page-item\">\r\n"
					+ "      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\r\n"
					+ "        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "      </a>\r\n"
					+ "    </li>\r\n"
					+ "  </ul>\r\n"
					+ "</nav>";
		}else {
			pageBar+=" <li class=\"page-item\"><a class=\"page-link\" aria-label=\"Next\" href='javascript:contentListAjax("+(pageNo)+");'><span aria-hidden=\"true\">&raquo;</span></a>\r\n"
					+ "    </li>\r\n"
					+ "  </ul>\r\n"
					+ "</nav>";
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
