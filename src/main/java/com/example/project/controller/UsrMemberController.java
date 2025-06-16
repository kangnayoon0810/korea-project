package com.example.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project.dto.LoginedMember;
import com.example.project.dto.Member;
import com.example.project.dto.Req;
import com.example.project.dto.ResultData;
import com.example.project.service.MemberService;
import com.example.project.util.Util;

@Controller
public class UsrMemberController {

	private MemberService memberService;
	private Req req;

	public UsrMemberController(MemberService memberService, Req req) {
		this.memberService = memberService;
		this.req = req;

	}

	@GetMapping("/usr/member/signup")
	public String signup(Model model, int authLevel) {
		
		model.addAttribute("authLevel", authLevel);
		
		return "usr/member/signup";
	}

	@PostMapping("/usr/member/doSignUp")
	@ResponseBody
	public String doSignUp(String name, int sex, String nickName, int phoneNumber, String loginId, String loginPw, String eMail, int authLevel) {

		this.memberService.signupMember(name, sex, nickName, phoneNumber, loginId, loginPw, eMail, authLevel);
		
		int memberId = this.memberService.getLastInsertId();
		
		this.memberService.insertDefaultProfileImg(memberId);
		
		if (authLevel == 2) {
			return Util.jsReplace(String.format("[ %s ] 님의 트레이너 가입이 완료되었습니다", nickName), "/");
		}

		return Util.jsReplace(String.format("[ %s ] 님의 회원 가입이 완료되었습니다", nickName), "/");
	}

	@GetMapping("/usr/member/nickNameDupChk")
	@ResponseBody
	public ResultData nickNameDupChk(String nickName) {

		Member member = this.memberService.getMemberByNickName(nickName);

		if (member != null) {
			return ResultData.from("F-1", String.format("[ %s ] 은(는) 이미 사용중인 닉네임입니다", nickName));
		}

		return ResultData.from("S-1", String.format("[ %s ] 은(는) 사용가능한 닉네임입니다", nickName));
	}

	@GetMapping("/usr/member/phoneNumberDupChk")
	@ResponseBody
	public ResultData phoneNumberDupChk(int phoneNumber) {

		Member member = this.memberService.getMemberByPhoneNumber(phoneNumber);

		if (member != null) {
			return ResultData.from("F-1", String.format("[ %d ] 은(는) 이미 가입된 번호입니다", phoneNumber));
		}

		return ResultData.from("S-1", String.format("[ %d ] 은(는) 사용가능한 번호입니다", phoneNumber));
	}

	@GetMapping("/usr/member/loginIdDupChk")
	@ResponseBody
	public ResultData loginIdDupChk(String loginId) {

		Member member = this.memberService.getMemberByLoginId(loginId);

		if (member != null) {
			return ResultData.from("F-1", String.format("[ %s ] 은(는) 이미 사용중인 아이디입니다", loginId));
		}

		return ResultData.from("S-1", String.format("[ %s ] 은(는) 사용가능한 아이디입니다", loginId));
	}

	@GetMapping("/usr/member/eMailDupChk")
	@ResponseBody
	public ResultData eMailDupChk(String eMail) {

		Member member = this.memberService.getMemberByEMail(eMail);

		if (member != null) {
			return ResultData.from("F-1", String.format("[ %s ] 은(는) 이미 가입된 이메일입니다", eMail));
		}

		return ResultData.from("S-1", String.format("[ %s ] 은(는) 사용가능한 이메일입니다", eMail));
	}

	@GetMapping("/usr/member/login")
	public String login() {
		return "usr/member/login";
	}

	@PostMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {

		Member member = this.memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Util.jsReplace(String.format("[ %s ] 은(는) 존재하지 않는 아이디입니다", loginId), "login");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Util.jsReplace("비밀번호가 일치하지 않습니다", "login");
		}

		this.req.login(new LoginedMember(member.getId(), member.getAuthLevel(), member.getNickName(), member.getName(),member.getEMail()));

		return Util.jsReplace(String.format("[ %s ] 님 환영합니다", member.getNickName()), "/");
	}

	@GetMapping("/usr/member/logout")
	@ResponseBody
	public String logout() {

		this.req.logout();

		return Util.jsReplace("로그아웃 되었습니다", "/");
	}
	
	@GetMapping("/usr/member/getLoginId")
	@ResponseBody
	public String getLoginId() {
		return this.memberService.getLoginId(this.req.getLoginedMember().getId());
	}
}