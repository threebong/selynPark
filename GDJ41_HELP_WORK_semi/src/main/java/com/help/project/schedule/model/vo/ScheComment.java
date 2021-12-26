package com.help.project.schedule.model.vo;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ScheComment {
	
	private int scheContentNo;
	private int scheCommentNo;
	private String writerId;
	private String writerName;
	private String scheCommentContent;
	private String commentDate;
	

}
