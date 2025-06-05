<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="SignUp" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="signup-section">
	<div class="signup-box">
		<form action="doSignUp" method="POST" onsubmit="return signupFormChk(this);">
			<input type="hidden" value="${authLevel }" name="authLevel" />
			<fieldset class="signup-fieldset">
				<c:if test="${authLevel == 1 }">
					<legend class="fieldset-legend">회원가입</legend>
				</c:if>
				<c:if test="${authLevel == 2 }">
					<legend class="fieldset-legend">트레이너 가입</legend>
				</c:if>
 
				<div class="name-box">
					<label>이름</label> 
					<input type="text" name="name" placeholder="이름(실명)" />
				</div>

				<div class="sex-box">
					<label>성별</label>
					<div class="sex-select">
						<button type="button" class="sex-btn" onclick="selectSex(this, '0')">남자</button>
						<button type="button" class="sex-btn" onclick="selectSex(this, '1')">여자</button>
						<input type="hidden" name="sex" id="sexInput" />
					</div>
				</div>

				<div class="nickName-box">
					<label>닉네임 <span id="nickNameDupChkMsg"></span></label> 
					<input type="text" name="nickName" onblur="nickNameDupChk(this);" placeholder="닉네임" />
					<input type="hidden" name="nickNameChk" />
				</div>

				<div class="phoneNumber-box">
					<label>핸드폰 번호 <span id="phoneNumberDupChkMsg"></span></label> 
					<input type="text" name="phoneNumber" onblur="phoneNumberDupChk(this);" placeholder="ex) 01012341234" />
					<input type="hidden" name="phoneNumberChk" />
				</div>

				<div class="id-box">
					<label>아이디 <span id="loginIdDupChkMsg"></span></label> 
					<input type="text" name="loginId" onblur="loginIdDupChk(this);" placeholder="아이디" />
				</div>

				<div class="pw-box">
					<label>비밀번호</label> 
					<input type="password" name="loginPw" placeholder="비밀번호" />
				</div>

				<div class="pwchk-box">
					<label>비밀번호 확인</label> 
					<input type="password" name="loginPwChk" placeholder="비밀번호 확인" />
				</div>

				<div class="email-box">
					<label>이메일 <span id="eMailDupChkMsg"></span></label> 
					<input type="email" name="eMail" onblur="eMailDupChk(this);" placeholder="ex) example@designfit.com" />
					<input type="hidden" name="eMailChk" />
				</div>

				<div class="dosignup">
					<button class="dosignup-btn">가입</button>
				</div>

				<div class="login-box">
					<c:if test="${authLevel == 1 }">
						<p>회원이신가요?</p>
					</c:if>
					<c:if test="${authLevel == 2 }">
						<p>트레이너이신가요?</p>
					</c:if>
					<div class="login-btn">
						<a class="dologin-btn" href="/usr/member/login">로그인</a>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>