<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Write" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<%-- <section class="mt-8">
	<div class="container mx-auto">
		<div class="table-box">
			<div class="overflow-x-auto rounded-box border border-base-content/5 bg-base-100 w-2/3 mx-auto">
				<table class="table">
					<form action="doWrite" method="post">
						<table class="table">
							<tr>
								<td>
									<p class="text-sm">Writing options</p>
									<select name="boardId" class="select mx-auto">
										<c:if test="${req.getLoginedMember().getAuthLevel() == 0 }">
											<option value="1">Notice</option>
										</c:if>
										<option value="2">Free board</option>
										<option value="3">QnA</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<span class="font-bold">제목</span>
									<input type="text" class="input w-150" name="title" />
								</td>
							</tr>
							<tr>
								<td>
									<span class="font-bold">내용</span>
									<textarea class="textarea textarea-md w-150 h-100" name="content"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2"><button class="btn btn-ghost">저장</button></td>
							</tr>
						</table>
					</form>
				</table>
			</div>
		</div>

		<div class="mt-3 text-sm btns w-2/3 mx-auto">
			<div class="mr-2">
				<button class="btn btn-ghost" onclick="history.back();">뒤로가기</button>
			</div>
		</div>
	</div>
</section> --%>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>