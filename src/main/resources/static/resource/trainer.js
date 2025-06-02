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
	form.phoneNumber.value = form.phoneNumber.value.trim();
	form.phoneNumberChk.value = form.phoneNumberChk.value.trim();
	form.loginId.value = form.loginId.value.trim();
	form.loginPw.value = form.loginPw.value.trim();
	form.loginPwChk.value = form.loginPwChk.value.trim();
	form.eMail.value = form.eMail.value.trim();
	form.eMailChk.value = form.eMailChk.value.trim();

	if (form.name.value.length == 0) {
		alert('이름을 입력 해주세요');
		form.nickName.focus();
		return false;
	}

	if (form.sex.value.length == 0) {
		alert('성별을 선택 해주세요');
		form.sex.focus();
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
		url: '/usr/member/eMailDupChkMsg',
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