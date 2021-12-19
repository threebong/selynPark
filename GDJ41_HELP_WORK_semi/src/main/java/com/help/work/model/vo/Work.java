package com.help.work.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Work {
	private int workNo;
	private int projectNo;
	private String memberId;
	private String workTitle;
	private String workContent;
	private Date workStartDate;
	private Date workEndDate;
	private String workIng;
	private String workRank;
	private int workReadcount;
	private Date workDate;
}
