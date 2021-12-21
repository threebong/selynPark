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
public class ScheduleAttend {

	private int scheMemberNo;
	private int scheDuleNo;
	private String memberId;
	private String scheIsAttend;
	
}
