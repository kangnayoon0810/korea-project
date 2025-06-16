<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Main" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/profile.css" />

<section class="myprofile-section">
	<div class="start-greetings">${req.getLoginedMember().getNickName() }<span>님 환영합니다</span></div>
	<div class="myprofile-box">
		<div class="chg-profile">
			<div class="my-img">
				<form action="/usr/profile/upload" method="post" enctype="multipart/form-data">
					<label for="profileInput">
						<img src="/usr/profile/image/${profile.getId() }" alt="프로필" />
					</label>
					<input type="file" name="profileImg" accept="image/*" id="profileInput" onchange="this.form.submit();"  style="display: none;" />
				</form>
			</div>
			<div class="pim">
				<table>
					 <tr class="pim-nickname">
					 	<td>${req.getLoginedMember().getName() }</td>
					 </tr>
					 <tr class="pim-email">
					 	<td>${req.getLoginedMember().getEMail() }</td>
					 </tr>
				</table>
			</div>
			<div class="chg-myinfo">
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>