package com.help.project.work.model.vo;

import java.sql.Date;

import com.help.project.model.vo.Project;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WorkSelectManagerJoin {
	private String proName;//프로젝트이름
	private int projectNo;//플젝번호
	private int workNo;//업무번호
	private String workIng;//진행상태
	private String workRank;//중요도
	private String workTitle;//업무제목
	private String memberId;//작성자
	private String managerId;//담당자
	private Date workDate;//작성일
}
	//근데이렇게 조인테이블마다 vo다 만들면 vo를 분리해서 만드는 이유가 있나...
