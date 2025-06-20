
package com.example.project.dto;

import com.example.project.dto.TrainerInfo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TrainerInfo {
	private int id;
	private int memberId;
	private int profileId;
	private String gymName;
	private String career;
	private String license;
	private String availableRegion;
	
	public String getForPrintCareer() {
		return this.career.replaceAll("\n", "<br />");
	}
	
	public String getForPrintLicense() {
		return this.license.replaceAll("\n", "<br />");
	}
}
