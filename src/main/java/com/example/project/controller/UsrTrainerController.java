package com.example.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project.dto.Req;
import com.example.project.dto.ResultData;
import com.example.project.dto.Trainer;
import com.example.project.service.TrainerService;
import com.example.project.util.Util;

@Controller
public class UsrTrainerController {
	private TrainerService trainerService;
	private Req req;

	public UsrTrainerController(TrainerService trainerService, Req req) {
		this.trainerService = trainerService;
		this.req = req;

	}

	@GetMapping("/usr/trainer/signup")
	public String signup() {
		return "usr/trainer/signup";
	}

	@PostMapping("/usr/trainer/doSignUp")
	@ResponseBody
	public String doSignUp(String name, int sex, int phoneNumber, String loginId, String loginPw, String eMail) {

		this.trainerService.signupTrainer(name, sex, phoneNumber, loginId, loginPw, eMail);

		return Util.jsReplace(String.format("[ %s ] 님의 가입이 완료되었습니다", name), "/");
	}

	@GetMapping("/usr/trainer/phoneNumberDupChk")
	@ResponseBody
	public ResultData phoneNumberDupChk(int phoneNumber) {

		Trainer trainer = this.trainerService.getTrainerByPhoneNumber(phoneNumber);

		if (trainer != null) {
			return ResultData.from("F-1", String.format("[ %d ] 은(는) 이미 가입된 번호입니다", phoneNumber));
		}

		return ResultData.from("S-1", String.format("[ %d ] 은(는) 사용가능한 번호입니다", phoneNumber));
	}

	@GetMapping("/usr/trainer/loginIdDupChk")
	@ResponseBody
	public ResultData loginIdDupChk(String loginId) {

		Trainer trainer = this.trainerService.getTrainerByLoginId(loginId);

		if (trainer != null) {
			return ResultData.from("F-1", String.format("[ %s ] 은(는) 이미 사용중인 아이디입니다", loginId));
		}

		return ResultData.from("S-1", String.format("[ %s ] 은(는) 사용가능한 아이디입니다", loginId));
	}

	@GetMapping("/usr/trainer/eMailDupChk")
	@ResponseBody
	public ResultData eMailDupChk(String eMail) {

		Trainer trainer = this.trainerService.getTrainerByEMail(eMail);

		if (trainer != null) {
			return ResultData.from("F-1", String.format("[ %s ] 은(는) 이미 가입된 이메일입니다", eMail));
		}

		return ResultData.from("S-1", String.format("[ %s ] 은(는) 사용가능한 이메일입니다", eMail));
	}

	@GetMapping("/usr/trainer/login")
	public String login() {
		return "usr/trainer/login";
	}

	@PostMapping("/usr/trainer/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {

		Trainer trainer = this.trainerService.getTrainerByLoginId(loginId);

		if (trainer == null) {
			return Util.jsReplace(String.format("[ %s ] 은(는) 존재하지 않는 아이디입니다", loginId), "login");
		}

		if (trainer.getLoginPw().equals(loginPw) == false) {
			return Util.jsReplace("비밀번호가 일치하지 않습니다", "login");
		}

		return Util.jsReplace(String.format("[ %s ] 님 환영합니다", trainer.getName()), "/");
	}

	@GetMapping("/usr/trainer/logout")
	@ResponseBody
	public String logout() {

		this.req.logout();

		return Util.jsReplace("로그아웃 되었습니다", "/");
	}
}