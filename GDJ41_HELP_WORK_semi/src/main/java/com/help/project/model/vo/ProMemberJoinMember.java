package com.help.project.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProMemberJoinMember {

	private int proMemberNo;//참여자번호
	private int projectNo;//프로젝트번호
	private String memberId;//사원아이디
	private String deptCode;
	private String positionCode;
	private String memberPhone;
	private String memberProfile;
	private String memberName;
	private String memberUseYn;
}
