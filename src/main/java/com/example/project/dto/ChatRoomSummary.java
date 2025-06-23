package com.example.project.dto;

import com.example.project.dto.ChatRoomSummary;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatRoomSummary {
	private String roomId;
    private String partnerNickName;
    private int partnerProfileId;
    private String lastMessage;
    private String lastMessageTime;
}