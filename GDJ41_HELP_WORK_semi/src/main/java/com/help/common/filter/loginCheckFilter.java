package com.help.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.help.member.model.vo.Member;

/**
 * Servlet Filter implementation class loginCheckFilter
 */
@WebFilter()
public class loginCheckFilter implements Filter {

    /**
     * Default constructor. 
     */
    public loginCheckFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		
		//1. login한 데이터를 가져와야함
				String paramUserId = request.getParameter("userId");
				
				HttpServletRequest req = (HttpServletRequest)request;
				HttpServletResponse res = (HttpServletResponse)response;
				
				HttpSession session = req.getSession();
				Member loginMember = (Member)session.getAttribute("loginMember"); 
				
				if(loginMember ==null || !(loginMember.getMemberId().equals("admin") || loginMember.getMemberId().equals(paramUserId))) {
					req.getRequestDispatcher("/").forward(req, res);
					
				}else{
					chain.doFilter(request, response);	
				}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
