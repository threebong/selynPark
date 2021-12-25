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
public class NormalFile {

	private int normalContentNo;
	private String normalOriFileName;
	private String normalReFileName;
	
}
