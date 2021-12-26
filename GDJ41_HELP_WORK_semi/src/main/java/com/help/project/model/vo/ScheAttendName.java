package com.help.project.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ScheAttendName {
	
	private int scheduleNo;
	private String memberId;
	private String memberName;
	

}
