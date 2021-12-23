package com.help.project.work.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.help.common.JDBCTemplate.*;
import com.help.project.model.vo.Project;
import com.help.project.work.model.dao.WorkDao;
import com.help.project.work.model.vo.Work;
import com.help.project.work.model.vo.WorkSelectManagerJoin;

public class WorkService {
	private WorkDao dao=new WorkDao();
	
	public HashMap<Integer, List<Work>> selectWorkFive(List<Project> pro){
		//해당 프로젝트의 - 업무 게시글들 반환 (키:해당프로젝트번호/밸류:해당프로젝트의 업무게시글list)
		Connection conn = getConnection();
		HashMap<Integer, List<Work>> works=dao.selectWorkFive(conn,pro);
		close(conn);
		return works;
	}
	public List<WorkSelectManagerJoin> selectWorkMine(List<Project> pro,String logId){
		//내가 담당자인 업무들 조회
		Connection conn=getConnection();
		List<WorkSelectManagerJoin> works=dao.selectWorkMine(conn,pro,logId);
		close(conn);
		return works;
		
	}
	public List<WorkSelectManagerJoin> selectWorkMine(List<Project> pro,String logId,int cPage,int numPerPage){
		//내가 담당자인 업무들 조회----페이징 
		Connection conn=getConnection();
		List<WorkSelectManagerJoin> works=dao.selectWorkMine(conn,pro,logId,cPage,numPerPage);
		close(conn);
		return works;
		
	}
	
	public List<WorkSelectManagerJoin> searchMine(String ing,String prior,String h4,String logId,int cPage,int numPerPage){
		//다중 검색--내가 담당자인 업무들//페이징
		Connection conn=getConnection();
		List<WorkSelectManagerJoin> result=new ArrayList<WorkSelectManagerJoin>();
		
		if(h4.equals("나의업무")) {
			 result=dao.searchMine(conn,ing,prior,logId);
			 System.out.println("서비스"+result);
		}else if(h4.equals("전체업무")) {
			//해야함
			List<Integer> proNum=dao.selectProjectNo(conn, logId);
			 result=dao.searchAll(conn,ing,prior,proNum,cPage,numPerPage);
			 System.out.println("서비스"+result);
			
		}
		return result;
		
	}
	
	public List<WorkSelectManagerJoin> searchMine(String ing,String prior,String h4,String logId){
		//다중 검색--내가 담당자인 업무들//
		Connection conn=getConnection();
		List<WorkSelectManagerJoin> result=new ArrayList<WorkSelectManagerJoin>();
		
		if(h4.equals("나의업무")) {
			// result=dao.searchMine(conn,ing,prior);
			// System.out.println("서비스"+result);
		}else if(h4.equals("전체업무")) {
			//해야함
			List<Integer> proNum=dao.selectProjectNo(conn, logId);
			 result=dao.searchAll(conn,ing,prior,proNum);
			 System.out.println("서비스"+result);
			
		}
		return result;
		
	}
	public int insertWorkContent(Work w) {
		//업무 게시글 작성
		Connection conn = getConnection();
		int result = dao.insertWorkContent(conn,w);
		close(conn);

		return result;
	}

	public int selectWorkNo(Work w) {
		//등록된 업무 게시글 번호 가져오기
		Connection conn = getConnection();
		int workNo = dao.selectWorkNo(conn,w);
		close(conn);

		return workNo;
		
	}

	public int insertWorkFile(List<Map<String, Object>> fileList, int workNo) {
		//업무 파일 추가
		Connection conn = getConnection();

		int result = dao.insertWorkFile(conn, fileList,workNo);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
		
	}

	public int insertWorkManager(List<Map<String, Object>> wmList) {
		//업무 담당자 추가
		Connection conn = getConnection();
		int result = dao.insertWorkManager(conn,wmList);
		
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);

		return result;
	}
	
	public List<Integer> selectProjectNo(String logId){
		//내가 참여한 프로젝트 번호들 
		Connection conn=getConnection();
		List<Integer> result= dao.selectProjectNo(conn,logId);
		close(conn);
		return result;
	}
	
	public List<WorkSelectManagerJoin> selectWorkAll(List<Integer> proNum){
		//내가 참여한 프로젝트의 모든 업무들 ---개수구하는데 사용 
		Connection conn=getConnection();
		List<WorkSelectManagerJoin> result=dao.selectWorkAll(conn,proNum);
		close(conn);
		return result;
	}
	public List<WorkSelectManagerJoin> selectWorkAll(List<Integer> proNum,int cPage,int numPerPage){
		//내가 참여한 프로젝트의 모든 업무들 ---페이징처리 
		Connection conn=getConnection();
		List<WorkSelectManagerJoin> result=dao.selectWorkAll(conn,proNum,cPage,numPerPage);
		close(conn);
		return result;
	}
}
