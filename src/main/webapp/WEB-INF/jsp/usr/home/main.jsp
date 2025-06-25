<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<link rel="stylesheet" href="/resource/home.css" />

<section class="main-window">
	<div class="main-menu">
		<div class="menu-top">
			<section class="trainer-banner">
				<div class="banner-content">
					<h2 class="banner-title">회원님께 꼭 맞는 건강한 선택</h2>
					<p class="banner-subtitle">쉽고 빠르게 나에게 맞는 트레이너를 찾아보세요</p>
					<a href="/usr/trainer/find" class="banner-btn">나의 트레이너 찾기</a>
				</div>
			</section>
			<section class="platform-info">
				<div class="info-wrapper">
					<div class="info-text">
						<h2>나에게 맞는 피트니스<br>소통 플랫폼</h2>
						<p>회원과 트레이너의 커뮤니티를 한 손에!</p>
						<div class="info-buttons">
							<a href="/usr/member/signup?authLevel=1">회원가입 하러 가기</a>
							<a href="/usr/member/signup?authLevel=2">트레이너가입 하러 가기</a>
						</div>
					</div>
					<div class="info-image">
						<img src="/resource/images/logo1.png" alt="피트니스 소개 이미지" />
					</div>
				</div>
			</section>
			<section class="community-intro">
				<div class="community-card">
					<div class="card-box">
						<div class="icon"><i class="fas fa-users"></i></div>
						<h3>회원 커뮤니티</h3>
						<p>다양한 운동팁, 식단 공유, 후기 등!</p>
						<a href="/usr/article/list?boardId=1&memberCategory=1">바로가기 &gt;</a>
					</div>					
				</div>

				<div class="community-card">
					<div class="card-box">
						<div class="icon"><i class="fas fa-dumbbell"></i></div>
						<h3>트레이너 커뮤니티</h3>
						<p>전문지식 공유, 꿀팁답변, 소통 공간!</p>
						<a href="/usr/article/list?boardId=2&memberCategory=2">바로가기 &gt;</a>
					</div>
				</div>
			</section>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>