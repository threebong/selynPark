package com.help.admin.model.vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AdminListMember {

	private String memberName;
	private String memberId;
	private String deptName;
	private String positionName;
	private String memberPhone;
	
}
