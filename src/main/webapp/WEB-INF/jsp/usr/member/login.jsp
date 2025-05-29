<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Login" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	const loginFormChk = function(form) {
		form.loginId.value = form.loginId.value.trim();
		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginId.value.length == 0) {
			alert('아이디를 입력 해주세요');
			form.loginId.focus();
			return false;
		}

		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력 해주세요');
			form.loginPw.focus();
			return false;
		}
		
		return true;
	}
</script>

<!-- <section class="mt-30">
	<div>
		<form action="doLogin" method="post" onsubmit="return loginFormChk(this);">
			<fieldset class="fieldset bg-base-200 border-base-300 rounded-box w-md border p-4 mx-auto">
				<legend class="fieldset-legend">Login</legend>

				<label class="label">ID</label> 
				<input type="text" name="loginId" class="input-lg" />
				
				<label class="label">Password</label>
				<input type="password" name="loginPw" class="input-lg" />

				<button class="btn btn-neutral mt-4">Login</button>
				<a role="button" class="btn btn-neutral mt-4" href="/usr/member/join">Sign Up</a>
				<p class="text-xs">Need an account?</p>
			</fieldset>
		</form>
	</div>
</section> -->

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>