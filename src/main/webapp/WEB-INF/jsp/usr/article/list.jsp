<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.getBoardName() }" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<section class="list-section">
	<div class="list-row">
		<input type="hidden" value="${memberCategory }" name="memberCategory" />
		<div class="list-box">
			<div class="memberCategory">
				<c:if test="${memberCategory == 1 }">
					<div><span>회원 커뮤니티</span><span> ( ${articlesCnt } )</span></div>
				</c:if>
				<c:if test="${memberCategory == 2 }">
					<div><span>트레이너 커뮤니티</span><span> ( ${articlesCnt } )</span></div>
				</c:if>
			</div>
			<form action="list" method="get">
				<div class="search-bar">
					<div>
						<c:if test="${searchType == 'titleContent' }">
							<input type="hidden" name="boardId" value="${board.getId() }"/>
							<input name="keyWord" value="${keyWord }" class="input" placeholder="Search" />
						</c:if>
					</div>
					<div class="indicator">
						<button class="btn join-item"><i class="fa-solid fa-magnifying-glass"></i></button>
					</div>
				</div>
			</form>
		</div>
		<div class="table-box">
			<div>
				<c:if test="${memberCategory == 1 }">
					<c:forEach items="${articles }" var="article">
						<div class="writerName">${member.getNickName() }</div>
						<div class="date">${article.getRegDate().substring(2, 16) }</div>
						<div class="like">${article.getLikeCnt() }</div>
						<div class="views">${article.getViewCnt() }</div>
					</c:forEach>
				</c:if>
				<c:if test="${memberCategory == 2 }">
					<c:forEach items="${articles }" var="article">
						<div class="writerName">${member.getNickName() }</div>
						<div class="date">${article.getRegDate().substring(2, 16) }</div>
						<div class="like">${article.getLikeCnt() }</div>
						<div class="views">${article.getViewCnt() }</div>
					</c:forEach>
				</c:if>
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
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>