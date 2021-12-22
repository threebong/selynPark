package com.help.project.work.ajaxController;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import com.help.project.work.model.service.WorkService;
import com.help.project.work.model.vo.Work;
import com.help.project.work.model.vo.WorkManager;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class InsertWorkContentServlet
 */
@WebServlet("/project/work/insertWorkContent.do")
public class InsertWorkContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertWorkContentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String path = request.getServletContext().getRealPath("/upfile/work/");
		MultipartRequest mr = new MultipartRequest(request, path,1024*1024*10,"UTF-8",new MakeFileName());
		
		String workTitle = mr.getParameter("workTitle");
		String workIng = mr.getParameter("workIng");
		//업무 담당자는 따로 관리
		//String workManagers = mr.getParameter("")
		String workStart = mr.getParameter("workStart");
		String workEnd = mr.getParameter("workEnd");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date workStartDate = Date.valueOf(workStart);
		Date workEndDate =Date.valueOf(workEnd);
		
		String workRank = mr.getParameter("workRank");
		
		String workContent = mr.getParameter("workContent");
		int projectNo = Integer.parseInt(mr.getParameter("projectNo"));
		String memberId = mr.getParameter("memberId");
		
		Work w = Work.builder()
				.projectNo(projectNo)
				.memberId(memberId)
				.workTitle(workTitle)
				.workContent(workContent)
				.workStartDate(workStartDate)
				.workEndDate(workEndDate)
				.workIng(workIng)
				.workRank(workRank)
				.build();
		
		
		int result = new WorkService().insertWorkContent(w);
		
		
		
		
		
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
				
				
				int workNo = new WorkService().selectWorkNo(w);
				
				if(result>0) {
					//게시글 작성 성공시 파일 업로드, 매니저 추가
					//업무 담당자 추가하기
					
					String[] workManager = mr.getParameter("workManagers").split(",");
					//업무 담당자가 있으면? 추가 / 없으면 파일만 추가
					
					
					if(workManager!= null && workManager.length>0) {
						List<Map<String,Object>> wmList = new ArrayList<Map<String,Object>>();
						Map<String,Object> wmMap = null;
						
						
						for(int i=0;i<workManager.length;i++) {
							wmMap =new HashMap<String,Object>();
							wmMap.put("workNo", workNo);
							wmMap.put("managerId", workManager[i]);
							wmList.add(wmMap);
						}
						
						int manaResult = new WorkService().insertWorkManager(wmList);
						
						int fileResult = new WorkService().insertWorkFile(fileList,workNo);
						
						if(fileResult>0 && manaResult>0) {
							response.getWriter().write("게시글 작성 성공");	
						}else {
							response.getWriter().write("게시글 작성 실패");	
						}
					}else {
						int fileResult = new WorkService().insertWorkFile(fileList,workNo);
						if(fileResult>0) {
							response.getWriter().write("게시글 작성 성공");	
						}else {
							response.getWriter().write("게시글 작성 실패");	
						}
					}
					
				}else {
					response.getWriter().write("게시글 작성 실패");
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
