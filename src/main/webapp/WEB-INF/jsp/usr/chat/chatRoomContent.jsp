<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="핏 채팅" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<c:set var="prevDate" value="" />
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
                <div class="msg-nick">${partnerNickName}</div>
                <div class="msg-content">${msg.content}</div>
                <div class="msg-time">${msg.formattedTime}</div>
            </div>
        </c:otherwise>
    </c:choose>
</c:forEach>


<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>