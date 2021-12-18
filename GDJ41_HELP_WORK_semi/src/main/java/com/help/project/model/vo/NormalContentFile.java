package com.help.project.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NormalContentFile {

	private int normalConFileNo;
	private int normalContentNo;
	private String normalConOriFileName;
	private String normalConReFileName;
	private String normalConExt;
	private Date normalConDate;
	private String normalConFilePath;
}
