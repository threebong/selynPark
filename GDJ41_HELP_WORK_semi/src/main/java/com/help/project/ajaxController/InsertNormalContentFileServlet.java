package com.help.project.ajaxController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.common.MakeFileName;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class InsertNormalContentFileServlet
 */
@WebServlet("/project/insertNormalContentFile.do")
public class InsertNormalContentFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertNormalContentFileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String path = request.getServletContext().getRealPath("/upfile/normal/");
		MultipartRequest mr = new MultipartRequest(request,path,1024*1024*10,"UTF-8",new MakeFileName());
		
		//다중으로 업로드된 파일명 가져오기

		Enumeration<String> e = mr.getFileNames();
		List<String> newFileName = new ArrayList();
		List<String> oriFileName = new ArrayList();
		
		
		while(e.hasMoreElements()) {
			String fileName = e.nextElement();
			String oriName = mr.getOriginalFileName(fileName);
			oriFileName.add(oriName);
			newFileName.add(mr.getFilesystemName(fileName));
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
