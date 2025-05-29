<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Modify" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<%-- <section class="mt-8">
	<div class="container mx-auto">
		<div class="table-box">
			<div class="overflow-x-auto rounded-box border border-base-content/5 bg-base-100 w-2/3 mx-auto">
				<form action="doModify" method="post">
					<input name="id" type="hidden" value="${article.getId() }" />
						<table class="table">
							<tr>
								<th>번호</th>
								<td>${article.getId() }</td>
							</tr>
							<tr>
								<th>작성일</th>
								<td>${article.getRegDate().substring(2, 16) }</td>
							</tr>
							<tr>
								<th>수정일</th>
								<td>${article.getUpdateDate().substring(2, 16) }</td>
							</tr>
							<tr>
								<th>제목</th>
								<td><input type="text" class="input" name="title" value="${article.getTitle() }"/></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea class="textarea textarea-md" name="content">${article.getContent() }</textarea></td>
							</tr>
							<tr>
								<td colspan="2"><button class="btn btn-ghost">수정</button></td>
							</tr>
						</table>
					</div>
				</form>
			</div>

		<div class="mt-3 text-sm btns w-2/3 mx-auto">
			<div class="mr-2">
				<button class="btn btn-ghost" onclick="history.back();">뒤로가기</button>
			</div>
		</div>
	</div>
</section> --%>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>