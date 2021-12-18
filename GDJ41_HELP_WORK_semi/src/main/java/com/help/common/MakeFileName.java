package com.help.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class MakeFileName implements FileRenamePolicy{

	@Override
	public File rename(File oldFile) {
		File newFile = null; //반환할 파일
		
		//중복값 체킹
		do {
			//리네임 규칙 정하기
			long currentTime = System.currentTimeMillis();
			int ranNum = (int)(Math.random()*1000)+1;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			
			//이전 파일명 가져오기
			String oriName = oldFile.getName();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			
			//새 이름 설정하기
			String newName = "Help_"+sdf.format(new Date(currentTime))+"_"+ranNum+ext;
			newFile = new File(oldFile.getParent(),newName);
		}while(!createNewFile(newFile));
		return newFile;		
		
	}
	
	private boolean createNewFile(File newFile) {
		try {
			return newFile.createNewFile();
		}catch(IOException e) {
			return false;
		}
	}
	
	
}

