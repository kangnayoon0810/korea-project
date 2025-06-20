<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Detail Content View" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/article.css" />

<script src="/resource/article.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
	  const customSelect = document.querySelector(".custom-select");

	  // ✅ .custom-select 요소가 존재할 때만 실행
	  if (!customSelect) return;

	  const selectedOption = customSelect.querySelector(".selected-option");
	  const optionList = customSelect.querySelector(".select-options");
	  const hiddenInput = document.querySelector("input[name='sortType']");
	  const options = optionList.querySelectorAll("li");

	  // 클릭 시 옵션 보이기/숨기기
	  customSelect.addEventListener("click", function (e) {
	    optionList.classList.toggle("show");
	  });

	  // 옵션 클릭 시 값 세팅 및 폼 제출
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


$(function(){
	getLikePoint();
	getComments();
	getLoginId();
	
	$('#commentArea').on('click', '.modifyBtn', function () {
		const id = $(this).data('id');
		const content = $(this).data('content');
		
		commentModifyForm(id, content);
	})
	
	$('#commentArea').on('click', '.deleteBtn', function () {
		const id = $(this).data('id');
		
		if (confirm('정말로 삭제하시겠습니까?') == false) {
			return;
		}
		
		deleteComment(id);
	})
	
	$('#commentArea').on('click', '#commentModifyCancleBtn', function () {
		const id = $(this).data('id');
		
		commentModifyCancle(id);
	})
	
	$('#commentArea').on('click', '#modifyCommentBtn', function () {
		const id = $(this).data('id');
		
		modifyComment(id);
	})
})

const getLoginId = function() {
			$.ajax({
				url : '/usr/member/getLoginId',
				type : 'GET',
				dataType : 'text',
				success : function(data) {
					$('.loginedMemberLoginId').html(data);
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			})
		}
		
		const clickLikePoint = async function () {
			let likePointBtn = $('#likePointBtn > i').hasClass('fa-solid');
			
			await $.ajax({
				url : '/usr/likePoint/clickLikePoint',
				type : 'POST',
				data : {
					relTypeCode : 'article',
					relId : ${article.getId() },
					likePointBtn : likePointBtn
				},
			})
			await getLikePoint();
		}
		
		const getLikePoint = function () {
			$.ajax({
				url : '/usr/likePoint/getLikePoint',
				type : 'GET',
				data : {
					relTypeCode : 'article',
					relId : ${article.getId() },
				},
				dataType : 'json',
				success : function (data) {
					$('#likePointCnt').html(data.rsData);
					
					if (data.success) {
						$('#likePointBtn').html(`<i class="fa-solid fa-heart text-red-500"></i>`);
					} else {
						$('#likePointBtn').html(`<i class="fa-regular fa-heart"></i>`);
					}
				},
				error : function (xhr, status, error) {
					console.log(error);
				}
			})
		}

const writeComment = async function () {
	let commentsContent = $('#comment');
	
	if (commentsContent.val().length == 0) {
		alert('내용이 없는 댓글은 작성할 수 없습니다');
		commentsContent.focus();
		return;
	}
	
	let commentsId = '';
	
	await $.ajax({
		url : '/usr/comments/doWrite',
		type : 'POST',
		data : {
			relTypeCode : 'article',
			relId : ${article.getId() },
			content : commentsContent.val()
		},
		success : function (data) {
			replyId = data;
		},
		error : function (xhr, status, error) {
			console.log(error);
		}
	})
	
	await addComments(commentsId, 'write');
	
	commentsContent.val('');
}

const getComments = function () {
	  $.ajax({
	    url : '/usr/comments/list',
	    type : 'GET',
	    data : {
	      relTypeCode : 'article',
	      relId : ${article.getId()},
	    },
	    dataType : 'json',
	    success : function (data) {
	      console.log("댓글 리스트 응답:", data);

	      for (let idx in data) {
	        let btnHtml = '';

	        if (data[idx].memberId == ${req.getLoginedMember().getId()}) {
	          btnHtml = `
				<ul>
					<li class="cm-setting">
						<button class="cm-setting-btn">
							<i class="fa-solid fa-ellipsis"></i>
						</button>
						<ul class="cm-mnd">
		                	<li><button class="modifyBtn" data-id="\${data[idx].id}" data-content="\${data[idx].content}">수정</button></li>
		                	<li><button class="deleteBtn" data-id="\${data[idx].id}">삭제</button></li>
		              	</ul>
		            </li>
				</ul>
	          `;
	        }

	        const commentHtml = `
				<div id="\${data[idx].id}" class="cm-window">
					<div class="cm-header">
						<div class="cm-writer">
							<div class="cm-profile">
								<div><img src="/usr/profile/image/\${data[idx].profileId }" alt="프로필" /></div>
								<div class="cm-nickname">\${data[idx].nickName}</div>
							</div>
							\${btnHtml}
						</div>
					</div>
					<div class="cm-footer">
						<div class="cm-contentbox">
		            		<div class="cm-content">\${data[idx].content}</div>
		            	</div>
		            	<div class="cm-datebox">
		            		<div class="cm-date">\${data[idx].updateDate.substring(2, 16)}</div>
		            	</div>		            
	            	</div>
	         	</div>
	        `;

	        $('#commentArea').append(commentHtml);
	      }
	    },
	    error : function (xhr, status, error) {
	      console.log("에러 발생:", error);
	    }
	  });
	};

const addComments = function (id, method) {
	$.ajax({
		url : '/usr/comments/getComment',
		type : 'GET',
		data : {
			id : id
		},
		dataType : 'json',
		success : function (data) {
				let addHtml = `
					<div id="\${data.id}" class="cm-window">
						<div class="cm-header">
							<div class="cm-writer">
								<div class="cm-profile">
									<div><img src="/usr/profile/image/\${data.profileId }" alt="프로필" /></div>
									<div class="cm-nickname">\${data.nickName}</div>
								</div>
								<ul>
									<li class="cm-setting">
										<button tabindex="0" class="cm-setting-btn">
											<i class="fa-solid fa-ellipsis"></i>
										</button>
										<ul class="cm-mnd">
						                	<li><button class="modifyBtn" data-id="\${data.id}" data-content="\${data.content}">수정</button></li>
						                	<li><button class="deleteBtn" data-id="\${data.id}">삭제</button></li>
						              	</ul>
					            	</li>
								</ul>
							</div>
						</div>
						<div class="cm-footer">
							<div class="cm-contentbox">
			            		<div class="cm-content">\${data.content }</div>
			            	</div>
		            	<div class="cm-datebox">
		            		<div class="cm-date">\${data.updateDate.substring(2, 16)}</div>
		            	</div>
	         		</div>
							
				`;
				
				if (method == 'write') {
					$('#commentArea').append(addHtml);
				} else if (method == 'modify') {
					$('#' + id).replaceWith(addHtml);
					
					originalForm = $('#' + id).html();
				}
				
		},
		error : function (xhr, status, error) {
			console.log(error);
		}
	})
}

const deleteComment = function (id) {
	$.ajax({
		url : '/usr/comments/delete',
		type : 'POST',
		data : {
			id : id
		},
	})
	
	$('#' + id).remove();
}

const modifyComment = async function (id) {
	let commentModifyContent = $('#commentModifyContent');
	
	if (commentModifyContent.val().length == 0) {
		alert('내용이 없는 댓글로 수정할 수 없습니다');
		commentModifyContent.focus();
		return;
	}
	
	await $.ajax({
		url : '/usr/comments/modify',
		type : 'POST',
		data : {
			id : id,
			content : commentModifyContent.val()
		},
	})
	
	await addComments(id, 'modify');
}

let originalForm = null;
let originalId = null;

const commentModifyForm = function (id, content) {
	
	if (originalForm != null) {
		commentModifyCancle(originalId);
	}
	
	let commentsForm = $('#' + id);
	
	originalForm = commentsForm.html();
	originalId = id;
	
	let addHtml = `
		<div class="cm-domodify">
			<div class="cm-domodifybox">
				<div class="m-nickname loginedMemberLoginId"></div>
				<textarea type="text" id="commentModifyContent" class="modify-text">\${content}</textarea>
				<div class="cm-cnm">
					<button id="commentModifyCancleBtn" data-id="\${id}" class="modify-cnl">취소</button>
					<button id="modifyCommentBtn" data-id="\${id}" class="cm-domodify-btn">수정</button>
				</div>
			</div>
		</div>
	`;
	
	commentsForm.html(addHtml);
	
	getLoginId();
}

const commentModifyCancle = function(id) {
	let commentsForm = $('#' + id);
	
	commentsForm.html(originalForm);
	
	originalForm = null;
	originalId = null;
}

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
	      alert('즐겨찾기 처리 중 오류가 발생했어요 😢');
	    }
	  });
	}

		
	</script>

<section class="detail-section">
	<div class="detail-box">
		<div class="table-detailbox">
			<div class="article-detailbox">
				<div class="profile-detailbox">
					<ul class="profile-detailbox2">
						<li>
							<div>
								<img class="detail-member-profile-box" src="/usr/profile/image/${article.getProfileId() }" alt="프로필" />
								<span>${article.getNickName() }</span>
							</div>
							<ul class="detail-memberprofile-btn">
								<li class="detail-member-info">
									<div class="detail-info-box">
										<img src="/usr/profile/image/${article.getProfileId() }" alt="프로필" />
										<p>${article.getNickName() }</p>
										<p>${article.getEMail() }</p>
									</div>
									<div class="detail-info-profilebox">
										<div><a class="detail-member-profile" href="/usr/profile/myPage?id=${article.getMemberId() }">&nbsp;&nbsp;프로필</a></div>
										<c:if test="${req.getLoginedMember().getAuthLevel() == 1}">
											<c:if test="${article.getAuthLevel() == 2 }">
												<div class="member-Favorites">
													<button class="favorite-btn" onclick="toggleFavoriteTrainer(${article.getMemberId()}, this)">
														<i class="fa-star ${article.isFavorited() ? 'fa-solid text-yellow-400' : 'fa-regular'}"></i>
														즐겨찾기
													</button>
												</div>
											</c:if>
										</c:if>
										<div><a class="detail-member-chat" href="/usr/profile/myPage">&nbsp;&nbsp;핏 채팅</a></div>
									</div>
								</li>
							</ul>
						</li>
					</ul>
					<div class="detail-modify">
						<a class="show-list" href="/usr/article/list?boardId=${article.getBoardId() }&memberCategory=${article.getMemberCategory() }">목록보기</a>
						<ul>
							<li>
								<c:if test="${article.getMemberId() == req.getLoginedMember().getId() }">
									<button class="setting-btn"><i class="fa-solid fa-ellipsis"></i></button>
									<ul class="setting-a">
										<li><a href="/usr/article/modify?id=${article.getId() }">수정</a></li>
										<li><a href="/usr/article/delete?id=${article.getId() }&boardId=${article.getBoardId() }&memberCategory=${article.getMemberCategory() }" onclick="if(confirm('게시물을 삭제하시겠습니까?') == false) return false;">삭제</a></li>
									</ul>
								</c:if>
							</li>						
						</ul>
					</div>
				</div>
				<style>
					p > img {
						width: 200px;
						height: 200px;
					}
				</style>
				<div class="content-detailbox">
					<div class="content">
						${article.getContent() }
					</div>
				</div>
				<div class="cnt-detailbox">
					<div class="like">
						<button onclick="clickLikePoint();">
							<span id="likePointBtn"></span>
							<span id="likePointCnt"></span>
						</button>
					</div>
					<a class="comments" href="/usr/article/detail?id=${article.getId() }"><i class="fa-regular fa-comment"></i></a>
					<span id="commentCnt">&nbsp;${article.getCommentCnt() }</span>
					<div class="views">조회수 ${article.getViewCnt() }</div>
				</div>
				<div class="date-detailbox">
					<div class="date">${article.getRegDate().substring(2, 16) }</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="comment-section">
	<div class="comment-box">
		<div id="commentArea">
			<div class="cm-text">댓글</div>
		</div>
		
		<div class="cm-write">		
			<div class="cm-writebox">
				<c:if test="${req.getLoginedMember().getId() != 0 }">
			    	<h2 class="cm-loginedm">${req.getLoginedMember().getNickName() }</h2>
				</c:if>
				<c:if test="${req.getLoginedMember().getId() == 0 }">
			    	<h2 class="cm-loginedm">로그인 후 이용해주세요</h2>
				</c:if>
				<div class="cm-dowrite">
					<input type="text" id="comment" placeholder="댓글 입력" />
			    	<div class="click-btn">
			    		<button class="cm-writebtn" onclick="writeComment();"><i class="fa-solid fa-arrow-up"></i></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const profileImg = document.querySelector('.detail-member-profile-box');
    const profileMenu = document.querySelector('.detail-memberprofile-btn');

    if (profileImg && profileMenu) {
      profileImg.addEventListener('click', function (e) {
        e.stopPropagation();
        profileMenu.style.display = (profileMenu.style.display === 'block') ? 'none' : 'block';
      });

      document.addEventListener('click', function (e) {
        if (!profileMenu.contains(e.target) && !profileImg.contains(e.target)) {
          profileMenu.style.display = 'none';
        }
      });
    }
  });
</script>


<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>