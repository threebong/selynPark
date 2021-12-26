package com.help.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Member {

	private String memberId;
//	private String userId;
	private String deptCode;
	private String positionCode;
	private String memberPwd;
//	private String password;
	private String memberPhone;
//	private String phone;
	private String memberProfile;
	
	private String memberName;
//	private String userName;
	private String memberUseYn;
//	private String emailHash;
//	private boolean emailChecked;
	

}
