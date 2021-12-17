package com.help.member.model.vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Member {
	
	private String memberId;
	private String deptCode;
	private String positionCode;
	private String memberPwd;
	private String memberPhone;
	private String memberProfile;
	private String memberName;
	private String memberUseYn;
	

}
