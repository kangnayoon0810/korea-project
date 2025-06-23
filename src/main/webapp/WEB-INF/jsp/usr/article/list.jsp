<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.getBoardName() }" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/article.css" />

<script src="/resource/article.js"></script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const customSelect = document.querySelector(".custom-select");
    const selectedOption = customSelect.querySelector(".selected-option");
    const optionList = customSelect.querySelector(".select-options");
    const hiddenInput = document.querySelector("input[name='sortType']");
    const options = optionList.querySelectorAll("li");

    // 클릭 시 옵션 보이기/숨기기
    customSelect.addEventListener("click", function (e) {
      optionList.classList.toggle("show");
    });

    // 옵션 선택 시 hidden input 값 바꾸고 form 제출
    options.forEach(function (option) {
      option.addEventListener("click", function (e) {
        const value = e.target.getAttribute("data-value");
        const text = e.target.textContent;

        selectedOption.textContent = text;
        hiddenInput.value = value;

        optionList.classList.remove("show");

        document.getElementById("sortFrom").submit();
      });
    });

    // 바깥 클릭 시 옵션 닫기
    document.addEventListener("click", function (e) {
      if (!customSelect.contains(e.target)) {
        optionList.classList.remove("show");
      }
    });
  });
  
  document.addEventListener('DOMContentLoaded', function () {
	    const sortType = '${sortType}';

	    const selectedOptionSpan = document.querySelector('.selected-option');
	    const hiddenInput = document.querySelector('input[name="sortType"]');

	    if (selectedOptionSpan && hiddenInput) {
	    	  if (sortType === 'likes') {
	    	    selectedOptionSpan.textContent = '좋아요순';
	    	    hiddenInput.value = 'likes';
	    	  } else if (sortType === 'views') {
	    	    selectedOptionSpan.textContent = '조회순';
	    	    hiddenInput.value = 'views';
	    	  } else {
	    	    selectedOptionSpan.textContent = '최신순';
	    	    hiddenInput.value = 'latest';
	    	  }
	    	}

	      document.querySelectorAll('.select-options li').forEach(function (option) {
	        option.addEventListener('click', function () {
	          const value = this.getAttribute('data-value');
	          hiddenInput.value = value;
	          selectedOptionSpan.textContent = this.textContent;
	          document.querySelector('.select-options').classList.remove('show');
	        });
	      });
	  });
  
  function toggleFavoriteTrainer(trainerId, btnEl) {
	  $.ajax({
	    url: '/usr/favoriteTrainer/toggle',
	    type: 'POST',
	    data: { trainerId: trainerId },
	    success: function (result) {
	      const icon = btnEl.querySelector('i');

	      if (result === 'add') {
	        icon.classList.remove('fa-regular');
	        icon.classList.add('fa-solid', 'text-yellow-400');
	      } else {
	        icon.classList.remove('fa-solid', 'text-yellow-400');
	        icon.classList.add('fa-regular');
	      }
	    },
	    error: function () {
	      alert('즐겨찾기 처리 실패 🥲');
	    }
	  });
	}


</script>


<section class="list-section">
	<div class="list-box">
		<div class="search-box">
			<div class="memberCategory">
				<c:if test="${memberCategory == 1 }">
					<div>회원 커뮤니티</div>
				</c:if>
				<c:if test="${memberCategory == 2 }">
					<div>트레이너 커뮤니티</div>
				</c:if>
			</div>
			<form action="list" method="get" id="sortFrom">
			<input type="hidden" name="memberCategory"  value="${memberCategory}"/>
				<div class="search-bar">
					<div>
						<div class="search">
							<div class="custom-select-wrapper">
								<div class="custom-select" tabindex="0">
									<span class="selected-option">최신순</span>
									<i class="fa-solid fa-angle-down"></i>
									<ul class="select-options">
										<li data-value="latest">최신순</li>
										<li data-value="likes">좋아요순</li>
										<li data-value="views">조회순</li>
									</ul>
 								</div>
								<input type="hidden" name="sortType" value="latest" />
							</div>
							<div>
								<input type="hidden" name="boardId" value="${board.getId() }"/>
								<input type="text" name="keyWord" value="${keyWord }" placeholder="검색어를 입력하세요" />
							</div>
						</div>
					</div>
					<div class="search-btn">
						<button><i class="fa-solid fa-magnifying-glass"></i></button>
					</div>
				</div>
			</form>
		</div>
		<div class="table-box">
			<div class="article-box2">
				<c:if test="${memberCategory == 1 }">
					<c:forEach items="${articles }" var="article">
						<div class="profile-box">
							<ul class="member-page">
								<li>
									<img class="memberprofile-box" src="/usr/profile/image/${article.getProfileId() }" alt="프로필" />
									<ul class="memberprofile-btn">
										<li class="member-info">
											<div class="info-box">
												<img src="/usr/profile/image/${article.getProfileId() }" alt="프로필" />
												<p>${article.getNickName() }</p>
												<p>${article.getEMail() }</p>
											</div>
											<div class="list-info-profilebox">
												<div><a class="list-member-profile" href="/usr/profile/myPage?id=${article.getMemberId() }">프로필</a></div>
												<div><a href="/usr/chat/mainListOnly?partnerId=${article.getMemberId() }&partnerNickName=${member.getNickName() }&partnerProfileId=${article.getProfileId() }">핏채팅</a></div>
											</div>
										</li>
									</ul>
								</li>
							</ul>
							<div class="nickname">${article.getNickName() }</div>
						</div>
						<style>
							p > img {
								width: 200px;
								height: 200px;
							}
						</style>
						<div class="content-box">
							<div class="content">${article.getContent() }</div>
						</div>
						<div class="cnt-box">
							<div class="like">
								<button>
									<i class="fa-regular fa-heart"></i>
									<span id="likePointCnt"></span>
									${article.getLikeCnt() }
								</button>
							</div>
							<a class="comments" href="/usr/article/detail?id=${article.getId() }"><i class="fa-regular fa-comment"></i></a>
							<span id="commentCnt">&nbsp;${article.getCommentCnt() }</span>
							<div class="views">조회수 ${article.getViewCnt() }</div>
						</div>
						<div class="date-box">
							<div class="date">${article.getRegDate().substring(2, 16) }</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${memberCategory == 2 }">
					<c:forEach items="${articles }" var="article">
						<div class="profile-box">
							<ul class="member-page">
								<li>
									<img class="memberprofile-box" src="/usr/profile/image/${article.getProfileId() }" alt="프로필" />
									<ul class="memberprofile-btn">
										<li class="member-info">
											<div class="info-box">
												<img src="/usr/profile/image/${article.getProfileId() }" alt="프로필" />
												<p>${article.getNickName() }</p>
												<p>${article.getEMail() }</p>
											</div>
											<div class="list-info-profilebox">
												<div><a class="list-member-profile" href="/usr/profile/myPage?id=${article.getMemberId() }">프로필</a></div>
													<c:if test="${req.getLoginedMember().getAuthLevel() == 1}">
														<div class="member-Favorites">
															<button class="favorite-btn" onclick="toggleFavoriteTrainer(${article.getMemberId()}, this)">
																<i class="fa-star ${article.isFavorited() ? 'fa-solid text-yellow-400' : 'fa-regular'}"></i>
																즐겨찾기
															</button>
														</div>
													</c:if>
												<div><a href="/usr/chat/mainListOnly?partnerId=${article.getMemberId() }&partnerNickName=${article.getNickName() }&partnerProfileId=${article.getProfileId() }">핏채팅</a></div>
											</div>
										</li>
									</ul>
								</li>
							</ul>
							<div class="nickname">${article.getNickName() }</div>
						</div>
						<div class="content-box">
							<div class="content">${article.getContent() }</div>
						</div>
						<div class="cnt-box">
							<div class="like">
								<button>
									<i class="fa-regular fa-heart"></i>
									<span id="likePointCnt"></span>
									${article.getLikeCnt() }
								</button>
							</div>
							<a class="comments" href="/usr/article/detail?id=${article.getId() }"><i class="fa-regular fa-comment"></i></a>
							<span id="commentCnt">&nbsp;${article.getCommentCnt() }</span>
							<div class="views">조회수 ${article.getViewCnt() }</div>
						</div>
						<div class="date-box">
							<div class="date">${article.getRegDate().substring(2, 16) }</div>
						</div>
					</c:forEach>
				</c:if>
				
			<div class="bt-bar">
				<c:if test="${req.getLoginedMember().getAuthLevel() == 1 && board.getId() != 2 }">
					  <!-- 회원이 트레이너 커뮤니티가 아닐 때만 -->
					  <a href="/usr/article/write?boardId=${board.getId() }&memberCategory=${memberCategory }" class="write-btn-fixed"><i class="fa-solid fa-pen"></i>&nbsp;&nbsp;글쓰기</a>
				</c:if>
				<c:if test="${req.getLoginedMember().getAuthLevel() == 2 && board.getId() != 1 }">
					  <!-- 트레이너가 회원 커뮤니티가 아닐 때만 -->
					  <a href="/usr/article/write?boardId=${board.getId() }&memberCategory=${memberCategory }" class="write-btn-fixed"><i class="fa-solid fa-pen"></i>&nbsp;&nbsp;글쓰기</a>
				</c:if>
			</div>
				
			</div>
		</div>
		
			<%-- <div class="mb-8 mt-4 w-2/3 mx-auto text-center">
				<div class="join">
					<c:set var="queryString" value="?boardId=${board.getId() }&keyWord=${keyWord }&searchType=${searchType }" />
					
					<c:if test="${startPage != 1 }">
						<a class="join-item btn btn-sm" href="${queryString }&cPage=1"><i class="fa-solid fa-angles-left"></i></a>
						<a class="join-item btn btn-sm" href="${queryString }&cPage=${startPage - 1 }"><i class="fa-solid fa-caret-left"></i></a>
					</c:if>
					<c:forEach begin="${startPage }" end="${endPage }" var="i">
						<a class="join-item btn-sm btn ${cPage == i ? 'btn-active' : '' }" href="${queryString }&cPage=${i }">${i }</a>
					</c:forEach>
					<c:if test="${endPage != pagesCnt }">
		 				<a class="join-item btn btn-sm" href="${queryString }&cPage=${endPage + 1 }"><i class="fa-solid fa-caret-right"></i></a>
						<a class="join-item btn btn-sm" href="${queryString }&cPage=${pagesCnt }"><i class="fa-solid fa-angles-right"></i></a>
					</c:if>
				</div>
			</div> --%>
		
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>