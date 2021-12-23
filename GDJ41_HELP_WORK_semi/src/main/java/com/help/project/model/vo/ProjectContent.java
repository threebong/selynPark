package com.help.project.model.vo;

import lombok.Builder;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProjectContent {

	private int projectNo;
	private int contentNo;
	private String memberId;
	private String memberName;
	private String contentTitle;
	private String content;
	private String startDate;
	private String endDate;
	private String workIng;
	private String workRank;
	private String address;
	private String placeName;
	private int readCount;
	private String writeDate;
	private String dist;
	
	
}
