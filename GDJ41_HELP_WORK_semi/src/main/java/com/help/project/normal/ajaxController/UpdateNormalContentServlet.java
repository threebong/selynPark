package com.help.project.normal.ajaxController;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.common.MakeFileName;
import com.help.project.normal.model.service.NormalService;
import com.help.project.normal.model.vo.NormalContent;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class UpdateNormalContentServlet
 */
@WebServlet("/project/normal/updateNormalContent.do")
public class UpdateNormalContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateNormalContentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

				
		int contentNo = Integer.parseInt(request.getParameter("contentNo"));
		String title = request.getParameter("normalTitle");
		String content = request.getParameter("normalContent");
				
		
		NormalContent nc = NormalContent.builder()
				.normalContentTitle(title)
				.normalContentContent(content)
				.build();
		
		int result = new NormalService().updateNormalContnet(contentNo,nc);
		
		if(result>0) {
			
		}else {
			
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
