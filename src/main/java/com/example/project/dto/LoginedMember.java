package com.example.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginedMember {
	private int id;
	private int authLevel;
	private String nickName;
	private String eMail;
	public String address;
}