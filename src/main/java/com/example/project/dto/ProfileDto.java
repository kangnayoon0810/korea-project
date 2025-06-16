package com.example.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProfileDto {
	private int id;
	private int memberId;
	private String profileImagePath;
	private String intro;
	private String address;
	private String tag;
}