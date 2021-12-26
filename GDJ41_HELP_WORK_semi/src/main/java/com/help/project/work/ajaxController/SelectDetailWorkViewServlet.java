package com.help.project.work.ajaxController;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.WorkDetailJoin;

/**
 * Servlet implementation class SelectDetailWorkViewServlet
 */
@WebServlet("/project/SelectDetailWorkViewServlet.do")
public class SelectDetailWorkViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectDetailWorkViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//Work All - 상세화면 띄워주기 
		
		int proNo=Integer.parseInt(request.getParameter("proNo"));//프로젝트 번호
		int workNo=Integer.parseInt(request.getParameter("workNo"));//업무 번호
		
		WorkDetailJoin temp=null;
		//프로젝트 번호 --> 해당 프로젝트의 정보 : 프로젝트 번호/제목/프로젝트 등록일
		WorkDetailJoin temp1=new WorkService().workDetailProject(proNo,temp);
		//업무 번호 --> 업무 정보 : 업무 제목/내용/시작일/마감일/진행상태/우선순위 
		WorkDetailJoin temp2=new WorkService().workDetailWork(workNo,temp1);
		//       --> 업무 작성자 : 업무 작성자 id를 이름으로 가져오기 
		WorkDetailJoin temp3=new WorkService().workDetailWriter(workNo,temp2);
		//		--> 업무 담당자 : 여러명! 리스트로 가져와 
		WorkDetailJoin temp4=new WorkService().workDetailManager(workNo,temp3);
		System.out.println("상세화면 서블릿:"+temp4);//확인출력용
		//값은 받아왔음 
		
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(temp4,response.getWriter());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
