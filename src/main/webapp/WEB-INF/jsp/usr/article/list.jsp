<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.getBoardName() }" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<%-- <section class="mt-8">
	<div class="container mx-auto">
		<div class="flex w-2/3 mx-auto place-content-between place-items-center mb-3 mt-3">
			<div class="theme">
				<div><span>${board.getBoardName() }</span><span> ( ${articlesCnt } )</span></div>
			</div>
			<form action="list" method="get">
				<div class="join">
					<div>
						<div>
							<input type="hidden" name="boardId" value="${board.getId() }"/>
							<input name="keyWord" value="${keyWord }" class="input join-item w-50" placeholder="Search" />
						</div>
					</div>
					<select class="select join-item" name="searchType">
						<option value="titleContent" <c:if test="${searchType == 'titleContent' }">selected</c:if>>Post</option>
						<option value="title" <c:if test="${searchType == 'title' }">selected</c:if>>Title</option>
						<option value="content" <c:if test="${searchType == 'content' }">selected</c:if>>Content</option>
					</select>
					<div class="indicator">
						<button class="btn join-item"><i class="fa-solid fa-magnifying-glass"></i></button>
					</div>
				</div>
			</form>
		</div>
		<div class="table-box">
			<div class="overflow-x-auto rounded-box border border-base-content/5 bg-base-100 w-2/3 mx-auto">
				<table class="table">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>좋아요</th>
						<th>조회수</th>
					</tr>
					<c:forEach items="${articles }" var="article">
						<tr>
							<td>${article.getId() }</td>
							<td class="hover:underline underline-offset-4"><a href="detail?id=${article.getId() }">${article.getTitle() }</a></td>
							<td>${article.getLoginId() }</td>
							<td>${article.getRegDate().substring(2, 16) }</td>
							<td>${article.getLikeCnt() }</td>
							<td>${article.getViewCnt() }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		
		<div class="bt-bar">
			<div class="mt-3 text-sm btns w-2/3 mx-auto">
				<c:if test="${req.getLoginedMember().getId() != 0 }">
					<c:choose>
						<c:when test="${req.getLoginedMember().getAuthLevel() == 0 }">
							<div>
								<a class="btn btn-ghost" href="write">글쓰기</a>
							</div>
						</c:when>
						<c:otherwise>
							<c:if test="${board.getId() != 1 }">
								<div>
									<a class="btn btn-ghost" href="write">글쓰기</a>
								</div>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
			
			<div class="mb-8 mt-4 w-2/3 mx-auto text-center">
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
			</div>
		</div>
	</div>
</section> --%>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>