<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Detail Content View" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<%-- <script>
		$(function(){
			getLikePoint();
		})
	
		const clickLikePoint = async function () {
			let likePointBtn = $('#likePointBtn > i').hasClass('fa-solid');
			
			await $.ajax({
				url : '/usr/likePoint/clickLikePoint',
				type : 'GET',
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
		
		const listComment = function () {
			$.ajax({
				url: '/usr/comments/list',
			    type: 'GET',
			    data: {
					relTypeCode: 'article',
					relId: ${article.getId() }
			    },
			    dataType: 'json',
			    success: function (data) {
					const listArea = $("#comment-list");
					listArea.empty();

					listArea.append(`<li class="p-4 pb-2 text-sm opacity-60 tracking-wide">Comments</li>`);

					if (data.length === 0) {
						listArea.append(`<li class="p-4 text-sm opacity-50">아직 댓글이 없습니다.</li>`);
					} else {
						data.forEach(comment => {
							const html = `
								<li class="list-row border-t border-base-content/10 p-4 flex gap-4">
									<div><img class="size-10 rounded-box" src="https://img.daisyui.com/images/profile/demo/1@94.webp"/></div>
									<div class="flex-1">
				                		<div class="font-semibold">\${comment.memberId }</div>
				                		<div class="text-xs opacity-60">\${comment.regDate }</div>
				                		<p class="mt-1 text-sm">\${comment.comment }</p>
				              		</div>
				            	</li>
			          		`;
			          		listArea.append(html);
			        	});
			      }
			    },
			    error: function (xhr, status, error) {
					console.error("❌ 댓글 목록 불러오기 실패", error);
			    }
			});
		};
		
		const writeComment = function () {
			let comment = $('#comment');
			
			if (comment.val().length == 0) {
				alert('내용을 입력해주세요');
				comment.focus();
				return;
			}
			
			$.ajax({
				url : '/usr/comments/doWrite',
				type : 'POST',
				data : {
					relTypeCode : 'article',
					relId : ${article.getId() },
					comment : comment.val()
				},
				dataType : 'text',
				success : function (data) {
					console.log(data);
					comment.val("");
					listComment();
				},
				error : function (xhr, status, error) {
					console.log(error);
				}
			})
		}
		
		$(document).ready(function () {
		    listComment();
		});
		
	</script> --%>

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
								<button><i class="fa-solid fa-ellipsis"></i></button>
								<ul>
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
							<i class="fa-regular fa-heart"></i>
							<span id="likePointBtn"></span>
							${article.getLikeCnt() }
						</button>
					</div>
					<a class="comments" href="/usr/article/detail?id=${article.getId() }"><i class="fa-regular fa-comment"></i> ${article.getCommentsCnt() }</a>
					<div class="views">조회수 ${article.getViewCnt() }</div>
				</div>
				<div class="date-detailbox">
					<div class="date">${article.getRegDate().substring(2, 16) }</div>
				</div>
			</div>
		</div>

<!-- 		<div class="mt-3 text-sm btns flex justify-between w-2/3 mx-auto"> -->
<!-- 			<div class="flex"> -->
<!-- 				<button class="btn btn-ghost" onclick="history.back();">뒤로가기</button> -->
<%-- 				<c:if test="${article.getMemberId() == req.getLoginedMember().getId() }"> --%>
<%-- 					<div class="mx-2"><a class="btn btn-ghost" href="modify?id=${article.getId() }">수정</a></div> --%>
<%-- 					<div><a class="btn btn-ghost" href="delete?id=${article.getId() }" onclick="if(confirm('게시물을 삭제하시겠습니까?') == false) return false;">삭제</a></div> --%>
<%-- 				</c:if> --%>
<!-- 			</div> -->
<!-- 			<div class="flex"> -->
<%-- 				<c:if test="${req.getLoginedMember().getId() != 0 }"> --%>
<!-- 					<button class="btn btn-ghost" onclick="clickLikePoint();"> -->
<!-- 						<span id="likePointBtn"></span> -->
<!-- 						LIKE -->
<!-- 					</button> -->
<%-- 				</c:if> --%>
<!-- 			</div> -->
<!-- 		</div> -->
		
	</div>
</section>

<section class="comment-section">
	<div class="comment-box">
		<div id="comment-area">
			<ul id="comment-list">
				<li>댓글</li>
			</ul>
		</div>
		
		<div class="comment-write">		
			<div class="">
				<div class="card-body">
			    	<h2 class="card-title">${req.getLoginedMember().getId() }</h2>
					<textarea id="comment" class="textarea h-20 w-full" placeholder="Comment"></textarea>
			    	<div class="justify-end card-actions">
			    		<button class="btn btn-ghost" onclick="writeComment();"><i class="fa-solid fa-arrow-up"></i></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>