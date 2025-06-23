package com.example.project.dto;

import com.example.project.dto.ChatMessage;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatMessage {
    private int id;
    private String roomId;
    private int sender;
    private String content;
    private String regDate;
    private String formattedDate; // 날짜 라벨용
    private String formattedTime; // 말풍선 시간 표시용

}