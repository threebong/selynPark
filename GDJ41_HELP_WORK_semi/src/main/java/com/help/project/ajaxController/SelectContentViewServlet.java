package com.help.project.ajaxController;

import java.io.IOException;
import java.util.Arrays;
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
import com.help.project.model.vo.ScheAttendName;
import com.help.project.model.vo.WorkManagerName;

/**
 * Servlet implementation class SelectContentViewServlet
 */
@WebServlet("/project/selectContentView.do")
public class SelectContentViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectContentViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String dist = request.getParameter("dist");
		int contentNo =Integer.parseInt(request.getParameter("contentNo"));
		
		ProjectContent pc = new ProjectService().selectContentOne(dist,contentNo);
		
		
		response.setContentType("application/json; charset=utf-8");
		
		Map<String, Object> param = null;
		
		//업무 담당자 가져오기
		if(dist.equals("업무")) {
			List<WorkManagerName> wmList = new ProjectService().selectWorkManager(contentNo);
			param = Map.of("memberNameList",wmList,"pc",pc);
			new Gson().toJson(param,response.getWriter());
		}else if(dist.equals("일정")) {
			List<ScheAttendName> saList = new ProjectService().selectScheAttendName(contentNo);
			param = Map.of("memberNameList",saList,"pc",pc);
			new Gson().toJson(param,response.getWriter());
		}else {
			System.out.println(pc);
			new Gson().toJson(pc,response.getWriter());
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
