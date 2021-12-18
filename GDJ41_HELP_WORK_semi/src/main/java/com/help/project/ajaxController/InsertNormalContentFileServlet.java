package com.help.project.ajaxController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.help.common.MakeFileName;
import com.help.project.model.service.ProjectService;
import com.help.project.model.vo.NormalContentFile;
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
		
		List<String> newFileNames = new ArrayList();
		List<String> oriFileNames = new ArrayList();
		List<String> exts = new ArrayList();
		
		List<Map<String,Object>> fileList = new ArrayList<Map<String,Object>>();
		Map<String,Object> fileMap = null;
		
		
		while(e.hasMoreElements()) {
			String fileName = e.nextElement();
			String oriName = mr.getOriginalFileName(fileName);
			oriFileNames.add(oriName);
			newFileNames.add(mr.getFilesystemName(fileName));
		}
		
		//List Map에 파일 원래이름, 리네임, 확장자 넣음
		for(int i=0; i<oriFileNames.size();i++) {
			
				String temp = oriFileNames.get(i).substring(oriFileNames.get(i).lastIndexOf("."));
				exts.add(temp);
		}
		
		for(int i=0; i<oriFileNames.size();i++) {
				fileMap = new HashMap<String,Object>();
				fileMap.put("oriName", oriFileNames.get(i));
				fileMap.put("newFileName", newFileNames.get(i));
				fileMap.put("exts", exts.get(i));
				fileMap.put("filePath", path+newFileNames.get(i));
				fileList.add(fileMap);
		}
		System.out.println(fileList);
		
		
		int result = new ProjectService().insertNormalContentFile(fileList);
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
