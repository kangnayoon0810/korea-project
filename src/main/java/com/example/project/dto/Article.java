package com.example.project.dto;

import com.example.project.dto.Article;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id;
	private int boardId;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String content;
	private int viewCnt;
	private int memberCategory;
	private String loginId;
	private int likeCnt;
	private int commentsCnt;
	private String nickName;
}
