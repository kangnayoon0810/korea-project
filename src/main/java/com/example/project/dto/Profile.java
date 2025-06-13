package com.example.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Profile {
	private int id;
	private int memberId;
	private Integer profileImageId;
	private String intro;
	private String address;
	private String tag;
}