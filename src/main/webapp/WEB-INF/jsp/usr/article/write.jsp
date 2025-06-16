<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Write" />

<!-- TOAST UI Editor 스타일 및 스크립트 (CDN) -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>


<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<style>
    /* OK 버튼 */
	.toastui-editor-popup .te-ok-button,
	.toastui-editor-popup .toastui-editor-ok-button {
	  background-color: #1D2F6F !important;
	  border-color: #1D2F6F !important;
	  color: white !important;
	}
	.toastui-editor-popup .te-ok-button:hover,
	.toastui-editor-popup .toastui-editor-ok-button:hover {
	  background-color: #1B9AAA !important;
	}
	
	/* 탭(File / URL) 하단 강조 바 */
	.toastui-editor-popup .te-tab-item.active,
	.toastui-editor-popup .tab-item.active {
	  border-bottom: 2px solid #1D2F6F !important;
	  color: #1D2F6F !important;
	}
	
	/* focus 되었을 때 input/textarea 테두리 */
	.toastui-editor-popup input:focus,
	.toastui-editor-popup textarea:focus {
	  outline: none;
	  border: 1px solid #1D2F6F !important;
	  box-shadow: 0 0 0 2px rgba(29, 47, 111, 0.2);
	}
	
	/* 에디터 내부 링크 색상 */
	.toastui-editor-contents a {
	  color: #1D2F6F !important;
	}
	
	/* 툴바에서 아이콘 선택 시 강조되는 색상 */
	.toastui-editor-defaultUI-toolbar .toastui-editor-toolbar-icons.active {
	  background-color: #1D2F6F !important;
	  color: white !important;
	}
	
	/* WYSIWYG 모드 (우측 입력 영역) */
.toastui-editor-contents {
  font-size: 1rem !important;
}

/* 마크다운 모드 (좌측 입력 영역) */
.toastui-editor-md-container textarea {
  font-size: 1rem !important;
}
	

</style>

<section class="write-section">
	<div class="write-box">
		<div class="table-writebox">
			<form action="doWrite" method="post" onsubmit="return submitForm(this);">
				<input type="hidden" name="boardId" value="${boardId }" />
				<input type="hidden" name="memberCategory" value="${memberCategory }" />
				<input type="hidden" name="memberId" value="${req.getLoginedMember().getId()}">
				<input type="hidden" name="memberCategory" value="${req.getLoginedMember().getAuthLevel()}">
				<input type="hidden" name="content" />
				<div class="profile-writebox">
					<div class="profile-writebox2">
						<div><img src="/usr/profile/image/${profile.getId() }" alt="프로필" /></div>
						<div class="nickname">${req.getLoginedMember().getNickName()}</div>
					</div>
					<button class="save-btn" type="submit">저장</button>
				</div>
				<div class="content-writebox">
					<div id="editor"></div>
				</div>
			</form>
			<div class="exit-box">
				<div>
					<button class="exit-btn" onclick="history.back();"><i class="fa-solid fa-angle-left"></i>&nbsp;나가기</button>
				</div>
			</div>
		</div>
	</div>
</section>

<script>

  const editor = new toastui.Editor({
    el: document.querySelector('#editor'),
    height: '500px',
    initialEditType: 'wysiwyg',
//     previewStyle: 'vertical',
    toolbarItems: [
      ['image', 'link']
    ]
  });
  
	const submitForm = function (form) {
		const html = editor.getHTML().trim();
	
		if (html.length === 0 || html === '<p><br></p>') {
			alert('내용을 입력해주세요');
			editor.focus();
			return false;
		}
	
		form.content.value = html;
		return true;
	}

</script>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>