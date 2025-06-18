<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Main" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/profile.css" />

<script>
		const accessMember = '${member }';
		
		if (accessMember == '') {
			requestAnimationFrame(() => {
				alert('허용되지 않은 접근입니다');
			})
			
			setTimeout(() => {
				location.replace('/usr/home/main');
			}, 100);
		}
	
		const modifyFormChk = function (form) {
			form.nickName.value = form.nickName.value.trim();
			form.phoneNumber.value = form.phoneNumber.value.trim();
			form.email.value = form.email.value.trim();
			
			if (form.nickName.value.length == 0) {
				alert('닉네임은 필수 입력 정보입니다');
				form.nickName.focus();
				return false;
			}
			
			if (form.phoneNumber.value.length == 0) {
				alert('핸드폰번호는 필수 입력 정보입니다');
				form.phoneNumber.focus();
				return false;
			}
			
			if (form.email.value.length == 0) {
				alert('이메일은 필수 입력 정보입니다');
				form.email.focus();
				return false;
			}
			
			return true;
		}
		
		const modifyBtn = function () {
			let member = {
				id: '${member.getId() }',
				nickName: '${member.getNickName() }',
				phoneNumber: '${member.getPhoneNumber() }',
				eMail: '${member.getEMail() }',
				memberId: '${profile.getMemberId() }',
				address: '${profile.getAddress() }',
				intro: '${profile.getIntro() }'
				
			};
			
			let formHtml = `
				<form action="modify" onsubmit="return modifyFormChk(this);">
					<input type="hidden" name="id" value="\${member.id }" />
					<input type="hidden" name="memberId" value="\${member.memberId }" />
					<table>
						<tr>
							<td class="pim-title">닉네임</td>
						</tr>
						<tr>
							<td class="pim-content"><input type="text" name="nickName" value="\${member.nickName }" /></td>
						</tr>
						<tr>
							<td class="pim-title">전화번호</td>
						</tr>
						<tr>
							<td class="pim-content"><input type="text" name="phoneNumber" value="\${member.phoneNumber }" /></td>
						</tr>
						<tr>
							<td class="pim-title">이메일</td>
						</tr>
						<tr>
							<td class="pim-content"><input type="text" name="email" value="\${member.eMail }" /></td>
						</tr>
						<tr>
							<td class="pim-title">지역</td>
						</tr>
						<tr>
							<td class="pim-content">
								<input type="text" id="roadFullAddr" placeholder="도로명 주소" readonly />
								<button type="button" onclick="openJusoPopup();">주소 검색</button>
							</td>
						</tr>
						<tr>
							<td class="pim-title">소개</td>
						</tr>
						<tr>
							<td class="pim-content"><input type="text" name="intro" value="\${member.intro }" /></td>
						</tr>
						<tr>
							<td class="pim-title">비밀번호</td>
						</tr>
						<tr>
							<td class="pim-content modifypw"><button type="button" class="modifypw-btn" onclick="modifyPwPop();">비밀번호 변경</button></td>
						</tr>
					</table>
					<div>
						<div colspan="2" class="modifyinfo"><button class="modifyinfo-btn">저장</button></div>
					</div>
				</form>
			`;
			
			$('.pim').html(formHtml);
			$('#modifyPim').empty();
			
		}
		
		const modifyPwPop = function () {
			let popOption = 'width=500px, height=500px, top=200px, scrollbars=yes';
			let openUrl = '/usr/profile/modifyPwPop';
			
			window.open(openUrl, 'modifyPwPop', popOption);
		}
		
		var handlePopResult = function () {
			location.reload();
		}
</script>

<section class="myprofile-section">
	<div class="start-greetings">${req.getLoginedMember().getNickName() }<span>님 환영합니다</span></div>
	<div class="myprofile-box">
		<div class="chg-profile">
			<div class="my-img">
				<form action="/usr/profile/upload" method="post" enctype="multipart/form-data">
					<label for="profileInput">
						<img src="/usr/profile/image/${profile.getId() }" alt="프로필" />
					</label>
					<input type="file" name="profileImg" accept="image/*" id="profileInput" onchange="this.form.submit();"  style="display: none;" />
				</form>
			</div>
			<div class="pim">
				<table>
					 <tr>
					 	<td class="pim-title">닉네임</td>
					 </tr>
					 <tr>
					 	<td class="pim-content">${member.getNickName() }</td>
					 </tr>
					 <tr>
					 	<td class="pim-title">이름</td>
					 </tr>
					 <tr>
					 	<td class="pim-content">${member.getName() }</td>
					 </tr>
					 <tr>
					 	<td class="pim-title">전화번호</td>
					 </tr>
					 <tr>
					 	<td class="pim-content">${member.getPhoneNumber() }</td>
					 </tr>
					 <tr>
					 	<td class="pim-title">이메일</td>
					 </tr>
					 <tr>
					 	<td class="pim-content">${member.getEMail() }</td>
					 </tr>
					 <tr>
					 	<td class="pim-title">지역</td>
					 </tr>
					 <tr>
					 	<td class="pim-content">${profile.getAddress() }</td>
					 </tr>
					 <tr>
					 	<td class="pim-title">소개</td>
					 </tr>
					 <tr>
					 	<td class="pim-content">${profile.getIntro() }</td>
					 </tr>
				</table>
				<div class="chg-myinfo">
					<div id="modifyPim"><button onclick="modifyBtn();">회원정보 수정</button></div>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>