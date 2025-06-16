<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- 테일윈드, daisyUI -->
<link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- 공용 CSS -->
<link rel="stylesheet" href="/resource/common.css" />
<link rel="stylesheet" href="/resource/member.css" />
<link rel="stylesheet" href="/resource/article.css" />

<script src="/resource/member.js"></script>

<meta charset="UTF-8">
<title>${pageTitle }</title>
<link rel="shortcut icon" href="/resource/images/favicon.ico" />
</head>
<body>

	<div class="topbar" style="width:100%">
		<div class="topbar-box">
			<div class="topbar-start">
				<ul class="logo-box">
					<li><a href="/">DesignFit</a></li>
				</ul>
			</div>
			<div class="topbar-center">
				<ul class="article-box">
					<li><a class="member-article" href="/usr/article/list?boardId=1&memberCategory=1">회원 커뮤니티</a></li>
					<li><a class="trainer-article" href="/usr/article/list?boardId=2&memberCategory=2">트레이너 커뮤니티</a></li>
				</ul>
			</div>
			<div class="topbar-end">
				<ul class="sign-box">
					<li class="login-signup">
						<c:if test="${req.getLoginedMember().getId() == 0 }">
							<ul class="sign-page">
								<li><a class="login-button" href="/usr/member/login">로그인</a></li>
								<li><a class="member-signup" href="/usr/member/signup?authLevel=1">회원가입</a></li>
								<li><a class="tranier-signup" href="/usr/member/signup?authLevel=2">트레이너 가입</a></li>
							</ul>						
						</c:if>
						<c:if test="${req.getLoginedMember().getId() != 0 }">
							<ul class="my-page">
								<li>
									<img class="memberprofile-box" src="/usr/profile/image/${req.getLoginedMember().getId() }" alt="프로필" />
									<ul class="memberprofile-btn">
										<li class="my-info">
											<div class="info-box">
												<img src="/usr/profile/image/${req.getLoginedMember().getId() }" alt="프로필" />
												<p>${req.getLoginedMember().getNickName() }</p>
												<p>${req.getLoginedMember().getEMail() }</p>
											</div>
											<div class="info-profilebox">
												<div><a class="member-profile" href="/usr/profile/myPage"><i class="fa-solid fa-user"></i>&nbsp;&nbsp;프로필</a></div>
												<div><a class="member-Favorites" href="/usr/profile/myPage"><i class="fa-solid fa-star"></i>&nbsp;&nbsp;즐겨찾기</a></div>
												<div><a class="member-chat" href="/usr/profile/myPage"><i class="fa-solid fa-comments"></i>&nbsp;&nbsp;핏 채팅</a></div>
												<div><a class="logout-button" href="/usr/member/logout"><i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;로그아웃</a></div>
											</div>
										</li>
									</ul>
								</li>
							</ul>
						</c:if>
					</li>
				</ul>
			</div>
		</div>
	</div>