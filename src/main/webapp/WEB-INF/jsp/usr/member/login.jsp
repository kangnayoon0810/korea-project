<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Login" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/member.css" />

	<section class="login-section">
		<div class="dologin">
			<form action="doLogin" method="post"
				onsubmit="return loginFormChk(this);">
				<fieldset class="login-fieldset">
					<div class="fieldset-legend">로그인</div>
	
					<div class="loginId">
						<label>아이디</label> <input type="text" name="loginId" />
					</div>
	
					<div class="pw">
						<label>비밀번호</label> <input type="password" name="loginPw" />
					</div>
	
					<div class="dologin-box">
						<button type="submit">로그인</button>
					</div>
	
					<div class="dosignup-box">
						<p>회원이 아니신가요?</p>
						<div>
							<a class="members-signup" href="/usr/member/signup?authLevel=1">회원 가입</a>
							<a class="trainers-signup" href="/usr/member/signup?authLevel=2">트레이너 가입</a>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>