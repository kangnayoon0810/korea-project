package com.example.project.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Service;

import com.example.project.dao.ChatDao;
import com.example.project.dto.ChatMessage;
import com.example.project.dto.ChatRoomSummary;

@Service
public class ChatService {

	private ChatDao chatDao;

	public ChatService(ChatDao chatDao) {
		this.chatDao = chatDao;
	}
	
	private int extractPartnerId(String roomId, int senderId) {
		String[] parts = roomId.split("_");
		int id1 = Integer.parseInt(parts[0]);
		int id2 = Integer.parseInt(parts[1]);
		return (id1 == senderId) ? id2 : id1;
	}
	
	public void saveMessage(ChatMessage dto) {
        this.chatDao.insertMessage(dto);
    }
	
	public List<ChatMessage> getMessagesByRoomId(String roomId) {
        return this.chatDao.getMessagesByRoomId(roomId);
    }

	public List<ChatRoomSummary> getChatListByMemberId(int memberId) {
		return this.chatDao.getChatListByMemberId(memberId);
	}

	public String getPartnerNickName(String roomId, int senderId) {
		int partnerId = extractPartnerId(roomId, senderId);
		return chatDao.getNickNameByMemberId(partnerId);
	}

	public int getPartnerProfileId(String roomId, int senderId) {
		int partnerId = extractPartnerId(roomId, senderId);
		Integer profileId = chatDao.getProfileIdByMemberId(partnerId);
		return profileId != null ? profileId : 0; // null일 경우 대비
	}
	
	public String formatMessageDate(LocalDateTime messageDateTime) {
	    LocalDate today = LocalDate.now();
	    LocalDate messageDate = messageDateTime.toLocalDate();

	    if (messageDate.equals(today)) {
	        return "오늘";
	    } else if (messageDate.equals(today.minusDays(1))) {
	        return "어제";
	    } else if (messageDate.getYear() == today.getYear()) {
	        return messageDate.format(DateTimeFormatter.ofPattern("M월 d일"));
	    } else {
	        return messageDate.format(DateTimeFormatter.ofPattern("yyyy년 M월 d일"));
	    }
	}

	public String formatTime(LocalDateTime dateTime) {
	    return dateTime.format(DateTimeFormatter.ofPattern("HH:mm", Locale.KOREA));
	}

	
}