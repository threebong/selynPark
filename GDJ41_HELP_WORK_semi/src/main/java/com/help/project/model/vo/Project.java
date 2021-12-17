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

	private int projectNo;
	private String memberId;
	private String proName;
	private String proExplain;
	private String proCommonYn;
	private String proIsActive;
	private Date proDate;
	
}
