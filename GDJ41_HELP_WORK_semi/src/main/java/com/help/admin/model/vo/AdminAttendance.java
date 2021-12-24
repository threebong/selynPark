package com.help.admin.model.vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AdminAttendance {
	private String memberName;
	private String memberId;
	private String deptName;
	private String positionName;
	private String attTime;
	private String leaveTime;

}
