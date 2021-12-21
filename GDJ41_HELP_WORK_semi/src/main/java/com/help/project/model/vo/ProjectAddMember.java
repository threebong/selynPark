package com.help.project.model.vo;

import com.help.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProjectAddMember {

	
	private String memberId;
	private String memberProfile;
	private String memberName;
	private String deptName;
	private String positionName;
	
	
}
