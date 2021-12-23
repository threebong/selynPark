package com.help.project.work.ajaxController;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.model.vo.Project;
import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.WorkSelectManagerJoin;

/**
 * Servlet implementation class SelectWorkAllViewServlet
 */
@WebServlet("/work/SelectWorkAllViewServlet.do")
public class SelectWorkAllViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectWorkAllViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//업무-내가 속한 프로젝트의 - 모든 업무 게시글 출력 //페이징완료
		String id=request.getParameter("logId");
		//내가 참가한 프로젝트 번호 가져오자
		List<Integer> proNum=new WorkService().selectProjectNo(id);//로그인한 사원이 참여한 프로젝트 번호를 담은 리스트 
		
		List<WorkSelectManagerJoin> result=new WorkService().selectWorkAll(proNum);//해당프로젝트의 모든 업무(담당자제외)
		int totalData=result.size();//전체 data개수 
		System.out.println(totalData);
		//페이징 처리
		int cPage;
		try {
			cPage=Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			cPage=1;
		}
		int numPerPage=20;
		/*
		 * try { numPerPage=Integer.parseInt(request.getParameter("numPerPage"));
		 * }catch(NumberFormatException e) { numPerPage=10; }
		 */
		List<WorkSelectManagerJoin> resultPg=new WorkService().selectWorkAll(proNum,cPage,numPerPage);//페이징결과
		
		int totalPage=(int)Math.ceil((double)totalData/numPerPage);
		int pageBarSize=5;
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;//시작
		int pageEnd=pageNo+pageBarSize-1;//끝
		
		String pageBar="";
		if(pageNo==1) {
			pageBar+="<span>[이전]</span>";
		}else {
			pageBar+="<a href='javascript:workAllPaging("+(pageNo-1)+");'>[이전]</a>";
		}
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<span>"+pageNo+"</span>";	
			}else {
				pageBar+="<a href='javascript:workAllPaging("+(pageNo)+");'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar+="<span>[다음]</span>";	
		}else {
			pageBar+="<a href='javascript:workAllPaging("+(pageNo)+");'>"+"[다음]"+"</a>";
		}
		
		Map<String, Object> param=Map.of("pageBar",pageBar,"list",resultPg);
		response.setContentType("application/json;charset=utf-8");
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
