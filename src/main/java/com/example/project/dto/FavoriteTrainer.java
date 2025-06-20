package com.example.project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteTrainer {
	private int id;
	private int memberId;
	private int trainerId;
	private String regDate;
	private boolean favorited;
}
