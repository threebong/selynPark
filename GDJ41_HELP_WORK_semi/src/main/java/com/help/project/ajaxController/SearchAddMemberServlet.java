package com.help.project.ajaxController;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.ProMemberJoinMember;
import com.help.project.model.vo.ProjectAddMember;

/**
 * Servlet implementation class SearchAddMemberServlet
 */
@WebServlet("/project/searchAddMember.do")
public class SearchAddMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchAddMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("searchKeyword");
		
		List<ProjectAddMember> searchMemberList = new ProjectService().selectSearchMember(searchType,keyword);
		
		//이미 프로젝트에 참여중인 사원 제외하기..
				//프로젝트 참여 사원 다 가져와서 비교? 후 최종으로 리스트에 넣어주기
				//비교대상 : 프로젝트 번호, 사원 번호
				//프로젝트 번호 가져오기
				int projectNo = Integer.parseInt(request.getParameter("projectNo"));
				//프로젝트 참여자 목록
				List<ProMemberJoinMember> proMemberList = new ProjectService().selectProjectJoinMemberList(projectNo);
				
				//프로젝트에 참여중인 사원을 제외한 최종으로 보낼 회원 목록
			
				for(int i=0;i<proMemberList.size();i++) {
					for(int j=0;j<searchMemberList.size();j++) {
						if(proMemberList.get(i).getMemberId().equals(searchMemberList.get(j).getMemberId())) {
							searchMemberList.remove(j);
							break;
						}	
					}
				}
		
		
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(searchMemberList,response.getWriter());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
