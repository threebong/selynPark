package com.help.project.work.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import com.help.member.model.vo.Member;

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
	private ArrayList<String> join;
	
}
