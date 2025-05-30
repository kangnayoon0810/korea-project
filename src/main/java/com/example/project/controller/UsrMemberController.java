package com.example.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project.util.Util;
import com.example.project.dto.LoginedMember;
import com.example.project.dto.Member;
import com.example.project.dto.ResultData;
import com.example.project.dto.Req;
import com.example.project.service.MemberService;

@Controller
public class UsrMemberController {
	
	private MemberService memberService;
	private Req req;
	
	public UsrMemberController(MemberService memberService, Req req) {
		this.memberService = memberService;
		this.req = req;
		
	}
	
	@GetMapping("/usr/member/signup")
	public String signup() {
		return "usr/member/signup";
	}
	
	@PostMapping("/usr/member/doSignup")
	@ResponseBody
	public String doSignup(String name, String nickName, int phoneNumber, String loginId, String loginPw, String eMail) {

		this.memberService.signupMember(name, nickName, phoneNumber, loginId, loginPw, eMail);

		return Util.jsReplace(String.format("[ %s ] 님의 가입이 완료되었습니다", name), "/");
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
	
	@GetMapping("/usr/member/nickNameDupChk")
	@ResponseBody
	public ResultData nickNameDupChk(String nickName) {

		Member member = this.memberService.getMemberByNickName(nickName);

		if (member != null) {
			return ResultData.from("F-1", String.format("[ %s ] 은(는) 이미 사용중인 닉네임입니다", nickName));
		}

		return ResultData.from("S-1", String.format("[ %s ] 은(는) 사용가능한 닉네임입니다", nickName));
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

		this.req.login(new LoginedMember(member.getId(), member.getAuthLevel()));

		return Util.jsReplace(String.format("[ %s ] 님 환영합니다", member.getNickName()), "/");
	}

	@GetMapping("/usr/member/logout")
	@ResponseBody
	public String logout() {

		this.req.logout();

		return Util.jsReplace("로그아웃 되었습니다", "/");
	}
}
