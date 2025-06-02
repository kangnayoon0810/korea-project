<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Login" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/trainer.css" />
<script src="/resource/trainer.js"></script>

<section class="login">
	<div class="login-box">
		<form action="doLogin" method="post"
			onsubmit="return loginFormChk(this);">
			<fieldset class="fieldset">
				<legend class="fieldset-legend">로그인</legend>

				<div class="name-box">
					<label>아이디</label> <input type="text" name="loginId" />
				</div>

				<div class="pw-box">
					<label>비밀번호</label> <input type="password" name="loginPw" />
				</div>

				<div class="login-box">
					<button type="submit">로그인</button>
				</div>

				<div class="dosignup">
					<p>회원이 아니신가요?</p>
					<div class="dosignup-box">
						<a href="/usr/member/join">회원가입</a> <a href="/usr/trainer/join">트레이너가입</a>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>