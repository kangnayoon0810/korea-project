<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="SignUp" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/trainer.css" />
<script src="/resource/trainer.js"></script>

<section class="signup-section">
	<div class="signup-box">
		<form action="doSignUp" method="POST" onsubmit="return signupFormChk(this);">
			<fieldset class="signup-fieldset">
				<legend class="fieldset-legend">회원가입</legend>

				<div class="name-box">
					<label>이름</label> <input type="text" name="name" />
				</div>

				<div class="sex-box">
					<label>성별</label>
					<div class="sex-select">
						<button type="button" class="sex-btn"
							onclick="selectSex(this, '0')">남자</button>
						<button type="button" class="sex-btn"
							onclick="selectSex(this, '1')">여자</button>
						<input type="hidden" name="sex" id="sexInput" />
					</div>
				</div>

				<div class="phoneNumber-box">
					<label>핸드폰 번호<span id="phoneNumberDupChkMsg"></span></label> <input
						type="text" name="phoneNumber" onblur="phoneNumberDupChk(this);" />
				</div>

				<div class="id-box">
					<label>아이디<span id="loginIdDupChkMsg"></span></label> <input
						type="text" name="loginId" onblur="loginIdDupChk(this);" />
				</div>

				<div class="pw-box">
					<label>비밀번호</label> <input type="password" name="loginPw"
						autocomplete="new-password off" />
				</div>

				<div class="pwchk-box">
					<label>비밀번호 확인</label> <input type="password" name="loginPwChk"
						autocomplete="new-password off" />
				</div>

				<div class="email-box">
					<label>이메일<span id="eMailDupChkMsg"></span></label> <input
						type="email" name="eMail" onblur="eMailDupChk(this);" />
				</div>

				<div class="dosignup">
					<button class="dosignup-btn" type="submit">회원가입</button>
				</div>

				<div class="login-box">
					<p>회원이신가요?</p>
					<div class="login-btn">
						<button class="dologin-btn" type="submit">로그인</button>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>