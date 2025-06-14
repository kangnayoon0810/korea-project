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
				<form action="/usr/common/upload" method="post" enctype="multipart/form-data">
					<label for="profileInput">
						<c:choose>
							<c:when test="${not empty profile.profileImageId }">
								<img src="${profileImageUrl}" alt="프로필" />
							</c:when>
							<c:otherwise>
								<img src="//gen/default-profile.jpg" alt="기본 프로필" />
							</c:otherwise>
						</c:choose>
					</label>
					<input type="file" name="profileImg" accept="image/*" id="profileInput" onchange="this.form.submit();"  style="display: none;" />
				</form>
			</div>
			<div class="chg-myinfo">
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>