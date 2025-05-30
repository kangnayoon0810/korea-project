<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Sign Up" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script>
	
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