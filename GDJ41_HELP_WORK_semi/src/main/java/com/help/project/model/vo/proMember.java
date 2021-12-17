package com.help.project.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class proMember {//프로젝트에 참여하 사람들
	private int proMemberNo;//참여자번호
	private int projectNo;//프로젝트번호
	private String memberId;//사원아이디
	private String isManager;//관리자여부
}
