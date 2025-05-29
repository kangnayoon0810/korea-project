<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Sign Up" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	let validLoginId = null;

	const joinFormChk = function(form) {
		form.loginId.value = form.loginId.value.trim();
		form.loginPw.value = form.loginPw.value.trim();
		form.loginPwChk.value = form.loginPwChk.value.trim();
		form.name.value = form.name.value.trim();

		if (form.loginId.value.length == 0) {
			alert('아이디를 입력 해주세요');
			form.loginId.focus();
			return false;
		}

		if (form.loginId.value != validLoginId) {
			alert('[ ' + form.loginId.value + ' ] 은(는) 사용할 수 없는 아이디입니다.');
			form.loginId.value = '';
			form.loginId.focus();
			return false;
		}

		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력 해주세요');
			form.loginPw.focus();
			return false;
		}

		if (form.name.value.length == 0) {
			alert('이름을 입력 해주세요');
			form.name.focus();
			return false;
		}

		if (form.loginPw.value != form.loginPwChk.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.value = '';
			form.loginPwChk.value = '';
			form.loginPw.focus();
			return false;
		}

		return true;
	}

	const loginIdDupChk = function(el) {
		el.value = el.value.trim();

		let loginIdDupChkMsg = $('#loginIdDupChkMsg');

		if (el.value.length == 0) {
			loginIdDupChkMsg.removeClass('text-green-500');
			loginIdDupChkMsg.addClass('text-red-500');
			loginIdDupChkMsg.html('아이디를 입력 해주세요');
			return;
		}

		$.ajax({
			url : '/usr/member/loginIdDupChk',
			type : 'GET',
			data : {
				loginId : el.value
			},
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					loginIdDupChkMsg.removeClass('text-red-500');
					loginIdDupChkMsg.addClass('text-green-500');
					loginIdDupChkMsg.html(`\${data.rsMsg}`);
					validLoginId = el.value;
				} else {
					loginIdDupChkMsg.removeClass('text-green-500');
					loginIdDupChkMsg.addClass('text-red-500');
					loginIdDupChkMsg.html(`\${data.rsMsg}`);
					validLoginId = null;
				}
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		})
	}
</script>

<!-- <section class="mt-30">
	<div>
		<form action="doJoin" method="post" onsubmit="return joinFormChk(this);">
			<fieldset class="fieldset bg-base-200 border-base-300 rounded-box w-md border p-4 mx-auto">
				<legend class="fieldset-legend">Sign Up</legend>

				<label class="label">ID</label> 
				<input type="text" name="loginId" class="input-lg" onblur="loginIdDupChk(this);" />
				
				<label class="label">Password</label>
				<input type="password" name="loginPw" class="input-lg" />
				
				<label class="label">Password</label>
				<input type="password" name="loginPwChk" class="input-lg" />
				
				<label class="label">Name</label>
				<input type="text" name="name" class="input-lg" />

				<button class="btn btn-neutral mt-4">Sign Up</button>
				<a role="button" class="btn btn-neutral mt-4" href="/usr/member/login">Login</a>
				<p class="text-xs">Do you have an account?</p>
			</fieldset>
		</form>
	</div>
</section> -->

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>