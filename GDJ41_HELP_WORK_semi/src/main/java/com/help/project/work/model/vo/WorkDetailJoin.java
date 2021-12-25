package com.help.project.work.model.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WorkDetailJoin {
	private String proName;//프로젝트 이름
	private String proDate;//프로젝트 날짜 
	
	private int workNo;//업무번호
	private String workTitle;//업무 이름
	private String workContent;//업무 내용
	private String startDate;//업무 시작일
	private String endDate;//업무 마감일
	private String workIng;//업무 상태
	private String workRank;//업무 우선순위 
	
	private String workName;//업무 작성자 이름 (id..memberm테이블이랑조인)
	private List<String> workManager;//업무 담당자 (여러명) ..(업무번호..tb_work_manager랑조인)
	
}
