<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="핏 채팅" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<link rel="stylesheet" href="/resource/chat.css" />


<div class="fit-chating">
	<div class="chat-and-room">
		<div class="chat-room">
			<c:if test="${not empty roomId}">
				<div class="chat-header">
					<div class="chat-header-name">${partnerNickName}</div>
				</div>
				<div class="do-chat">
					<c:forEach var="msg" items="${messages}">
						<c:if test="${msg.formattedDate ne prevDate}">
							<div class="chat-date-divider">${msg.formattedDate}</div>
							<c:set var="prevDate" value="${msg.formattedDate}" />
						</c:if>
						<c:choose>
							<c:when test="${msg.sender == memberId}">
								<div class="my-msg">
									<div class="msg-content">${msg.content}</div>
									<div class="msg-time">${msg.formattedTime}</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="partner-msg">
									<img src="/usr/profile/image/${partnerProfileId}" alt="상대 프로필" width="40" height="40" />
									<div class="msg-nick">${partnerNickName}</div>
									<div class="msg-content">${msg.content}</div>
									<div class="msg-time">${msg.formattedTime}</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<div class="chat-input-box">
					<form id="chatForm" action="/usr/chat/sendMessage" method="post">
						<input type="hidden" name="roomId" value="${roomId}" />
						<input type="hidden" name="sender" value="${memberId}" />
						<input type="text" name="content" placeholder="메시지를 입력하세요" required />
						<button type="submit">전송</button>
					</form>
				</div>
			</c:if>
		</div>
		<div class="chat-list">
			<p>채팅 목록</p>
<%-- 			<c:forEach var="chat" items="${chatList}"> --%>
				<div class="chat-item" data-room-id="${chat.roomId}" data-partner-nick-name="${chat.partnerNickName}" data-partner-profile-id="${chat.partnerProfileId}">
		            <div class="chat-content">
			            <div class="chat-profile">
			                <img src="/usr/profile/image/${chat.partnerProfileId}" alt="프로필 이미지" />
			            </div>
			            <div class="chat-info">
			                <div class="chat-nickname">${chat.partnerNickName}호이</div>
			                <div class="chat-preview">${chat.lastMessage}안녕하세요</div>
			            </div>
		            </div>
		            <div class="chat-side">
			            <div class="chat-date-cnt">
				            <div class="chat-time">${chat.lastMessageTime}12:56</div>
				            <div class="chat-conting">
				            	<div class="chat-cnt">${chat.lastMessageTime}3</div>
					        </div>
			            </div>
		            </div>
		        </div>
<%-- 			</c:forEach> --%>
	    </div>
	</div>
</div>

<!-- 📌 채팅 리스트 클릭 시 채팅창 이동 -->
<!-- 📌 채팅 리스트 클릭 시 채팅창 로딩 -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  const chatItems = document.querySelectorAll(".chat-item");

  chatItems.forEach(item => {
    item.addEventListener("click", function () {
      const roomId = this.dataset.roomId;
      const partnerNickName = encodeURIComponent(this.dataset.partnerNickName);
      const partnerProfileId = this.dataset.partnerProfileId;

      fetch(`/usr/chat/roomData?roomId=${roomId}&partnerNickName=${partnerNickName}&partnerProfileId=${partnerProfileId}`)
        .then(res => res.text())
        .then(html => {
          document.querySelector(".do-chat").innerHTML = html;
        });
    });
  });
});
</script>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>