package com.help.project.ajaxController;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.NormalFile;
import com.help.project.model.vo.ProjectContent;
import com.help.project.model.vo.ScheAttendName;
import com.help.project.model.vo.WorkFile;
import com.help.project.model.vo.WorkManagerName;
import com.help.project.normal.model.service.NormalService;

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
		
		Cookie[] cookies = request.getCookies();
		boolean isRead = false;
		String readContentNo ="";
		
		if (cookies != null) {
			for (Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue(); // 게시글번호 저장
				if (name.equals("readContentNo")) {// 조회한 게시물이 있다.
					readContentNo = value; //조회했던 게시물 저장하기
					if (value.contains("|"+ contentNo+"|")) {
						isRead = true;
						break;
					}
				}
			}
		} 

		if(!isRead) {
			//이 게시글을 읽지 않았다면
			Cookie c = new Cookie("readContentNo",readContentNo+"|"+contentNo+"|");
			c.setMaxAge(24*60*60); //1일동안 유지
			response.addCookie(c);
		}
		
		ProjectContent pc = new ProjectService().selectContentOne(dist,contentNo,isRead);
		
		response.setContentType("application/json; charset=utf-8");
		
		Map<String, Object> param = null;
		
		//업무 담당자 가져오기
		if(dist.equals("업무")) {
			List<WorkManagerName> wmList = new ProjectService().selectWorkManager(contentNo);
			//파일 가져오기
			List<WorkFile> wFile = new ProjectService().selectWorklFile(contentNo,dist);		
			param = Map.of("memberNameList",wmList,"pc",pc,"mFile",wFile);
			new Gson().toJson(param,response.getWriter());
		}else if(dist.equals("일정")) {
			List<ScheAttendName> saList = new ProjectService().selectScheAttendName(contentNo);
			param = Map.of("memberNameList",saList,"pc",pc);
			new Gson().toJson(param,response.getWriter());
		}else if(dist.equals("게시글")){
			List<NormalFile> mFile = new ProjectService().selectNormalFile(contentNo,dist);		
			param = Map.of("mFile",mFile,"pc",pc);
			new Gson().toJson(param,response.getWriter());
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
