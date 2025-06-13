package com.example.project.dto;

import com.example.project.dto.FileDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileDto {
	private int id;
	private String regDate;
	private String originName;
	private String savedName;
	private String savedPath;
	
	public String getForPrintUrl() {
		return "/gen/" + savedName;
	}
}