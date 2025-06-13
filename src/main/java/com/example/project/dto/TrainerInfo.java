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
	private int profileId;
	private String gymName;
	private String career;
	private String license;
	private String availableRegion;
}