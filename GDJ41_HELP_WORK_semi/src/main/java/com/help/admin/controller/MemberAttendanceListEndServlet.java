package com.help.admin.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.help.admin.model.service.AdminService;
import com.help.admin.model.vo.AdminAttendance;

@WebServlet("/admin/memberAttendanceListEnd.do")
public class MemberAttendanceListEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberAttendanceListEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//최초 현재 날짜 데이터를 보여주기 위함
		
		int cPage;
		try {
			cPage=Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
			cPage=1;
		}
		int numPerPage=10;
		String day;
		try {
			day = request.getParameter("changeDays");
		} catch(NumberFormatException e) {
			day=LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		}
		
		
		
		List<AdminAttendance> list = new AdminService().adminAttendance(day,cPage, numPerPage);
		
		int totalData = new AdminService().adminAttendanceCount(day);
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);
		
		int pageBarSize=5;
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd=pageNo+pageBarSize-1;
		
		String pageBar = "<nav aria-label=\"Page navigation example\">\r\n"
				+ "  <ul class=\"pagination\">\r\n"
				+ "    <li class=\"page-item\">";
		
		if(pageNo==1) {
			pageBar += " <a class=\"page-link\" href=\"#\" aria-label=\"Previous\">\r\n"
					+ "        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "      </a></li>";
		} else {
			pageBar+="<a class=\"page-link\" aria-label=\"Previous\" href='javascript:adminAttendanceList("+(pageNo-1)+");'><span aria-hidden=\"true\">[이전]</span></a></li>";
		}
		
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(cPage==pageNo) {
				pageBar+=" <li class=\"page-item\"><a class=\"page-link\" href=\"#\">"+pageNo+"</a></li>";
			} else {
				pageBar+="<li class=\"page-item\"><a class=\"page-link\" href='javascript:adminAttendanceList("+(pageNo)+");'>"+pageNo+"</a></li>";
			}
			pageNo++;
		}
		
		if(pageNo>totalPage) {
			pageBar+="<li class=\"page-item\">\r\n"
					+ "      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\r\n"
					+ "        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "      </a>\r\n"
					+ "    </li>\r\n"
					+ "  </ul>\r\n"
					+ "</nav>";
		} else {
			pageBar+=" <li class=\"page-item\"><a class=\"page-link\" aria-label=\"Next\" href='javascript:adminAttendanceList("+(pageNo)+");'><span aria-hidden=\"true\">&raquo;</span></a>\r\n"
					+ "    </li>\r\n"
					+ "  </ul>\r\n"
					+ "</nav>";
		}
		
		Map<String, Object> param = Map.of("pageBar",pageBar,"list",list);
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(param,response.getWriter());
	
		
		
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
