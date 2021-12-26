package com.help.project.work.model.vo;

import com.help.project.normal.model.vo.NormalComment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WorkComment {
	
	private int workNo;
	private int workCommentNo;
	private String writerId;
	private String writerName;
	private String workCommentContent;
	private String commentDate;

}
