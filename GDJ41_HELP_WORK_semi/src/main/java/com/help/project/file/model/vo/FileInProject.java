package com.help.project.file.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class FileInProject {
	//프로젝트 내의 파일
	//TB_WORK/ TB_WORK_FILE/ TB_NORMALR_CONTENT/TB_NORMAL_CON_FILE
	private int projectNo;//프로젝트번호
	private int workNo;//업무번호
	private int normalNo;//일반게시글번호
	private String contentTitle;//파일이 있는 곳의 업무/일반 글 제목
	private String workOriFileName;//원래파일이름
	private String workReFileName;//변경된파일이름
	private String workExt;//확장자
	private String workFileDate;//파일올린날짜
	private String workFilePath;//파일 주소
}
