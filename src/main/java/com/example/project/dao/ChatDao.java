package com.example.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.project.dto.ChatMessage;
import com.example.project.dto.ChatRoomSummary;

@Mapper
public interface ChatDao {

	@Insert("""
			INSERT INTO chat_message
			 	SET roomId = #{roomId},
			     	sender = #{sender},
			     	content = #{content},
			     	regDate = NOW()
			""")
	void insertMessage(ChatMessage dto);
	
	@Select("""
			SELECT * 
				FROM chat_message
			 	WHERE roomId = #{roomId}
			 	ORDER BY regDate ASC
			""")
    List<ChatMessage> getMessagesByRoomId(String roomId);

	@Select("""
			SELECT
				roomId,
				MAX(content) AS lastMessage,
				MAX(cm.regDate) AS lastMessageTime,
				m.nickName AS partnerNickName,
				p.id AS partnerProfileId
			FROM chat_message cm
			JOIN member m ON cm.sender = m.id AND cm.sender != #{memberId}
			JOIN profile p ON m.id = p.memberId
			WHERE cm.roomId IN (
				SELECT DISTINCT roomId
				FROM chat_message
				WHERE sender = #{memberId}
				OR roomId IN (
					SELECT roomId
					FROM chat_message
					WHERE sender = #{memberId}
				)
			)
			GROUP BY roomId
			ORDER BY MAX(cm.regDate) DESC
		""")
		List<ChatRoomSummary> getChatListByMemberId(int memberId);

	@Select("""
			SELECT nickName 
				FROM member 
				WHERE id = #{memberId}
			""")
	String getNickNameByMemberId(int memberId);
	
	@Select("""
			SELECT id 
				FROM profile 
				WHERE memberId = #{memberId}
			""")
	Integer getProfileIdByMemberId(int memberId);

}