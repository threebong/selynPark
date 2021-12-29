package com.help.project.model.vo;

import java.sql.Date;

import com.help.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Project {

	private int projectNo;
	private String memberId;
	private String proName;
	private String proExplain;
	private String proCommonYn;
	private String proIsActive;
	private Date proDate;
//	private List<Work> workList=new ArrayList();
	private String memberName;//이름
	
}
