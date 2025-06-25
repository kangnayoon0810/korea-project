<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Main" />

<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<link rel="stylesheet" href="/resource/profile.css" />

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

function openJusoPopup() {
    new daum.Postcode({
      oncomplete: function(data) {
        const address = data.roadAddress || data.jibunAddress;
        const activeInput = document.querySelectorAll('input[name="address"], input[name="availableRegion"]');
        activeInput.forEach(input => {
          if (document.activeElement === input || input.value === "") {
            input.value = address;
          }
        });
      }
    }).open();
  }
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
				address: '${member.getAddress() }',
				memberId: '${profile.getMemberId() }',
				intro: '${profile.getIntro() }',
				gymName: '${trainerInfo.getGymName() }',
				career: `${trainerInfo.getCareer() }`,
				license: `${trainerInfo.getLicense() }`,
				availableRegion: '${trainerInfo.getAvailableRegion() }'
			};
			
			let formHtml = `
				<form class="modify-info-from" action="modify" onsubmit="return modifyFormChk(this);">
					<input type="hidden" name="id" value="\${member.id }" />
					<input type="hidden" name="memberId" value="\${member.memberId }" />
					<input type="hidden" name="id" value="\${member.id }" />
					<table class="from-in-memberm">
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
							<td class="pim-content"><input type="text" name="eMail" value="\${member.eMail }" /></td>
						</tr>
						<tr>
							<td class="pim-title">주소</td>
						</tr>
						<tr>
							<td class="pim-content">
								<input class="address-input" type="text" id="roadFullAddr" name="address" placeholder="도로명 주소" value="\${member.address }"/>
								<button type="button" onclick="openJusoPopup();">검색</button>
							</td>
						</tr>
						<tr>
							<td class="pim-title">소개</td>
						</tr>
						<tr>
							<td class="pim-content"><textarea class="pim-intro" name="intro">\${member.intro }</textarea></td>
						</tr>
						<tr>
							<td class="pim-title">비밀번호</td>
						</tr>
						<tr>
							<td class="pim-content modifypw"><button type="button" class="modifypw-btn" onclick="modifyPwPop();">비밀번호 변경</button></td>
						</tr>
						<c:if test="${member.getAuthLevel() == 1 }">
							<tr>
								<td class="authleble1"><div colspan="2" class="modifyinfo"><button class="modifyinfo-btn">저장</button></div></td>
							</tr>
						</c:if>
					</table>
					<c:if test="${member.getAuthLevel() == 2 }">
						<table>
							<tr>
								<td class="pim-title">소속</td>
							</tr>
							<tr>
								<td class="pim-content"><input type="text" name="gymName" value="\${member.gymName }" /></td>
							</tr>
							<tr>
								<td class="pim-title">경력</td>
							</tr>
							<tr>
								<td class="pim-content"><textarea class="pim-career" name="career">\${member.career }</textarea></td>
							</tr>
							<tr>
								<td class="pim-title">수상내역</td>
							</tr>
							<tr>
								<td class="pim-content"><textarea class="pim-license" name="license">\${member.license }</textarea></td>
							</tr>
							<tr>
								<td class="pim-title">활동가능 지역</td>
							</tr>
							<tr>
								<td class="pim-content">
									<input class="address-input" type="text" id="roadFullAddr" name="availableRegion" placeholder="도로명 주소" value="\${member.availableRegion }"/>
									<button type="button" onclick="openJusoPopup();">검색</button>
								</td>
							</tr>
							<tr>
								<td class="authleble2"><div colspan="2" class="modifyinfo"><button class="modifyinfo-btn">저장</button></div></td>
							</tr>
						</table>
					</c:if>
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
	<div class="start-greetings">
		<c:if test="${req.getLoginedMember().getId() == member.getId() }">
			${member.getNickName() }<span>님 환영합니다</span>
		</c:if>
		<c:if test="${req.getLoginedMember().getId() != member.getId() }">
			${member.getNickName() }<span>님의 프로필</span>
		</c:if>
	</div>
	<div class="myprofile-box">
		<div class="chg-profile">
			<div class="my-img">
				<form action="/usr/profile/upload" method="post" enctype="multipart/form-data">
					<c:if test="${req.getLoginedMember().getId() == member.getId() }">
						<label class="img-upload-label" for="profileInput">
							<img src="/usr/profile/image/${profile.getId() }" alt="프로필" />
						</label>
						<input type="file" name="profileImg" accept="image/*" id="profileInput" onchange="this.form.submit();"  style="display: none;" />
					</c:if>
					<c:if test="${req.getLoginedMember().getId() != member.getId() }">
						<label for="profileInput">
							<img src="/usr/profile/image/${profile.getId() }" alt="프로필" />
						</label>
					</c:if>
				</form>
				<c:if test="${req.getLoginedMember().getId() == member.getId() }">
					<div class="chg-myinfo">
						<div id="modifyPim"><button onclick="modifyBtn();">회원정보 수정</button></div>
					</div>
				</c:if>
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
					 <c:if test="${req.getLoginedMember().getId() == member.getId() }">
						 <tr>
						 	<td class="pim-title">전화번호</td>
						 </tr>
						 <tr>
						 	<td class="pim-content">${member.getPhoneNumber() }</td>
						 </tr>
					 </c:if>
					 <tr>
					 	<td class="pim-title">이메일</td>
					 </tr>
					 <tr>
					 	<td class="pim-content">${member.getEMail() }</td>
					 </tr>
					 <c:if test="${req.getLoginedMember().getId() == member.getId() }">
						 <tr>
						 	<td class="pim-title">주소</td>
						 </tr>
					 <tr>
					 	<td class="pim-content">${member.getAddress() }</td>
					 </tr>
					 </c:if>
					 <tr>
					 	<td class="pim-title">소개</td>
					 </tr>
					 <tr>
					 	<td class="pim-content">${profile.getIntro() }</td>
					 </tr>
				</table>
				<c:if test="${member.getAuthLevel() == 2 }">			 
					<table>
						<tr>
							<td class="pim-title">소속</td>
						</tr>
						<tr>
							<td class="pim-content">${trainerInfo.getGymName() }</td>
						</tr>
						<tr>
							<td class="pim-title">경력</td>
						</tr>
						<tr>
							<td class="pim-content">${trainerInfo.getForPrintCareer() }</td>
						</tr>
						<tr>
							<td class="pim-title">수상내역</td>
						</tr>
						<tr>
							<td class="pim-content">${trainerInfo.getForPrintLicense() }</td>
						</tr>
						<tr>
							<td class="pim-title">활동가능 지역</td>
						</tr>
						<tr>
							<td class="pim-content">${trainerInfo.getAvailableRegion() }</td>
						</tr>
					</table>
				</c:if>
			</div>
		</div>
	</div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>