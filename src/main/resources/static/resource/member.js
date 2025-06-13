let validNickName = null;
let validPhoneNumber = null;
let validLoginId = null;
let validEMail = null;

const loginFormChk = function(form) {
	form.loginId.value = form.loginId.value.trim();
	form.loginPw.value = form.loginPw.value.trim();

	if (form.loginId.value.length == 0) {
		alert('아이디를 입력 해주세요');
		form.loginId.focus();
		return false;
	}

	if (form.loginPw.value.length == 0) {
		alert('비밀번호를 입력 해주세요');
		form.loginPw.focus();
		return false;
	}

	return true;
}

const signupFormChk = function(form) {
	form.name.value = form.name.value.trim();
	form.sex.value = form.sex.value.trim();
	form.nickName.value = form.nickName.value.trim();
	form.nickNameChk.value = form.loginPwChk.value.trim();
	form.phoneNumber.value = form.phoneNumber.value.trim();
	form.phoneNumberChk.value = form.phoneNumberChk.value.trim();
	form.loginId.value = form.loginId.value.trim();
	form.loginPw.value = form.loginPw.value.trim();
	form.loginPwChk.value = form.loginPwChk.value.trim();
	form.eMail.value = form.eMail.value.trim();
	form.eMailChk.value = form.eMailChk.value.trim();

	if (form.name.value.length == 0) {
		alert('이름을 입력 해주세요');
		form.name.focus();
		return false;
	}

	if (form.sex.value !== '0' && form.sex.value !== '1') {
		alert('성별을 선택 해주세요');
		form.sex.focus();
		return false;
	}

	if (form.nickName.value.length == 0) {
		alert('닉네임을 입력 해주세요');
		form.nickName.focus();
		return false;
	}

	if (form.nickName.value != validNickName) {
		alert('[ ' + form.nickName.value + ' ] 은(는) 사용할 수 없는 닉네임입니다.');
		form.nickName.value = '';
		form.nickName.focus();
		return false;
	}

	if (form.phoneNumber.value.length == 0) {
		alert('핸드폰 번호를 입력 해주세요');
		form.phoneNumber.focus();
		return false;
	}

	if (form.phoneNumber.value != validPhoneNumber) {
		alert('[ ' + form.phoneNumber.value + ' ] 은(는) 이미 가입된 번호입니다.');
		form.phoneNumber.value = '';
		form.phoneNumber.focus();
		return false;
	}

	if (form.loginId.value.length == 0) {
		alert('아이디를 입력 해주세요');
		form.loginId.focus();
		return false;
	}

	if (form.loginId.value != validLoginId) {
		alert('[ ' + form.loginId.value + ' ] 은(는) 사용할 수 없는 아이디입니다.');
		form.loginId.value = '';
		form.loginId.focus();
		return false;
	}

	if (form.loginPw.value.length == 0) {
		alert('비밀번호를 입력 해주세요');
		form.loginPw.focus();
		return false;
	}

	if (form.loginPw.value != form.loginPwChk.value) {
		alert('비밀번호가 일치하지 않습니다');
		form.loginPw.value = '';
		form.loginPwChk.value = '';
		form.loginPw.focus();
		return false;
	}

	if (form.eMail.value.length == 0) {
		alert('이메일을 입력 해주세요');
		form.eMail.focus();
		return false;
	}

	if (form.eMail.value != validEMail) {
		alert('[ ' + form.eMail.value + ' ] 은(는) 이미 가입된 이메일입니다.');
		form.eMail.value = '';
		form.eMail.focus();
		return false;
	}

	return true;
}

function selectSex(el, sex) {
	document.querySelectorAll('.sex-btn').forEach(btn => {
		btn.classList.remove('active');
	});

	el.classList.add('active');

	document.getElementById('sexInput').value = sex;
}

const nickNameDupChk = function(el) {
	el.value = el.value.trim();

	let nickNameDupChkMsg = $('#nickNameDupChkMsg');

	if (el.value.length == 0) {
		nickNameDupChkMsg.removeClass('text-green-500');
		nickNameDupChkMsg.addClass('text-red-500');
		nickNameDupChkMsg.html('닉네임을 입력 해주세요');
		return;
	}

	$.ajax({
		url: '/usr/member/nickNameDupChk',
		type: 'GET',
		data: {
			nickName: el.value
		},
		dataType: 'json',
		success: function(data) {
			if (data.success) {
				nickNameDupChkMsg.removeClass('text-red-500');
				nickNameDupChkMsg.addClass('text-green-500');
				nickNameDupChkMsg.html(`${data.rsMsg}`);
				validNickName = el.value;
			} else {
				nickNameDupChkMsg.removeClass('text-green-500');
				nickNameDupChkMsg.addClass('text-red-500');
				nickNameDupChkMsg.html(`${data.rsMsg}`);
				validNickName = null;
			}
		},
		error: function(_xhr, _status, error) {
			console.log(error);
		}
	})
}

const phoneNumberDupChk = function(el) {
	el.value = el.value.trim();

	let phoneNumberDupChkMsg = $('#phoneNumberDupChkMsg');

	if (el.value.length == 0) {
		phoneNumberDupChkMsg.removeClass('text-green-500');
		phoneNumberDupChkMsg.addClass('text-red-500');
		phoneNumberDupChkMsg.html('핸드폰번호를 입력 해주세요');
		return;
	}

	$.ajax({
		url: '/usr/member/phoneNumberDupChk',
		type: 'GET',
		data: {
			phoneNumber: el.value
		},
		dataType: 'json',
		success: function(data) {
			if (data.success) {
				phoneNumberDupChkMsg.removeClass('text-red-500');
				phoneNumberDupChkMsg.addClass('text-green-500');
				phoneNumberDupChkMsg.html(`${data.rsMsg}`);
				validPhoneNumber = el.value;
			} else {
				phoneNumberDupChkMsg.removeClass('text-green-500');
				phoneNumberDupChkMsg.addClass('text-red-500');
				phoneNumberDupChkMsg.html(`${data.rsMsg}`);
				validPhoneNumber = null;
			}
		},
		error: function(_xhr, _status, error) {
			console.log(error);
		}
	})
}

const loginIdDupChk = function(el) {
	el.value = el.value.trim();

	let loginIdDupChkMsg = $('#loginIdDupChkMsg');

	if (el.value.length == 0) {
		loginIdDupChkMsg.removeClass('text-green-500');
		loginIdDupChkMsg.addClass('text-red-500');
		loginIdDupChkMsg.html('아이디를 입력 해주세요');
		return;
	}

	$.ajax({
		url: '/usr/member/loginIdDupChk',
		type: 'GET',
		data: {
			loginId: el.value
		},
		dataType: 'json',
		success: function(data) {
			if (data.success) {
				loginIdDupChkMsg.removeClass('text-red-500');
				loginIdDupChkMsg.addClass('text-green-500');
				loginIdDupChkMsg.html(`${data.rsMsg}`);
				validLoginId = el.value;
			} else {
				loginIdDupChkMsg.removeClass('text-green-500');
				loginIdDupChkMsg.addClass('text-red-500');
				loginIdDupChkMsg.html(`${data.rsMsg}`);
				validLoginId = null;
			}
		},
		error: function(_xhr, _status, error) {
			console.log(error);
		}
	})
}

const eMailDupChk = function(el) {
	el.value = el.value.trim();

	let eMailDupChkMsg = $('#eMailDupChkMsg');

	if (el.value.length == 0) {
		eMailDupChkMsg.removeClass('text-green-500');
		eMailDupChkMsg.addClass('text-red-500');
		eMailDupChkMsg.html('이메일을 입력 해주세요');
		return;
	}

	$.ajax({
		url: '/usr/member/eMailDupChk',
		type: 'GET',
		data: {
			eMail: el.value
		},
		dataType: 'json',
		success: function(data) {
			if (data.success) {
				eMailDupChkMsg.removeClass('text-red-500');
				eMailDupChkMsg.addClass('text-green-500');
				eMailDupChkMsg.html(`${data.rsMsg}`);
				validEMail = el.value;
			} else {
				eMailDupChkMsg.removeClass('text-green-500');
				eMailDupChkMsg.addClass('text-red-500');
				eMailDupChkMsg.html(`${data.rsMsg}`);
				validEMail = null;
			}
		},
		error: function(_xhr, _status, error) {
			console.log(error);
		}
	})
}

$(document).ready(function () {
  // 댓글의 ... 버튼 눌렀을 때 토글 메뉴 열기/닫기
  $(document).on('click', '.memberprofile-box', function (e) {
    e.stopPropagation(); // 문서 클릭 이벤트 방지

    const $menu = $(this).siblings('.memberprofile-btn');

    // 다른 열려 있는 메뉴 닫기
    $('.memberprofile-btn').not($menu).hide();

    // 현재 메뉴 토글
    $menu.toggle();
  });

  // 메뉴 바깥 클릭 시 모두 닫기
  $(document).on('click', function () {
    $('.memberprofile-btn').hide();
  });

  // 메뉴 안쪽 클릭 시 닫히는 것 방지
  $(document).on('click', '.memberprofile-btn', function (e) {
    e.stopPropagation();
  });
});