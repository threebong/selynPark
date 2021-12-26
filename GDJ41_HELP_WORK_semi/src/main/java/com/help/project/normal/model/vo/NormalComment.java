package com.help.project.normal.model.vo;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NormalComment {

	private int normalContentNo;
	private int normalCommentNo;
	private String writerId;
	private String writerName;
	private String normalCommentContent;
	private String commentDate;
	
	
}
