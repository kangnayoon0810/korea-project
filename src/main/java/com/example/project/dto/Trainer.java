package com.example.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Trainer {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private int sex;
	private int phoneNumber;
	private String loginId;
	private String loginPw;
	private String eMail;
}