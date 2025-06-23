package com.example.project.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.project.dto.ChatMessage;
import com.example.project.dto.ChatRoomSummary;
import com.example.project.dto.LoginedMember;
import com.example.project.dto.Req;
import com.example.project.service.ChatService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsrChatMainController {

	private ChatService chatService;
	private Req req;

	public UsrChatMainController(ChatService chatService, Req req) {
		this.chatService = chatService;
		this.req = req;
	}

	// 내 프로필 → 핏 채팅 → 채팅 리스트만
	@GetMapping("/usr/chat/mainListOnly")
	public String showChatList( @RequestParam(required = false, defaultValue = "0") int partnerId, @RequestParam(required = false, defaultValue = "") String partnerNickName, @RequestParam(required = false, defaultValue = "0") int partnerProfileId, HttpSession session, Model model) {

		int loginedMember = req.getLoginedMember().getId();
		if (loginedMember == 0) {
			return "redirect:/usr/member/login";
		}
		
		// 💬 메시지 출력용
	    if (partnerId != 0) {
	        // ✅ roomId 조합
	        String roomId = loginedMember < partnerId ? loginedMember + "_" + partnerId : partnerId + "_" + loginedMember;

	        // ✅ 해당 방의 메시지 가져오기
	        List<ChatMessage> messages = chatService.getMessagesByRoomId(roomId);

	        // 왼쪽 채팅창 출력용
	        model.addAttribute("roomId", roomId);
	        model.addAttribute("partnerNickName", partnerNickName);
	        model.addAttribute("partnerProfileId", partnerProfileId);
	        model.addAttribute("messages", messages);
	    }

		List<ChatRoomSummary> chatList = chatService.getChatListByMemberId(loginedMember);

		model.addAttribute("chatList", chatList);
		model.addAttribute("memberId", loginedMember);

		return "usr/chat/mainListOnly";
	}
	
	@GetMapping("/usr/chat/roomData")
	public String getRoomData(@RequestParam String roomId, @RequestParam String partnerNickName, @RequestParam int partnerProfileId, HttpSession session, Model model) {
		LoginedMember loginedMember = (LoginedMember) session.getAttribute("loginedMember");

		List<ChatMessage> messages = chatService.getMessagesByRoomId(roomId);
		
		for (ChatMessage msg : messages) {
		    LocalDateTime parsedDateTime = LocalDateTime.parse(msg.getRegDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")); // 형식 맞춰
		    msg.setFormattedDate(chatService.formatMessageDate(parsedDateTime));
		    msg.setFormattedTime(chatService.formatTime(parsedDateTime));
		    
		    System.out.println("msg content: " + msg.getContent() + " / time: " + msg.getFormattedTime());
		}


	    model.addAttribute("roomId", roomId);
	    model.addAttribute("partnerNickName", partnerNickName);
	    model.addAttribute("partnerProfileId", partnerProfileId);
	    model.addAttribute("messages", messages);
	    model.addAttribute("memberId", loginedMember.getId());

	    // 🔥 이 JSP는 메시지 부분만 포함된 fragment 파일 (ex: roomFragment.jsp)
	    return "usr/chat/chatRoomContent";
	}
	
	@PostMapping("/usr/chat/sendMessage")
	public String sendMessage(@RequestParam String roomId, @RequestParam int sender, @RequestParam String content, RedirectAttributes redirectAttributes) {

	    ChatMessage chatMessage = new ChatMessage();
	    chatMessage.setRoomId(roomId);
	    chatMessage.setSender(sender);
	    chatMessage.setContent(content);

	    chatService.saveMessage(chatMessage);

	    // 파라미터 전달용 (다시 로딩)
	    redirectAttributes.addAttribute("roomId", roomId);
	    redirectAttributes.addAttribute("partnerNickName", chatService.getPartnerNickName(roomId, sender)); // 직접 구하거나 받아와도 돼
	    redirectAttributes.addAttribute("partnerProfileId", chatService.getPartnerProfileId(roomId, sender)); // 마찬가지로

	    return "redirect:/usr/chat/mainListOnly";
	}



}