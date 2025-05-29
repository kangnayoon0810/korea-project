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
		
	</script>

<section class="mt-8">
	<div class="container mx-auto">
		<div class="table-box">
			<div class="overflow-x-auto rounded-box border border-base-content/5 bg-base-100 w-2/3 mx-auto">
				<table class="table">
					<tr>
						<th>번호</th>
						<td>${article.getId() }</td>
						
						<th>작성자</th>
						<td>${article.getMemberId() }</td>
					</tr>
					<tr>
						<th>작성일</th>
						<td>${article.getRegDate().substring(2, 16) }</td>
						
						<th>수정일</th>
						<td>${article.getUpdateDate().substring(2, 16) }</td>
					</tr>
					<tr>
						<th>좋아요</th>
						<td><span id="likePointCnt"></span></td>
						
						<th>조회수</th>
						<td>${article.getViewCnt() }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${article.getTitle() }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${article.getContent() }</td>
					</tr>
				</table>
			</div>
		</div>

		<div class="mt-3 text-sm btns flex justify-between w-2/3 mx-auto">
			<div class="flex">
				<button class="btn btn-ghost" onclick="history.back();">뒤로가기</button>
				<c:if test="${article.getMemberId() == req.getLoginedMember().getId() }">
					<div class="mx-2"><a class="btn btn-ghost" href="modify?id=${article.getId() }">수정</a></div>
					<div><a class="btn btn-ghost" href="delete?id=${article.getId() }" onclick="if(confirm('게시물을 삭제하시겠습니까?') == false) return false;">삭제</a></div>
				</c:if>
			</div>
			<div class="flex">
				<c:if test="${req.getLoginedMember().getId() != 0 }">
					<button class="btn btn-ghost" onclick="clickLikePoint();">
						<span id="likePointBtn"></span>
						LIKE
					</button>
				</c:if>
			</div>
		</div>
		
	</div>
</section>

<section class="mt-5">
	<div class="container mx-auto">
		<div id="comment-area">
			<ul id="comment-list" class="list rounded-box border border-base-content/5 bg-base-100 w-2/3 mx-auto">
				<li class="p-4 pb-2 text-sm opacity-60 tracking-wide">Comments</li>
  
			</ul>
		</div>
		
		<div class="mt-5">
			<c:if test="${req.getLoginedMember().getId() != 0 }">		
				<div class="card card-xs border border-base-content/5 bg-base-100 w-2/3 mx-auto">
					<div class="card-body">
				    	<h2 class="card-title">${req.getLoginedMember().getId() }</h2>
						<textarea id="comment" class="textarea h-20 w-full" placeholder="Comment"></textarea>
				    	<div class="justify-end card-actions">
				    		<button class="btn btn-ghost" onclick="writeComment();">등록</button>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</section>		 --%>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>