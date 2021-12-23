package com.help.attendance.model.vo;



import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Attendance {
	private String memberId; //사원아이디
	private String attTime; //출근시간
	private String leaveTime; //퇴근시간
	private String attDate; //날짜
	private String attStatus; //상태

}