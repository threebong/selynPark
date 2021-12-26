package com.help.admin.model.vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DeptAndPosition{
	private String deptCode;
	private String deptName;
	private String positionCode;
	private String positionName;

}
