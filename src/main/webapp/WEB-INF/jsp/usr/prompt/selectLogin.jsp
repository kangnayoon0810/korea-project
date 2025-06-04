<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Prompt" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/prompt.css" />

<section class="select-login">
	<div class="select-box">
		<ul class="member-login">
			<li>
				<p>회원이신가요?</p> 
				<i class="fa-solid fa-circle-user"></i>
				<a class="login-button" href="/usr/member/login">회원 로그인</a>
			</li>
		</ul>
		<ul class="trainer-login">
			<li>
				<p>트레이너이신가요?</p> <i class="fa-solid fa-clipboard-user"></i> 
				<a class="login-button" href="/usr/member/login">트레이너 로그인</a>
			</li>
		</ul>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>