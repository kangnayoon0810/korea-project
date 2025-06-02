package com.example.project.dto;

import com.example.project.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private int sex;
	private String nickName;
	private int phoneNumber;
	private String loginId;
	private String loginPw;
	private String eMail;
	private int authLevel;
}