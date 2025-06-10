<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Detail Content View" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<script src="/resource/article.js"></script>

<script>
$(function(){
	getLikePoint();
	getComments();
	getLoginId();
	
	$('#commentArea').on('click', '.modifyBtn', function () {
		const id = $(this).data('id');
		const content = $(this).data('content');
		
		commentModifyForm(id, comment);
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
	            <div class="cm-setting">
	              <button class="setting-btn">
	                <i class="fa-solid fa-ellipsis"></i>
	              </button>
	              <ul class="dropdown-content menu bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm">
	                <li><button class="modifyBtn" data-id="\${data[idx].id}" data-content="\${data[idx].content}">수정</button></li>
	                <li><button class="deleteBtn" data-id="\${data[idx].id}">삭제</button></li>
	              </ul>
	            </div>
	          `;
	        }

	        const commentHtml = `
	          <div id="\${data[idx].id}" class="cm-window">
	          	<div class="cm-header">
		            <div class="cm-writer">
		            	<div class="cm-profile">
		          			<div><img src="https://www.studiopeople.kr/common/img/default_profile.png"/></div></a></div>
			              	<div class="cm-nickname">\${data[idx].nickName}</div>
		              	</div>
		              	\${btnHtml}
	            	</div>
	            </div>
	            <div class="cm-footer">
		            <div class="cm-content">\${data[idx].content}</div>
		            <div class="cm-date">\${data[idx].updateDate}</div>
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
					<div id="\${data.id }" class="py-2 border-b-2 border-gray-200 pl-20">
						<div class="flex justify-between items-center">
							<div class="font-semibold">\${data.loginId }</div>
							<div class="dropdown dropdown-bottom dropdown-end mr-4">
							  <button tabindex="0" class="btn btn-circle btn-ghost btn-xs">
						        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block h-5 w-5 stroke-current"> <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path> </svg>
						      </button>
							  <ul tabindex="0" class="dropdown-content menu bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm">
							    <li class="w-14"><button class="modifyBtn" data-id="\${data.id }" data-content="\${data.content}">수정</button></li>
							    <li class="w-14"><button class="deleteBtn" data-id="\${data.id }">삭제</button></li>
							  </ul>
							</div>
						</div>
						<div class="text-lg my-1 ml-2">\${data.content }</div>
						<div class="text-xs text-gray-400">\${data.updateDate }</div>
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

const commentModifyForm = function (id, Content) {
	
	if (originalForm != null) {
		commentModifyCancle(originalId);
	}
	
	let commentsForm = $('#' + id);
	
	originalForm = commentsForm.html();
	originalId = id;
	
	let addHtml = `
		<div>
			<div class="border-2 border-gray-200 rounded-xl px-4 mt-2">
				<div class="mt-3 mb-2 font-semibold text-sm loginedMemberLoginId"></div>
				<textarea style="width: 100%; resize: none;" id="commmentModifyContent" class="textarea">\${content}</textarea>
				<div class="flex justify-end my-2">
					<button id="commentModifyCancleBtn" data-id="\${id}" class="btn btn-neutral btn-outline btn-xs mr-2">취소</button>
					<button id="modifyCommentyBtn" data-id="\${id}" class="btn btn-neutral btn-outline btn-xs">수정</button>
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
		
	</script>

<section class="detail-section">
	<div class="detail-box">
		<div class="table-detailbox">
			<div class="article-detailbox">
				<div class="profile-detailbox">
					<div class="profile-detailbox2">
						<div><img src="https://www.studiopeople.kr/common/img/default_profile.png"/></div>
						<div class="nickname">${article.getNickName() }</div>
					</div>
					<div class="detail-modify">
						<ul>
							<li>
								<button class="setting-btn"><i class="fa-solid fa-ellipsis"></i></button>
								<ul class="setting-a">
									<li><a href="/usr/article/modify">수정</a></li>
									<li><a href="/usr/article/delete">삭제</a></li>
								</ul>
							</li>						
						</ul>
					</div>
				</div>
				<div class="content-detailbox">
					<div class="content">${article.getContent() }</div>
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

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>