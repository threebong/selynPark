package com.help.project.ajaxController;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileDownloadServlet
 */
@WebServlet("/project/normalfileDownload.do")
public class FileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileDownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String oriFileName = request.getParameter("normalOriFileName");
		String reFileName = request.getParameter("normalReFileName");
		
		String realFilePath = request.getServletContext().getRealPath("/upfile/normal/");
		
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(realFilePath+reFileName));
		
		String sendReName = "";
		String header = request.getHeader("User-Agent");
		boolean isMSIE = header.contains("MSIE") || header.contains("Trident");
		if(isMSIE) {
			sendReName = URLEncoder.encode(oriFileName,"UTF-8").replaceAll("\\+", "%20");
		}else {
			sendReName= new String(oriFileName.getBytes("UTF-8"),"ISO-8859-1");
		}
	
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		
		response.setContentType("application/octect-stream");
		
		response.setHeader("Content-disposition", "attachment;filename="+sendReName);
		
		int read = -1;
		
		while((read = bis.read()) != -1) {
			bos.write(read);
		}
		
		bis.close();
		bos.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
