package com.help.project.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Project {

	private int projectNo;//프로젝트번호
	private String memberId;//프로젝트 생성자ID
	private String proName;//프로젝트명
	private String proExplain;//프로젝트설명
	private String proCommonYn;//회사공용프로젝트여부
	private String proIsActive;//활성화여부
	private Date proDate;//생성날짜
	
}
