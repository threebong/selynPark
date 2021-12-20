package com.help.project.schedule.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Schedule {
	
	private int scheduleNo;
	private int projectNo;
	private String memberId;
	private String scheTitle;
	private String scheContent;
	private Date scheStartDate;
	private Date scheEndDate;
	private String schePlace;
	private int scheReadCount;
	private String schePlaceName;
	private Date scheDate;
		
	
	
}
