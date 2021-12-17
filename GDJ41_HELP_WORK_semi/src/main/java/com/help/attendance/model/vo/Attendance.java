package com.help.attendance.model.vo;


import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Attendance {
//	private Member memberId; //사원아이디
	private Date attTime; //출근시간
	private Date leaveTime; //퇴근시간
	private Date attDate; //날짜
	private String attStatus; //상태

}