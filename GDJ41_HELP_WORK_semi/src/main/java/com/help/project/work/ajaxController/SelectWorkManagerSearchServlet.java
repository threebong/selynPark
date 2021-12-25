package com.help.project.work.ajaxController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.WorkSelectManagerJoin;

/**
 * Servlet implementation class SelectWorkManagerSearchServlet
 */
@WebServlet("/work/SelectWorkManagerSearchServlet.do")
public class SelectWorkManagerSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectWorkManagerSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//본인업무 조건 선택해서 조회하기 
		String ing=request.getParameter("ing").trim().replace(" ","");//진행상황(요청,진행,피드백,완료,보류)
		String prior=request.getParameter("prior").trim().replace(" ", "");//우선순위(긴급,높음,보통,낮음)
		String h4=request.getParameter("h4").trim().replace(" ", "");
		String logId=request.getParameter("logId");
		
		//전체 개수 구하기 
		List<WorkSelectManagerJoin> result=new WorkService().searchMine(ing, prior, h4,logId);
		int totalData=result.size();//전체 데이터 개수 
		
		int cPage;
		try {
			cPage=Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			cPage=1;
		}
		int numPerPage = 20;
		
		//페이징 처리해서 가져온 목록
		List<WorkSelectManagerJoin> resultList=new WorkService().searchMine(ing, prior, h4,logId,cPage,numPerPage);
		
		int totalPage=(int)Math.ceil((double)totalData/numPerPage);
		int pageBarSize=5;
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;//시작
		int pageEnd=pageNo+pageBarSize-1;//끝
		
		String pageBar="";
		if(pageNo==1) {
			pageBar+="<span>[이전]</span>";
		}else {
			pageBar+="<a href='javascript:workMinePaging("+(pageNo-1)+");'>[이전]</a>";
		}
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<span>"+pageNo+"</span>";	
			}else {
				pageBar+="<a href='javascript:workMinePaging("+(pageNo)+");'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar+="<span>[다음]</span>";	
		}else {
			pageBar+="<a href='javascript:workMinePaging("+(pageNo)+");'>"+"[다음]"+"</a>";
		}
		
		
		
		System.out.println("나의업무 선탹"+resultList);
		
		
		Map<String, Object> param=Map.of("pageBar",pageBar,"list",resultList);
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(param,response.getWriter());
		//List<WorkSelectManagerJoin> searchMine=new WorkService().serchMine(ing,prior,h4);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
