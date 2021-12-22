package com.help.project.ajaxController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.project.model.service.ProjectService;

/**
 * Servlet implementation class AddProjectMemberServlet
 */
@WebServlet("/project/addProjectMember.do")
public class AddProjectMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProjectMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//프로젝트 참여 인원 추가
		int projectNo = Integer.parseInt(request.getParameter("projectNo"));
		String[] memberId = request.getParameterValues("addMemberArr[]");
		
		List<Map<String,Object>> mList = new ArrayList<Map<String,Object>>();
		Map<String, Object> mMap = null;
				
		for(int i=0;i<memberId.length;i++) {
			mMap = new HashMap<String, Object>();
			mMap.put("projectNo", projectNo);
			mMap.put("memberId", memberId[i]);
			mList.add(mMap);
		}
				
		int result = new ProjectService().insertProMember(mList);
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
