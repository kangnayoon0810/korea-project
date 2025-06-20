<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="내가 즐겨찾기한 트레이너" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<link rel="stylesheet" href="/resource/favoriteTrainer.css" />
<script>
function confirmUnfavorite(trainerId, btnEl) {
	  if (!confirm('즐겨찾기를 취소하시겠습니까?')) return;

	  fetch('/usr/favoriteTrainer/toggle', {
	    method: 'POST',
	    headers: {
	      'Content-Type': 'application/x-www-form-urlencoded'
	    },
	    body: 'trainerId=' + trainerId
	  })
	  .then(res => res.text())
	  .then(result => {
	    if (result === 'remove') {
	      btnEl.closest('.trainer-card').remove();
	    } else {
	      alert('예상치 못한 오류가 발생했어요!');
	    }
	  })
	  .catch(err => {
	    console.error('Fetch 오류:', err);
	  });
	}

</script>

<section class="favorite-trainer-page">
	<h2>내가 <span>즐겨찾기</span>한 트레이너</h2>
		<div class="trainer-list">
			<c:forEach var="trainer" items="${favoriteTrainers}">
				<div class="trainer-card">
					<div class="trainer-card-set">
						<!-- ⭐ 별 (삭제용) -->
						<button class="favorite-toggle" onclick="confirmUnfavorite(${trainer.id}, this)">
							<i class="fa-solid fa-star text-yellow-400"></i>
						</button>
		
						<!-- 프로필 이미지 + 닉네임 + 이메일 -->
						<div class="trainer-info">
							<img class="profile-img" src="/usr/profile/image/${trainer.profileId}" />
							<div class="trainer-text">
								<p class="nickname">${trainer.getNickName() }</p>
								<p class="email">${trainer.getEMail() }</p>
							</div>
		       			</div>
		       		</div>
						<!-- 버튼 영역 -->
		       		<div class="trainer-card-btn">
						<div class="trainer-buttons">
							<a href="/usr/profile/myPage?id=${trainer.id}" class="show-profile-btn">프로필</a>
							<a href="/usr/profile/myPage" class="fitchat-btn">핏 채팅</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>